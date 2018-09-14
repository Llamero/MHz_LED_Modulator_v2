//const char IDARRAY[] = "MOM Test Box";
const char IDARRAY[] = "Just an Arduino";
const long BAUDRATE = 250000;
const long TIMEOUT = (long) (((1000/(float) BAUDRATE)*(64*8)) + 100); //Wait the expected time needed to fill the serial buffer (64 bytes in size) plus a fixed delay of 0.1s to allow the GUI to respond

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

//Serial constants
const uint8_t STARTBYTE = 0; //Identifies start of packet
const uint8_t IDPACKET = 1; //Identifies packet as device identification packet
const uint8_t STATUSPACKET = 6; //Identifies packet as temperature recordings - also is number of data bytes in packet
const uint8_t FAULTPACKET = 10; //Identifies packet as driver entering or exiting fault state - or if received, then commanding driver to enter fault state (i.e. fault test)
const uint8_t RESETPACKET = 11; //Identifies packet commanding driver to reset
const uint8_t DISCONNECTPACKET = 12; //Identifies packet commanding driver to reset
const uint8_t WAVEPACKET = 252; //Identifies packet as recorded analog waveform
const uint8_t HEADER = 4; //Indentifies length of header
const uint8_t IDSIZE = sizeof(IDARRAY); //Size of ID packet
const uint8_t SETUPSIZE = 23; //Expected size of recieved setup packet, see byte order below:

//Setup variables
//0-packet ID,
uint8_t WARNTEMP[] = {98, 98, 98}; //1:3-warn temps, warn of overheating at 60oC (60oC = 98 on 8-bit ADC)
uint8_t FAULTTEMP[] = {66, 66, 66}; //4:6-fault temps. enter fault at 80oC (80oC = 66 on 8-bit ADC)
boolean PWMFAN = 0; //7-Digital I/O 2 as PWM fan controller (0=N/A, 1=on)
uint8_t FANMINTEMP = 173; //8-LED temp at which the PWM fan runs at minimum speed, - default to room temp (25oC = 173 on 8-bit ADC)
uint8_t FANMAXTEMP = WARNTEMP[0]; //9-LED temp above which the PWM fan runs at maximum speed, - default to warn temp  
uint8_t TRIGGER = 0; //10-trigger (0=toggle, 1=analog, 2=digital, 3=digital activates analog - such as shutter open then trigger off of fast mirror)
boolean SYNCTYPE = 0; //11-sync type (0=regular, 1=confocal sync (pipeline syncs through fast routines)
boolean DTRIGGERPOL = 0; //12-digital trigger polarity (0 = High, 1 = Low)
boolean ATRIGGERPOL = 0; //13-analog trigger polarity (0 = Rising, 1 = Falling)
boolean LEDSOURCE = 0; //14-LED intensity signal source (0 = Ext source, 1 = AWG source)
boolean TRIGHOLD = 0; //15-trigger hold (0 = single shot, 1 = repeat until trigger resets), 
boolean AWGSOURCE = 0; //16-AWG source (0=txPacket, 1=mirror the intensity knob),             
uint8_t ANALOGSEL = 3; //17-(analog select (3 = diode, 4 = raw)                             
uint16_t ONDELAY = 0; //18:19-On delay
uint16_t OFFDELAY = 0; //20:21-Off delay
boolean DELAYUNIT = 0; //22-Delay units (0 = us, 1 = ms)
boolean SYNCOUT = B01000000; //23-Digital I/O 2 as sync out (0=false, 64=true)
uint8_t FAULTLED = B00000100; //24-Alarm to alert to warning temperature (0=false, 4=true)
uint8_t FAULTTONE = B00010000; //25-Alarm to alert to fault temperature (0=false, 16=true)  

//Packet structure is: byte(0) STARTBYTE -> byte(1) packet identifier -> byte(2) packet length -> byte(3) checksum -> byte(4-n) data packet;
//Maximum data packet size is 252 bytes (256 bytes - 4 bytes for header)
uint8_t checkSum = 0; //byte for verifying data integrity
uint8_t txPacket[64]; //Array for storing data packets to be sent to GUI - start of packet is {0, 0}
uint8_t rxBuffer[256]; //Array for storing data stream from GUI or saving as wave measurement
uint8_t rxIndex = 0; //Index for placing next received byte in the rx circular buffer
uint8_t rxStart = 0; //Index for start of packet in rx buffer
boolean initialized = false; //Whether device has received initialization intructions from GUI
uint8_t taskIndex = 0; //Index for recording current position in background tasks 0-2 - record temperatures, 3 - record knob, 4 - sync status (on/off), 5-toggle switch, 6-build header, 7-17 - send byte[n-7]

//Other  variables
int a = 0; //Dummy int counter
uint8_t counter = 0; //Dummy 8-bit counter
boolean syncStatus = false; //Flag for tracking if actively triggering LED or in standby

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

