//const char IDARRAY[] = "MOM Test Box";
const char IDARRAY[] = "Just an Arduino";
const long BAUDRATE = 250000;
const uint8_t NINITIALIZE = 4; //Number of times to try connecting to GUI until instead booting using default settings
const boolean NOSERIAL = true; //If the device boots into default configuration due to no serial, turn off serial

#include <SPI.h>

//Analog pin ID constants - PORTC
//const uint8_t INTEMP = 0; //A0 - Temp - Input
//const uint8_t OUTTEMP = 1; //A1 - Temp - Output
//const uint8_t EXTTEMP = 2; //A2 - Temp - LED
const uint8_t ANADIODE = 3; //A3 - Analog Input 1 (diode)
const uint8_t ANARAW = 4; //A4 - Analog Input 2
const uint8_t POT = 5; //A5 - Potentiometer

// Define various ADC prescaler
//const unsigned char PS_2 = (1 << ADPS0); //Does not seem to work, ADC stops.
const unsigned char PS_4 = (1 << ADPS1);
//const unsigned char PS_8 = (1 << ADPS1) | (1 << ADPS0);
//const unsigned char PS_16 = (1 << ADPS2);
//const unsigned char PS_32 = (1 << ADPS2) | (1 << ADPS0);
//const unsigned char PS_64 = (1 << ADPS2) | (1 << ADPS1);
const unsigned char PS_128 = (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0); //Default pre-scaler in Arduino

//Packet structure is: byte(0) STARTBYTE -> byte(1) packet identifier -> byte(2) packet total length -> byte(3) checksum (data only, excluding header) -> byte(4-n) data packet;
const uint8_t STARTBYTE = 0; //Identifies start of packet
const uint8_t IDPACKET = 1; //Identifies packet as device identification packet
const uint8_t STATUSPACKET = 6; //Identifies packet as temperature recordings and panel status - also is number of data bytes in packet
const uint8_t FAULTPACKET = 10; //Identifies packet as driver entering or exiting fault state - or if received, then commanding driver to enter fault state (i.e. fault test)
const uint8_t RESETPACKET = 11; //Identifies packet commanding driver to reset
const uint8_t DISCONNECTPACKET = 12; //Identifies packet commanding driver to reset
const uint8_t SETUPPACKET = 28; //Identifies packet as receiving setup configuration information - also is number of data bytes in packet
const uint8_t HEADER = 4; //Indentifies length of header
const uint8_t WAVEPACKET = 250+HEADER; //Identifies packet as recorded analog waveform - also is number of bytes in packet
const uint8_t IDSIZE = sizeof(IDARRAY) + HEADER; //Size of ID packet
const uint8_t SETUPSIZE = SETUPPACKET+HEADER; //Expected size of recieved setup packet, see byte order below:
const uint8_t COMMANDSIZE = 1+HEADER; //Commands are just one byte in length after the header
const long TIMEOUT = (long) (((1000/(float) BAUDRATE)*(64*8)) + 1000); //Wait the expected time needed to fill the serial buffer (64 bytes in size) plus a fixed delay of 0.1s to allow the GUI to respond

//Setup variables
uint8_t WARNTEMP[] = {98, 98, 98}; //warn temps, warn of overheating at 60oC (60oC = 98 on 8-bit ADC)
uint8_t FAULTTEMP[] = {66, 66, 66}; //fault temps. enter fault at 80oC (80oC = 66 on 8-bit ADC)
uint16_t ONDELAY = 0; //Delay from previous event before LED is turned on
uint16_t OFFDELAY = 0; //Delay from previous event before LED is turned off
boolean DELAYORDER = 0; //Order of delays before trigger (0 = LED starts off, 1 = LED starts on);
boolean DELAYUNITS = 0; //us or ms delay - confocal sync will always use us - us is also capped at 16383 (0 = us; 1 = ms)
uint8_t FANMINTEMP = 173; //LED temp at which the PWM fan runs at minimum speed, - default to room temp (25oC = 173 on 8-bit ADC)
uint8_t FANMAXTEMP = WARNTEMP[0]; //LED temp above which the PWM fan runs at maximum speed, - default to warn temp  
uint8_t TRIGGER = 0; //trigger (0=toggle, 1=analog, 2=digital, 3=digital activates analog - such as shutter open then trigger off of fast mirror)
uint8_t ANALOGSEL = 3; //(analog select (3 = diode, 4 = raw) 
uint8_t FAULTLED = B00000100; //Alarm to alert to warning temperature (0=false, 4=true)
uint8_t FAULTVOLUME = 127; //Volume of alarm to alert to fault temperature (0 = min, 127 = max);
uint8_t STARTVOLUME = 10; //Volume of short tone upon initializing (0 = min, 127 = max);
boolean PWMFAN = 0; //Digital I/O as PWM fan controller (0=N/A, 1=on)
uint8_t FANPIN = 0; //Which digital ouput to use to drive the fan (0=N/A, 32=I/O 1, 64=I/O 2)
boolean SYNCTYPE = 0; //sync type (0=regular, 1=confocal sync (pipeline syncs through fast routines)
boolean DTRIGGERPOL = 0; //digital trigger polarity (0 = High, 1 = Low)
boolean ATRIGGERPOL = 0; //analog trigger polarity (0 = Rising, 1 = Falling)
boolean LEDSOURCE = 0; //LED intensity signal source (0 = Ext source, 1 = AWG source)
boolean TRIGHOLD = 0; //trigger hold (0 = single shot, 1 = repeat until trigger resets), 
boolean AWGSOURCE = 0; //AWG source (0=rxPacket, 1=mirror the intensity knob),             
uint8_t SYNCOUT = 0; //Digital I/O 2 as sync out (0=false, 64=true)

//Packet structure is: byte(0) STARTBYTE -> byte(1) packet identifier -> byte(2) packet total length -> byte(3) checksum (data only, excluding header) -> byte(4-n) data packet;
//Maximum data packet size is 252 bytes (256 bytes - 4 bytes for header)
uint8_t checkSum = 0; //byte for verifying data integrity
uint8_t txPacket[64]; //Array for storing data packets to be sent to GUI - start of packet is {0, 0}
uint8_t rxBuffer[256]; //Array for storing data stream from GUI or saving as wave measurement
uint8_t rxIndex = 0; //Index for placing next received byte in the rx circular buffer
uint8_t rxStart = 0; //Index for start of packet in rx buffer
boolean initialized = false; //Whether device has received initialization intructions from GUI
uint8_t taskIndex = 0; //Index for recording current position in background tasks 0-2 - record temperatures, 3 - record knob, 4 - sync status (on/off), 5-toggle switch, 6-build header, 7-17 - send byte[n-7]
uint8_t event = 0; //Flag for whether an event happened within the interrupt that needs to be taken care of - 1 - serial event, 2 - toggle event, 3 - failsafe event

//Other  variables
int a = 0; //Dummy int counter
uint8_t counter = 0; //Dummy 8-bit counter
boolean syncStatus = false; //Flag for tracking if actively triggering LED or in standby
uint8_t toggleSwitch = 0; //FLag for tracking position of toggle switch - B00000000 = off, B00000100 = on
volatile boolean updateStatus = false; //Flag set by interrupt to check status - volatile variable as it resides in an interrupt
uint8_t nTry = 0; //Number of sttempts made at connecting to GUI

//PORT D: USB, Switches, Digital I/O
//0 - USB RX
//1 - USB TX
//2 - Toggle Switch
//3 - Analog Switch 1 (PWM)
//4 - Analog Switch 2
//5 - Digital I/O 1
//6 - Digital I/O 2
//7 - +5V Supply

//PORTB: Digital Pot, Alarm
//8 - CS
//9 - Digital Pot Input (PWM)
//10 - Warning LED
//11 - MOSI
//12 - Warning Buzzer
//13 - CLK

void(* resetPacket) (void) = 0;  //declare reset fuction at address 0 - calling this allows setup code to re-run

union //For converting between uint16_t and pair of uint8_t (to allow sending and receiving uint16_t data over serial)
{
   uint16_t value;
   uint8_t bValue[2];
} bytesToUint16;

// Interrupt is called once a millisecond, when no in scan sync
SIGNAL(TIMER0_COMPA_vect) 
{
  updateStatus = true; //Set status flag to true to indicate status should be checked (1 ms has passed)
}