void setup() {

  // set up the ADC
  ADCSRA &= ~PS_128;  // remove bits set by Arduino library
  ADCSRA |= PS_4;    //Sets sample rate to 308kHz - best temporal precision for 1-10kHz mirror
  DIDR0 = B11111111; //Turns off digital input on pins A0-A5 (PORTC) to decrease noise to ADC and current load
  
  DDRB |= B00111111; //Set all pins as output
  PORTB &= B11000000; //Set all pins low
  DDRD |= B11111000; //Set all pins but USB and toggle switch as output

  //Configure analog switch to ext sync
  PORTD |= B10001000; //Set pins 3 and 7 high
  PORTD &= B11101111; //Set pin 4 low
  Serial.begin(BAUDRATE);
  Serial.setTimeout(TIMEOUT); 
  initializeDevice();
}

void loop() {
}


//Index for recording current position in background tasks 0-2 - record temperatures, 3 - record knob, 4 - sync status (on/off), 5-toggle switch, 6-build header, 7-17 - send byte[n-7]
void checkStatus(){
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
    txPacket[HEADER + taskIndex++] = PIND & B00000100;
    if(txPacket[4] > FAULTTEMP[0] && txPacket[5] > FAULTTEMP[1] && txPacket[6] > FAULTTEMP[2]) failSafe(); //Check whether device is overheating and enter failsafe if it is
    buildPacket(STATUSPACKET, STATUSPACKET);
  }
 else{ //Check for received serial packet
  if (Serial.available()){
    processReceivedPackets(); //Read packet if data is available
  }
  else{
    delayMicroseconds(3);
  }
 }
 if(SYNCTYPE) noInterrupts(); //Turn interrupts back off if in confocal mode - removes 5us jitter in sync timing
}

//Assemble header onto packet
void buildPacket(uint8_t identifier, uint8_t packetSize){
  txPacket[0] = STARTBYTE;
  txPacket[1] = packetSize; //Add packet length to data packet
  checkSum = identifier; //Add identifier to checksum
  txPacket[3] = identifier; //Add identifier to data packet
  for(a=HEADER; a<packetSize+HEADER; a++){ //Load packet and update checksum
    checkSum += txPacket[a];
  }
  txPacket[2] = checkSum; //Add checksum to data packet
}

void initializeDevice(){
  initialized = false;
  while(Serial.available()) Serial.read(); //Flush all remaining bytes from input buffer
  while(Serial.read()){ //Keep sending header until 0 is received (no data = -1 which is "true")
    for(a=0; a<IDSIZE; a++) txPacket[HEADER + a] = IDARRAY[a];
    buildPacket(IDPACKET, IDSIZE); //Keep sending ID packet until successful connection
    Serial.write(txPacket, (IDSIZE + HEADER)); //Send assembled data packet to computer
    packetError();
  }
  processReceivedPackets(); //If there was a successful connection, try and get the incoming setup packet
  
  //ADCs tend to read high on reboot, so take a set of dummy reads to calibrate them
  counter = 18;
  while(counter){
    analogRead(a%3);
    analogRead(a%3);
    delay(100);
    counter--;
  }
}

//To minimize lag, retrieve only one byte per call, then scan for valid packet.
void processReceivedPackets(){
  uint8_t packetLength = Serial.readBytes(txPacket, 64); //Retrieve the entire receive serial buffer
  for(a=0; a<packetLength; a++){ //Read through the entire buffer for valid packets
    if (txPacket[a] == 0){
      if(txPacket[a+1] == SETUPSIZE && txPacket[a+2] == 0 && !initialized && (packetLength-a) >= SETUPSIZE) setupPacket(); //If packet is correct size, has ID flag 0, and device is not initialized, it is a setup packet, and is long enough to be a setup packet
      else if(txPacket[a+1] == 1 && initialized && (packetLength-a) >= 2){ //If txPacket has length 1 then it is a command - only read command packets once initialized - ***to ensure proper indexing no command can have a value of 0***
        if(txPacket[a+2] == DISCONNECTPACKET) while(1); //If disconnect is received, stop driver until reconnect resets driver.  This keeps driver from spamming serial buffer
        else if(txPacket[a+2] == RESETPACKET) resetPacket(); //If reset command is received, set program line index to and reinitialize driver without hard reset
        else if(txPacket[a+2] == FAULTPACKET) failSafe(); //If fault command is received, enter failsafe (i.e. failsafe test).
        else packetError(); //Invalid packet
      }
      else packetError(); //Invalid packet
    }
  }
}