void setup() {
  // set up the ADC
  ADCSRA &= ~PS_128;  // remove bits set by Arduino library
  ADCSRA |= PS_4;    //Sets sample rate to 308kHz - best temporal precision for 1-10kHz mirror
  DIDR0 = B11111111; //Turns off digital input on pins A0-A5 (PORTC) to decrease noise to ADC and current load
  
  //Configure digital pins
  DDRB |= B00111111; //Set all pins as output
  PORTB &= B11000000; //Set all pins low
  DDRD |= B11111000; //Set all pins but USB and toggle switch as output

  //Configure analog switch to negative supply so that LED stays off during initialization
  PORTD |= B10011000; //Set pins 3, 4 and 7 high

  //Configure Timer0 to send an intterupt every 1 ms - https://learn.adafruit.com/multi-tasking-the-arduino-part-2/timers
  TIMSK0 &= ~_BV(OCIE0A); //Disable compare A interrupts if using confocal sync - turn off auto-interrupts for initialization so that they do not currupt startup sequence
  //TIMSK0 |= _BV(OCIE0A); //Otherwise set interrupt to "Compare A" if not d

  Serial.begin(BAUDRATE);
  Serial.setTimeout(TIMEOUT); 
  initializeDevice();
}

void loop() {
  //Check event status - 1 - serial event, 2 - toggle event, 3 - failsafe event
  if(updateStatus) checkStatus();
  if(event){
    if(event == 1) processReceivedPackets();
    if(event == 2);//----------------------------------------------------------------------------------------------------------HANDLE TOGGLE EVENT-------------------------------------------------------------------------
    if(event == 3) failSafe();
  }
  delay(1);
}

void initializeDevice(){
  initialized = false;
  nTry = NINITIALIZE;
  while(Serial.available()) Serial.read(); //Flush all remaining bytes from input buffer
  while(!initialized){ //Repeat initialization until a successful initialization 
    while(Serial.read() && nTry){ //Keep sending header until 0 is received (no data = -1 which is "true") or counter reaches 0;
      for(a=HEADER; a<IDSIZE; a++) txPacket[a] = IDARRAY[a-HEADER]; //Load ID into txPacket
      buildPacket(IDPACKET, IDSIZE); //Add header
      Serial.write(txPacket, IDSIZE); //Send assembled data packet to GUI
      packetError();
      nTry--;
    }
    if(!initialized && !nTry){ //If a valid setup packet was not found after n tries, use default values
      checkSetup(); //make sure default values are valid, and boot from them
      if(initialized && NOSERIAL) Serial.end(); //If default is valid and no serial is requested in manual mode, turn off serial
      nTry = NINITIALIZE; //Reset the retry counter
    }
    else processReceivedPackets(); //If there was a successful connection, try and get the incoming setup packet or disconnect packet
  }

  //Once initialized, turn on interrupts to begin monitoring the device
  TIMSK0 |= _BV(OCIE0A);

  //Disable serial if in manual mode and NOSERIAL is true
  
  
  //ADCs tend to read high on reboot, so take a set of dummy reads to calibrate them
  counter = 18;
  while(counter){
    analogRead(a%3);
    analogRead(a%3);
    delay(100);
    counter--;
  }
}

//Index for recording current position in background tasks 0-2 - record temperatures, 3 - record knob, 4 - sync status (on/off), 5-toggle switch, 6-build header, 7-17 - send byte[n-7]
void checkStatus(){
  taskIndex++; //Increment task index
  updateStatus = false; //Reset status flag
  if(SYNCTYPE) interrupts(); //Turn interrupts back on if in confocal mode - needed for serial communication
  if(taskIndex >= 0 && taskIndex <= 2){ //Record temperature - 12us
    analogRead(taskIndex); //Refresh ADC
    txPacket[HEADER + taskIndex] = analogRead(taskIndex)>>2; //Get temperature reading and convert to 8-bit
  }
  else if(taskIndex == 3){ //Get intensity knob position - 12us
    analogRead(POT);
    txPacket[HEADER + taskIndex] = analogRead(POT);
  }
  else if(taskIndex > STATUSPACKET && taskIndex <= (2*STATUSPACKET+HEADER)){ //6us
    Serial.write(txPacket[taskIndex - STATUSPACKET - 1]);
  }
  else if(taskIndex == 4){ //Perform all fast tasks as one set
    txPacket[HEADER + taskIndex++] = syncStatus;
    txPacket[HEADER + taskIndex] = PIND & B00000100; //Check toggle switch
    if(txPacket[4] > FAULTTEMP[0] && txPacket[5] > FAULTTEMP[1] && txPacket[6] > FAULTTEMP[2]) event = 3; //Check whether device is overheating and enter failsafe if it is
    buildPacket(STATUSPACKET, STATUSPACKET);
  }
  //For remainder of checks monitor toggle switch and serial alternately to prevent over-riding event flags if both happen synchronously
  else if(taskIndex%2){ //Check for received serial packet
    if (Serial.available()) event = 1; //Set event flag to check rx serial buffer if data is available
  }
  else{ //Monitor for change in toggle switch
    if(toggleSwitch ^ (PIND & B00000100)){
      toggleSwitch = (PIND & B00000100); 
      event = 2;
    } 
  }
  if(SYNCTYPE) noInterrupts(); //Turn interrupts back off if in confocal mode - removes 5us jitter in sync timing
}

//Assemble header onto packet
//Packet structure is: byte(0) STARTBYTE -> byte(1) packet identifier -> byte(2) packet total length -> byte(3) checksum (data only, excluding header) -> byte(4-n) data packet;
void buildPacket(uint8_t identifier, uint8_t packetSize){
  checkSum = 0; //Initialize the checksum
  txPacket[0] = STARTBYTE;
  txPacket[1] = identifier; //Add identifier to data packet
  txPacket[2] = packetSize; //Add packet length to data packet
  for(a=HEADER; a<packetSize; a++) checkSum += txPacket[a]; //Calculate checksum
  txPacket[3] = checkSum; //Add checksum to data packet
}

//To minimize lag, retrieve only one byte per call, then scan for valid packet.
//byte(0) STARTBYTE -> byte(1) packet identifier -> byte(2) packet length -> byte(3) checksum -> byte(4-n) data packet;
//const uint8_t STARTBYTE = 0; //Identifies start of packet
//const uint8_t IDPACKET = 1; //Identifies packet as device identification packet
//const uint8_t STATUSPACKET = 6; //Identifies packet as temperature recordings - also is number of data bytes in packet
//const uint8_t FAULTPACKET = 10; //Identifies packet as driver entering or exiting fault state - or if received, then commanding driver to enter fault state (i.e. fault test)
//const uint8_t RESETPACKET = 11; //Identifies packet commanding driver to reset
//const uint8_t DISCONNECTPACKET = 12; //Identifies packet commanding driver to reset
//const uint8_t WAVEPACKET = 252; //Identifies packet as recorded analog waveform