void setupPacket(){
  a += 3; //Move the index forward
  //Use a++ as index to parse packet so that the txPacket index is automatically moved to the end of the packet since otherwise the 0 bytes within the packet can be interpreted as start indeces
  WARNTEMP[0] = txPacket[a++]; //1:3-warn temps, warn of overheating at 60oC (60oC = 98 on 8-bit ADC)
  WARNTEMP[1] = txPacket[a++];
  WARNTEMP[2] = txPacket[a++];
  FAULTTEMP[0] = txPacket[a++]; //4:6-fault temps. enter fault at 80oC (80oC = 66 on 8-bit ADC)
  FAULTTEMP[1] = txPacket[a++];
  FAULTTEMP[2] = txPacket[a++];
  PWMFAN = txPacket[a++]; //7-Digital I/O 2 as PWM fan controller (0=N/A, 1=on)
  FANMINTEMP = txPacket[a++]; //8-LED temp at which the PWM fan runs at minimum speed, - default to room temp (25oC = 173 on 8-bit ADC)
  FANMAXTEMP = txPacket[a++]; //9-LED temp above which the PWM fan runs at maximum speed, - default to warn temp  
  TRIGGER = txPacket[a++]; //10-trigger (0=toggle, 1=analog, 2=digital, 3=digital activates analog - such as shutter open then trigger off of fast mirror)
  SYNCTYPE = txPacket[a++]; //11-sync type (0=regular, 1=confocal sync (pipeline syncs through fast routines)
  DTRIGGERPOL = txPacket[a++]; //12-digital trigger polarity (0 = High, 1 = Low)
  ATRIGGERPOL = txPacket[a++]; //13-analog trigger polarity (0 = Rising, 1 = Falling)
  LEDSOURCE = txPacket[a++]; //14-LED intensity signal source (0 = Ext source, 1 = AWG source)
  TRIGHOLD = txPacket[a++]; //15-trigger hold (0 = single shot, 1 = repeat until trigger resets), 
  AWGSOURCE = txPacket[a++]; //16-AWG source (0=txPacket, 1=mirror the intensity knob),             
  ANALOGSEL = txPacket[a++]; //17-analog select (3 = diode, 4 = raw)                               
  bytesToUint16.bValue[1] = txPacket[a++]; //Assemble uint16_t value
  bytesToUint16.bValue[0] = txPacket[a++]; //Assemble uint16_t value
  ONDELAY = bytesToUint16.value; //18:19-On delay
  bytesToUint16.bValue[1] = txPacket[a++]; //Assemble uint16_t value
  bytesToUint16.bValue[0] = txPacket[a++]; //Assemble uint16_t value
  OFFDELAY = bytesToUint16.value; //20:21-Off delay
  DELAYUNIT = txPacket[a++]; //22-Delay units (0 = us, 1 = ms)
  SYNCOUT = txPacket[a++] & B01000000; //23-Digital I/O 2 as sync out (0=false, 64=true) - use bitmask for safety (protects other pins from being accidentally overwritten in the event of a bad byte)
  FAULTLED = txPacket[a++] & B00000100; //24-Alarm to alert to warning temperature (0=false, 4=true) - use bitmask for safety (protects other pins from being accidentally overwritten in the event of a bad byte)
  FAULTTONE = txPacket[a++] & B00010000; //25-Alarm to alert to fault temperature (0=false, 16=true) - *************CHECK: don't use a++ as next call to for-loop will also index a forward one?**********************************
}

void failSafe(){
  boolean fault = true;
  uint8_t PORTDstate = PORTD; //Record current state of ports so they can be restored after fault
  uint8_t PORTBstate = PORTB;
  
  //If fault temp is reached, enter failsafe mode until warn temp is reached
  PORTD &= B11100111; //Set analog swich to high impedance (grounds non-inverting input to op-amp turning off LED)
  PORTB &= B11111101; //Turn off 5V input to digital pot
  SPI.end(); //End SPI so that locks on warning LED and buzzer are released
    
  while(fault){ //Stay in fault mode until all thermistors are recording below the warning temp
    PORTB |= FAULTLED; //Turn on warning LED
    txPacket[4]=1; //Send fault packet to GUI
    buildPacket(FAULTPACKET, 1);
    Serial.write(txPacket, (1 + HEADER)); //Send assembled data packet to computer
       
    for(a=0; a<3789; a++){ //Generate tone for 0.5 seconds
      PORTB |= FAULTTONE;
      delayMicroseconds(132);
      PORTB &= B11101111;
      delayMicroseconds(132);
    }
    PORTB |= B11111011; //Turn off warning LED
    delay(500); //Wait for 0.5 seconds
    if(txPacket[4] > WARNTEMP[0] && txPacket[5] > WARNTEMP[1] && txPacket[6] > WARNTEMP[2]) fault = false; //If all thermistor temps are below the warn temperature, then exit the fault state
  }

  SPI.begin(); //Restart SPI communication
  PORTB = PORTBstate; //Restore ports to prior configurations
  PORTD = PORTDstate;

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