void processReceivedPackets(){
  uint8_t packetLength = 0;
  if(!initialized){
    packetLength = Serial.readBytes(rxBuffer, 64); //If not initialized, retrieve the entire rx serial buffer
    if(packetLength >= HEADER+1){ //If minimum number of necessary bytes were recieved, check buffer for setup packet
      for(a=0; a<=(packetLength-HEADER-1); a++){ //Search for valid header in packet
        if(!rxBuffer[a]){ //If start byte is found, check for valid packet
          if(rxBuffer[a+1] == SETUPPACKET && rxBuffer[a+2] == SETUPSIZE && a <= (packetLength - SETUPSIZE + 1)){ //if packet has valid status packet header - parse packet
             rxStart = a; //Initialize rxStart to current index
             rxIndex = a; //Initialize rxIndex to current index (will slide rxIndex to end of packet during confrimation process)
             setupPacket();
             return; //Break loop if setup packet is found
          }
          //Otherwise, if a command of disconnect is received (i.e. GUI initialization) then wait in standby
          else if(rxBuffer[a+1] == DISCONNECTPACKET && rxBuffer[a+2] == COMMANDSIZE && rxBuffer[a+3] == DISCONNECTPACKET && rxBuffer[a+4] == DISCONNECTPACKET && a <= (packetLength - COMMANDSIZE)) driverStandby();
        }
      }
    }
  }
  else{
    rxBuffer[rxIndex] = Serial.read(); //Otherwise, load single byte into circular buffer
    packetLength = rxIndex - rxStart;
    if(rxIndex == rxStart && rxBuffer[rxIndex++]) rxStart = rxIndex; //If start of packet is not yet found (either leading 0x00 or rxIndex != rxStart) then move the start point one increment forward as well 
    else if(packetLength == COMMANDSIZE){ //If packet is proper comand length, check for valid header - 
      //Packet structure is: byte(0) STARTBYTE -> byte(1) packet identifier -> byte(2) packet total length -> byte(3) checksum (data only, excluding header) -> byte(4-n) data packet;
      if(rxBuffer[rxStart] == 0 && rxBuffer[rxStart+1] == rxBuffer[rxStart+HEADER] && rxBuffer[rxStart+2] == COMMANDSIZE && rxBuffer[rxStart+3] == rxBuffer[rxStart+HEADER]){ //If header is valid, parse the command
        if(rxBuffer[rxStart+HEADER] == DISCONNECTPACKET) driverStandby(); //If disconnect is received, stop driver until reconnect resets driver.  This keeps driver from spamming serial buffer
        else if(rxBuffer[rxStart+HEADER] == RESETPACKET) resetPacket(); //If reset command is received, set program line index to and reinitialize driver without hard reset
        else if(rxBuffer[rxStart+HEADER] == FAULTPACKET){ //If fault command is received, enter failsafe (i.e. failsafe test).
          failSafe();
          rxStart = rxIndex; //Move start point to current index to flag that no packet is active, and start next packet search at end of current packet
        }
        else rxStart++; //If the packet is invalid, move the start index over by one to scan for a valid packet via a sliding window
      }
    }
  }
}

void driverStandby(){
  PORTD |= B00011000; //Set analog swich to negative voltage output - this will force the LED off (due to rail offset - grounding the LED would still leave LED with low current)
  PORTB |= B00100000;
  Serial.end(); //Stop serial communication so Arduino does not spam output buffer
  TIMSK0 |= _BV(OCIE0A); //Turn interrupts on to continue monitoring driver temperature - and alarm if overtemp
  while(1){ //Hold until reset
    delay(1);
    checkStatus();
  }
}

//Parse the setup packet and then check if valid
void setupPacket(){
  //Confirm checksum
  checkSum = 0;
  for(a=rxStart+HEADER; a<rxStart + SETUPSIZE; a++){
    checkSum += rxBuffer[a];
  }
for(a=rxIndex; a < rxIndex+SETUPSIZE; a++) Serial.write(rxBuffer[a]);
  Serial.write(checkSum);
  Serial.write(checkSum);
  Serial.write(rxBuffer[rxStart+3]);
  Serial.write(rxBuffer[rxStart+3]);
  if(rxBuffer[rxStart+3] != checkSum) return; //If checksum is not valid, exit parsing function and continue searching for valid setup packet
  
  rxStart += HEADER; //Move the index forward to start of data
  //Use a++ as index to parse packet so that the txPacket index is automatically moved to the end of the packet since otherwise the 0 bytes within the packet can be interpreted as start indeces
  WARNTEMP[0] = rxBuffer[rxStart++]; //warn temps, warn of overheating at 60oC (60oC = 98 on 8-bit ADC)
  WARNTEMP[1] = rxBuffer[rxStart++];
  WARNTEMP[2] = rxBuffer[rxStart++];
  FAULTTEMP[0] = rxBuffer[rxStart++]; //fault temps. enter fault at 80oC (80oC = 66 on 8-bit ADC)
  FAULTTEMP[1] = rxBuffer[rxStart++];
  FAULTTEMP[2] = rxBuffer[rxStart++];
  bytesToUint16.bValue[0] = rxBuffer[rxStart++]; //Assemble uint16_t value
  bytesToUint16.bValue[1] = rxBuffer[rxStart++]; //Assemble uint16_t value
  ONDELAY = bytesToUint16.value; //Delay from previous event before LED is turned on
  bytesToUint16.bValue[0] = rxBuffer[rxStart++]; //Assemble uint16_t value
  bytesToUint16.bValue[1] = rxBuffer[rxStart++]; //Assemble uint16_t value
  OFFDELAY = bytesToUint16.value; //Delay from previous event before LED is turned off
  DELAYORDER = rxBuffer[rxStart++]; //Order of delays before trigger (0 = LED starts off, 1 = LED starts on);
  DELAYUNITS = rxBuffer[rxStart++]; //us or ms delay - confocal sync will always use us - us is also capped at 16383 (0 = us; 1 = ms)
  FANMINTEMP = rxBuffer[rxStart++]; //LED temp at which the PWM fan runs at minimum speed, - default to room temp (25oC = 173 on 8-bit ADC)
  FANMAXTEMP = rxBuffer[rxStart++]; //LED temp above which the PWM fan runs at maximum speed, - default to warn temp 
  TRIGGER = rxBuffer[rxStart++]; //trigger (0=toggle, 1=analog, 2=digital, 3=digital activates analog - such as shutter open then trigger off of fast mirror)
  ANALOGSEL = rxBuffer[rxStart++]; //analog select (3 = diode, 4 = raw) 
  FAULTLED = rxBuffer[rxStart++] & B00000100; //Alarm to alert to warning temperature (0=false, 4=true) - use bitmask for safety (protects other pins from being accidentally overwritten in the event of a bad byte)
  FAULTVOLUME = rxBuffer[rxStart++]; //Alarm to alert to fault temperature
  STARTVOLUME = rxBuffer[rxStart++]; //Volume of short tone upon initializing
  PWMFAN = rxBuffer[rxStart++]; //Digital I/O as PWM fan controller (0=N/A, 1=on)   
  FANPIN = rxBuffer[rxStart++] & B01100000; //Which digital ouput to use to drive the fan (0=N/A, 32=I/O 1, 64=I/O 2)
  SYNCTYPE = rxBuffer[rxStart++]; //sync type (0=regular, 1=confocal sync (pipeline syncs through fast routines)
  DTRIGGERPOL = rxBuffer[rxStart++]; //digital trigger polarity (0 = High, 1 = Low)
  ATRIGGERPOL = rxBuffer[rxStart++]; //analog trigger polarity (0 = Rising, 1 = Falling)
  LEDSOURCE = rxBuffer[rxStart++]; //LED intensity signal source (0 = Ext source, 1 = AWG source)
  TRIGHOLD = rxBuffer[rxStart++]; //trigger hold (0 = single shot, 1 = repeat until trigger resets), 
  AWGSOURCE = rxBuffer[rxStart++]; //AWG source (0=txPacket, 1=mirror the intensity knob),             
  SYNCOUT = rxBuffer[rxStart++] & B01000000; //Digital I/O 2 as sync out (0=false, 64=true) - use bitmask for safety (protects other pins from being accidentally overwritten in the event of a bad byte) *************CHECK: don't use a++ as next call to for-loop will also index a forward one?**********************************

  //Check that setup values are valid
  checkSetup();
}

//Check setup variables to make sure they are valid before configuring the device to them
void checkSetup(){
  for(a=0; a<3; a++){
    if(WARNTEMP[a] <= FAULTTEMP[a] || WARNTEMP[a] > 245 || FAULTTEMP[a] > 245 || WARNTEMP < 10 || FAULTTEMP < 10) return; //Setup is not valid if set temps are at the edge of the ADC range (roughly <-25oC or >180oC for standard thermistors)
  }

  //Check that packet values are valid
  if(FANMAXTEMP < FANMINTEMP && TRIGGER < 4 && (ANALOGSEL-3) < 2 && FAULTVOLUME < 128 && STARTVOLUME < 128){ //Check numerical values for validity
    if((!FAULTLED || FAULTLED == 4) && (!FANPIN || FANPIN == 32 || FANPIN == 64) && (!SYNCOUT || SYNCOUT == 64)){ //Check pin ID variables
      if(DELAYORDER < 2 && DELAYUNITS < 2 && PWMFAN < 2 && SYNCTYPE < 2 && DTRIGGERPOL < 2 && ATRIGGERPOL < 2 && LEDSOURCE < 2 && TRIGHOLD < 2 && AWGSOURCE < 2 && SYNCOUT < 2){ //Check boolean variables - d
        if((!SYNCTYPE == DELAYUNITS) || !SYNCTYPE){ //Confirm that the delay units are in us if using a confocal sync
          if((!DELAYUNITS && (ONDELAY < 16384 && OFFDELAY < 16384)) || DELAYUNITS){ //If us, make sure that value does not exceed 16383 cap - https://www.arduino.cc/reference/en/language/functions/time/delaymicroseconds/
            for(a=rxIndex; a < rxIndex+SETUPSIZE; a++) txPacket[a-rxIndex] = rxBuffer[a];
            Serial.write(txPacket, SETUPSIZE); //Send received setup back back to computer for confirmation
                        
            //If setup is valid, then initialization is successful
            initialized = true;
            SPI.end(); //End SPI so that locks on warning LED and buzzer are released
            PORTB |= FAULTLED; //Turn on warning LED
            for(a=0; a<500; a++){ //Generate tone for 0.1 seconds
              taskIndex++;  
              PORTB |= B00010000;
              delayMicroseconds(STARTVOLUME);
              PORTB &= B11101111;
              delayMicroseconds(255-STARTVOLUME);
            }
            delay(1000); //Wait for reset from GUI in case setup packet does not match
            PORTB &= B11111011; //Turn off warning LED
            SPI.begin(); //Re-start SPI  
          }
        }                    
      }
    }
  }
}

//In the event of the driver or LED overheating, fail safe automatically turns off the LED circuit until the driver/LED both cool to a safe temperature
void failSafe(){
  uint8_t TIMSK0state = TIMSK0;
  TIMSK0 &= ~_BV(OCIE0A); //Turn off interrupts - loop calls check status directly to monitor temp
  boolean fault = true;
  uint8_t PORTDstate = PORTD; //Record current state of ports so they can be restored after fault
  uint8_t PORTBstate = PORTB;
  
  
  //If fault temp is reached, enter failsafe mode until warn temp is reached
  PORTD |= B00011000; //Set analog swich to negative voltage output - this will force the LED off (due to rail offset - grounding the LED would still leave LED with low current)
  PORTB &= B11111101; //Turn off 5V input to digital pot
  SPI.end(); //End SPI so that locks on warning LED and buzzer are released
  
    
  while(fault){ //Stay in fault mode until all thermistors are recording below the warning temp
    PORTB |= FAULTLED; //Turn on warning LED
    txPacket[4]=FAULTPACKET; //Send fault packet to GUI
    buildPacket(FAULTPACKET, COMMANDSIZE);
    Serial.write(txPacket, COMMANDSIZE); //Send assembled data packet to computer
       
    for(a=0; a<3789; a++){ //Generate tone for 0.5 seconds
      checkStatus(); 
      PORTB |= B00010000;
      delayMicroseconds(FAULTVOLUME);
      PORTB &= B11101111;
      delayMicroseconds(255-FAULTVOLUME);
    }
    PORTB &= B11111011; //Turn off warning LED
    delay(500); //Wait for 0.5 seconds
    if(txPacket[4] > WARNTEMP[0] && txPacket[5] > WARNTEMP[1] && txPacket[6] > WARNTEMP[2]) fault = false; //If all thermistor temps are below the warn temperature, then exit the fault state - interrupts will update temp
  }

  SPI.begin(); //Restart SPI communication
  PORTB = PORTBstate; //Restore ports to prior configurations
  PORTD = PORTDstate;
  TIMSK0 = TIMSK0state; //Restore Timer0 interrupt settings
  taskIndex = 0; //Reset the task index
}

uint8_t adjustVolume(){//--------------------------------------------------------------------------------------------------------------FINISH INSTALLING THIS SO VOLUME CAN BE ADJUSTED USING KNOB ON PANEL----------------------------------------------------
  uint8_t volume = 0;
  PORTB |= B00000100; //Turn on warning LED
  for(a=0; a<3100; a++){ //Generate tone for 0.1 seconds
    PORTB |= B00010000;
    delayMicroseconds(volume);
    PORTB &= B11101111;
    delayMicroseconds(255-volume);
  }
  volume = (analogRead(5) >> 3);
  PORTB &= B11111011; //Turn off warning LED
  delay(500); //Wait for reset from GUI in case setup packet does not match
  return volume;
}

void packetError(){
  counter = 3;
  while(counter--){
      PORTB |= B00100100; 
      delay(500);
      PORTB &= B11000000;
      delay(500);
  }
  delay(1000);
}
