const char IDARRAY[] = "MOM Test Box";
//const char IDARRAY[] = "Just an Arduino";
const long BAUDRATE = 250000;
const uint8_t NINITIALIZE = 0; //Number of times to try connecting to GUI until instead booting using default settings
const boolean NOSERIAL = false; //If the device boots into default configuration due to no serial, turn off serial

// #### Enter parameters for line counting ###

// 190123 intensity staircase parameters (see MOM2 LED power measurements from same date. 
// Meant to be sed with DMD set at x = 15k (0 offset with 60 x objective 200 mm planar lens) and y = 10712 (centered on scan field)
//float timeArray[] = {30, 30, 60, 30, 60, 30, 60, 30, 60, 30, 60, 30, 60, 30, 60, 30, 60, 30, 60, 30, 60, 30, 60, 30, 30}; //Seconds
//uint8_t intensityArray[] = {0, 1, 0, 1, 0, 3, 0, 15, 0, 75, 0, 160, 0, 23, 0, 55, 0, 206, 0, 5, 0, 30, 0, 30, 0}; //8-bit 0-255
//float pulseDurationArray[] = {0, 0.18, 0, 0.36, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0}; //0.01 to 1

// 190625 3 stims  
float timeArray[] = {5, 5, 10, 10, 20, 20, 10}; //Seconds
uint8_t intensityArray[] = {0, 255, 0, 128, 0, 64, 0}; //8-bit 0-255
float pulseDurationArray[] = {0, 0.2, 0, 0.4, 0, 0.8, 0}; //0.01 to 1 
uint8_t ledInt = intensityArray[0]; // 8 bit, need to have switch in 'Auto' position for this to work 

// parameters for line counting
uint32_t nLine = 0; //Tracks nuber of line scans since last event
float MIRRORPERIOD = 0.0000625; //Time in seconds per line scan. for 2.96 Hz 0.00264

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
const uint8_t AWGPACKET = 13; //Identifies packet commanding change in AWG
const uint8_t SETUPPACKET = 31; //Identifies packet as receiving setup configuration information - also is number of data bytes in packet
const uint8_t HEADER = 4; //Indentifies length of header
const uint8_t WAVEPACKET = 250+HEADER; //Identifies packet as recorded analog waveform - also is number of bytes in packet
const uint8_t IDSIZE = sizeof(IDARRAY) + HEADER; //Size of ID packet
const uint8_t SETUPSIZE = SETUPPACKET+HEADER; //Expected size of recieved setup packet, see byte order below:
const uint8_t COMMANDSIZE = 1+HEADER; //Commands are just one byte in length after the header
const long INITIALTIMEOUT = (long) (((1000/(float) BAUDRATE)*(64*8)) + 100); //Wait the expected time needed to fill the serial buffer (64 bytes in size) plus a fixed delay of 0.1s to allow the GUI to respond
const long RUNTIMEOUT = (long) (((1000/(float) BAUDRATE)*(5*8)) + 1); //Wait the expected time needed to fill the serial buffer (64 bytes in size) plus a fixed delay of 0.1s to allow the GUI to respond

//Setup variables
uint8_t WARNTEMP[] = {98, 98, 98}; //warn temps, warn of overheating at 60oC (60oC = 98 on 8-bit ADC)
uint8_t FAULTTEMP[] = {50, 50, 50}; //fault temps. enter fault at 80oC (80oC = 66 on 8-bit ADC)
uint16_t DELAY1 = 0; //Delay from trigger to LED trigger state. 480 for 2.96 Hz. 960. In us 
uint16_t DELAY2 = 12; //Delay from delay 1 to LED standby state. 505 for 2.96 Hz. 1010
uint16_t DELAY3 = 12; // 815 for 2.96 Hz. 1630
uint16_t ATHRESHOLD = 5; //Threshold for analog trigger - 5=0.1 offset on MOM
boolean DELAYORDER = 0; //Order of delays before trigger (0 = LED starts off, 1 = LED starts on);
boolean DELAYUNITS = 0; //us or ms delay - confocal sync will always use us - us is also capped at 16383 (0 = us; 1 = ms)
uint8_t FANMINTEMP = 173; //LED temp at which the PWM fan runs at minimum speed, - default to room temp (25oC = 173 on 8-bit ADC)
uint8_t FANMAXTEMP = WARNTEMP[0]; //LED temp above which the PWM fan runs at maximum speed, - default to warn temp  
uint8_t TRIGGER = 2; //trigger (0=toggle, 1=analog, 2=digital - confocal uses separate digital to trigger syncing)
uint8_t ANALOGSEL = 3; //(analog select (3 = diode, 4 = raw) 
uint8_t FAULTLED = B00000100; //Alarm to alert to warning temperature (0=false, 4=true)
uint8_t FAULTVOLUME = 127; //Volume of alarm to alert to fault temperature (0 = min, 127 = max);
uint8_t STARTVOLUME = 10; //Volume of short tone upon initializing (0 = min, 127 = max);
boolean PWMFAN = 0; //Digital I/O as PWM fan controller (0=N/A, 1=on)
uint8_t FANPIN = 0; //Which digital ouput to use to drive the fan (0=N/A, 32=I/O 1, 64=I/O 2)
boolean SYNCTYPE = 1; //sync type (0=regular, 1=confocal sync (pipeline syncs through fast routines)
boolean DTRIGGERPOL = 0; //digital trigger polarity (0 = Low, 1 = High)
boolean ATRIGGERPOL = 1; //analog trigger polarity (0 = Falling, 1 = Rising)
boolean SHUTTERTRIGGERPOL = 0; //Shutter trigger polarity (0 = Low, 1 = High) - only used for confocal syncs
boolean LEDSOURCE = 1; //LED intensity signal source (0 = Ext source, 1 = AWG source)
boolean TRIGHOLD = 0; //trigger hold (0 = single shot, 1 = repeat until trigger resets), 
uint8_t AWGSOURCE = 0; //AWG source (0=rxPacket, 1=mirror the intensity knob - hold fixed during sync, 2 - live update during sync),             
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
uint8_t LEDstate0 = 0; //Variable for the state the LED is in before trigger (PORTB bitmask)
uint8_t LEDstate1 = 0; //Variable for the state the LED is in after trigger (PORTB bitmask)
uint8_t LEDstate1b = 0; //Backup of state 1 so that when LED int is 0, state 1 can be transiently switched to match state 0;
boolean fault = false; //Track whether in fault to prevent recursive call of fault state
uint8_t initialCount = 3; //Don't respond to initial status until ADCs have settled
int arraySize = 0; //Records the size of the time array
uint8_t rampIndex = 0; //Current index in time and intensity ramp arrays
uint16_t delay2 = DELAY2; //On duration - adjustable
uint16_t delay3 = DELAY3; //Delay of first on to second on - adjustable

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
  //Convert time array to nearest number of scan lines
  arraySize = sizeof(timeArray)>>2;
  for(a=0; a<arraySize; a++) timeArray[a] = round(timeArray[a]/MIRRORPERIOD);
  
  // set up the ADC
  ADCSRA &= ~PS_128;  // remove bits set by Arduino library
  ADCSRA |= PS_4;    //Sets sample rate to 308kHz - best temporal precision for 1-10kHz mirror
  DIDR0 = B11111111; //Turns off digital input on pins A0-A5 (PORTC) to decrease noise to ADC and current load
  
  //Configure digital pins
  DDRB |= B00111111; //Set all pins as output
  PORTB &= B11000010; //Set all pins low except pin 9 which powers the input to the AWG
  DDRD |= B11111000; //Set all pins but USB and toggle switch as output

  //Configure analog switch to negative supply so that LED stays off during initialization
  PORTD |= B10011000; //Set pins 3, 4 and 7 high

  //Configure Timer0 to send an intterupt every 1 ms - https://learn.adafruit.com/multi-tasking-the-arduino-part-2/timers
  TIMSK0 &= ~_BV(OCIE0A); //Disable compare A interrupts if using confocal sync - turn off auto-interrupts for initialization so that they do not currupt startup sequence
  //TIMSK0 |= _BV(OCIE0A); //Otherwise set interrupt to "Compare A" if not d

  Serial.begin(BAUDRATE);
  Serial.setTimeout(INITIALTIMEOUT);
  initializeDevice();
}

//--------------------------------------------------------------SYNCS----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//Loop will act as sync router based on toggle switch position
void loop() {
  event = 0; //Reset the event flag
  if(toggleSwitch) manualMode(); //If toggle switch is in manual mode, then revert to manual control of the LED 
  else{
    if(SYNCTYPE){ //Confocal sync pipeline - i.e. no interrupts during mirror sync - iterrupts on during standby
      DDRD &= B11011111; //Set Digital I/O 1 to input to get shutter trigger 
      if(TRIGGER == 2) DDRD &= B10011111; //If digital mirror sync, then also set digital I/O 2 to input
      confocalStandby();
    }
  }
}

//Wait for digital trigger event (usually shutter) to start mirror sync
void confocalStandby(){
  nLine = 0;
  rampIndex = 0;//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  PORTD = LEDstate0; //Set LED to standby state
  PORTD &= B10111111; //Set digital pin 6 low to flag that shutter is closed - for ephys sync
  while((boolean) (PIND & B00100000) != SHUTTERTRIGGERPOL){
    interrupts(); //Turn on interrupts to automatically manage checking status
    if(updateStatus) checkStatus();
    if(event) return; //If event is a toogle event break loop and exit function 
  }
  PORTD |= B01000000; //Set digital pin 6 high to flag that shutter is open - for ephys sync
  noInterrupts(); //Turn off interrupts to keep precise timing during trigger syncs
  if(TRIGGER == 2) confocalDigitalSync();
  else confocalAnalogSync();
}

void confocalDigitalSync(){
  PORTD = LEDstate0; //Set LED to standby state
  while ((boolean) (PIND & B00100000) == SHUTTERTRIGGERPOL){ //While shutter is open - continue using mirror sync
    if(!nLine--) rampLEDintensities();  
    if(DTRIGGERPOL) while(~PIND & B01000000); //Wait for sync trigger
    else while(PIND & B01000000); //Wait for sync trigger
    if(DELAY1) delayMicroseconds(DELAY1);
    PORTD = LEDstate1; //Set LED to post trigger state
    delayMicroseconds(delay2);
    PORTD = LEDstate0; //Set LED to standby state
    if(DELAY3) delayMicroseconds(delay3);
    checkStatus();
    if(event) return; //If event is a toogle event break loop and exit function
  }
  confocalStandby();
}

void confocalAnalogSync(){
  PORTD = LEDstate0; //Set LED to standby state
  analogRead(ANALOGSEL);
  while ((boolean) (PIND & B00100000) == SHUTTERTRIGGERPOL){ //While shutter is open - continue using mirror sync  
    if(!nLine--) rampLEDintensities();
    if(ATRIGGERPOL) while(analogRead(ANALOGSEL) < ATHRESHOLD); //Wait for sync trigger - 8us jitter
    else while(analogRead(ANALOGSEL) > ATHRESHOLD); //Wait for sync trigger
    delayMicroseconds(DELAY1);
    PORTD = LEDstate1; //Set LED to post trigger state
    delayMicroseconds(delay2);
    PORTD = LEDstate0; //Set LED to standby state
    delayMicroseconds(delay3);
    PORTD = LEDstate1; //Set LED to post trigger state
    delayMicroseconds(delay2);
    PORTD = LEDstate0; //Set LED to standby state
    checkStatus();
    if(event) return; //If event is a toogle event break loop and exit function
    analogRead(ANALOGSEL); //Refresh analog sync pin
  }
  confocalStandby(); 
}

void checkStatus(){
  if(!taskIndex && initialCount) initialCount--;
  taskIndex++; //Increment task index
  updateStatus = false; //Reset status flag
  if(SYNCTYPE) interrupts(); //Turn interrupts back on if in confocal mode - needed for serial communication
  if(taskIndex >= 0 && taskIndex <= 2){ //Record temperature - 12us
    analogRead(taskIndex)>>2;
    txPacket[HEADER + taskIndex] = analogRead(taskIndex)>>2; //Get temperature reading and convert to 8-bit
  }
  else if(taskIndex == 3){ //Get intensity knob position - 12us
    analogRead(POT);
    txPacket[HEADER + taskIndex] = analogRead(POT)>>2;
  }
  else if(taskIndex >= STATUSPACKET && taskIndex < (2*STATUSPACKET+HEADER) && !initialCount){ //6us
    Serial.write(txPacket[taskIndex - STATUSPACKET]);
  }
  else if(taskIndex == 4){ //Perform all fast tasks as one set
    txPacket[HEADER + taskIndex++] = syncStatus;
    txPacket[HEADER + taskIndex] = PIND & B00000100; //Check toggle switch
    if((txPacket[HEADER] < FAULTTEMP[0] || txPacket[HEADER+1] < FAULTTEMP[1] || txPacket[HEADER+2] < FAULTTEMP[2]) && !initialCount) event = 3; //Check whether device is overheating and enter failsafe if it is
    buildPacket(STATUSPACKET, STATUSPACKET+HEADER);
  }
  //For remainder of checks monitor toggle switch and serial alternately to prevent over-riding event flags if both happen synchronously
  else if(taskIndex%2){ //Check for received serial packet
    if (Serial.available()){
      event = 1; //Set event flag to check rx serial buffer if data is available
    }
  }
  else{ //Monitor for change in toggle switch
    if(toggleSwitch ^ (PIND & B00000100)){
      toggleSwitch = (PIND & B00000100); 
      event = 2;
    } 
  }
  if(SYNCTYPE) noInterrupts(); //Turn interrupts back off if in confocal mode - removes 5us jitter in sync timing
  if(event) eventHandler(); //If an event was found - run the event handler
}

void eventHandler(){ //Take no action on event 2 as the calling function needs to clear first to avoid infinite recursion
  if(event != 2){
    if(event==1) processReceivedPackets();
    else if(event==3 && !fault) failSafe();
    event = 0; //Reset event handler
  }
}

//--------------------------------------------------------------INITIALIZE-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

  //Speed up serial as commands will take 160us to transmit
  Serial.setTimeout(RUNTIMEOUT);

  //Disable serial if in manual mode and NOSERIAL is true
  if(NOSERIAL) Serial.end();

  //Build LED state variables to toggle LED as specified
  if(DELAYORDER){ //If LED is to be turned off on trigger
    LEDstate1 = B11111100; //Turn off LED on trigger (NEG)
    if(LEDSOURCE) LEDstate0 = B11110100; //Set to AWG before trigger
    else LEDstate0 = B11101100; //Set to EXT before trigger
  }
  else{ //If LED is to be turned on on trigger
    LEDstate0 = B11111100; //Turn off LED before trigger (NEG)
    if(LEDSOURCE) LEDstate1 = B11110100; //Set to AWG after trigger
    else LEDstate1 = B11101100; //Set to EXT after trigger
  }
  //Store backup of LEDstate1
  LEDstate1b = LEDstate1;
  
  //Set second resistor on AWG to 0 ohms
  PORTB &= B11111110;
  SPI.beginTransaction(SPISettings(20000000, MSBFIRST, SPI_MODE0));
  SPI.transfer16(256);
  SPI.endTransaction();
  PORTB |= B00000001;

  //Get state of toggle switch
  //NOTE: This forces the driver to boot into manual mode which resolves issue where driver locks if booting into sync mode
  //Need to establish why manual mode clears this lock+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  toggleSwitch = 1;
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
  DELAY1 = bytesToUint16.value; //Delay from previous event before LED is turned on
  bytesToUint16.bValue[0] = rxBuffer[rxStart++]; //Assemble uint16_t value
  bytesToUint16.bValue[1] = rxBuffer[rxStart++]; //Assemble uint16_t value
  DELAY2 = bytesToUint16.value; //Delay from previous event before LED is turned off
  bytesToUint16.bValue[0] = rxBuffer[rxStart++]; //Assemble uint16_t value
  bytesToUint16.bValue[1] = rxBuffer[rxStart++]; //Assemble uint16_t value
  ATHRESHOLD = bytesToUint16.value; //Threshold for analog trigger
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
  DTRIGGERPOL = rxBuffer[rxStart++]; //digital trigger polarity (0 = Low, 1 = High)
  ATRIGGERPOL = rxBuffer[rxStart++]; //analog trigger polarity (0 = Falling, 1 = Rising)
  SHUTTERTRIGGERPOL = 0; //Shutter trigger polarity (0 = Low, 1 = High) - only used for confocal syncs
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
    if(WARNTEMP[a] <= FAULTTEMP[a] || WARNTEMP[a] > 245 || FAULTTEMP[a] > 245 || WARNTEMP[a] < 10 || FAULTTEMP[a] < 10) return; //Setup is not valid if set temps are at the edge of the ADC range (roughly <-25oC or >180oC for standard thermistors)
  }

  //Check that packet values are valid
  if(FANMAXTEMP < FANMINTEMP && TRIGGER < 3 && (ANALOGSEL-3) < 2 && FAULTVOLUME < 128 && STARTVOLUME < 128 && ATHRESHOLD < 1024 && AWGSOURCE < 3){ //Check numerical values for validity
    if((!FAULTLED || FAULTLED == 4) && (!FANPIN || FANPIN == 32 || FANPIN == 64) && (!SYNCOUT || SYNCOUT == 64)){ //Check pin ID variables
      if(DELAYORDER < 2 && DELAYUNITS < 2 && PWMFAN < 2 && SYNCTYPE < 2 && DTRIGGERPOL < 2 && ATRIGGERPOL < 2 && SHUTTERTRIGGERPOL < 2 && LEDSOURCE < 2 && TRIGHOLD < 2 && SYNCOUT < 2){ //Check boolean variables - d
        if((!SYNCTYPE == DELAYUNITS) || !SYNCTYPE){ //Confirm that the delay units are in us if using a confocal sync
          if((!DELAYUNITS && (DELAY1 < 16384 && DELAY2 < 16384)) || DELAYUNITS){ //If us, make sure that value does not exceed 16383 cap - https://www.arduino.cc/reference/en/language/functions/time/delaymicroseconds/
            if(!SYNCTYPE || TRIGGER){ //Only analog or digital triggers for confocal
              for(a=rxIndex; a < rxIndex+SETUPSIZE; a++) txPacket[a-rxIndex] = rxBuffer[a];
              Serial.write(txPacket, SETUPSIZE); //Send received setup back back to computer for confirmation               
              //If setup is valid, then initialization is successful
              initialized = true;
              SPI.end(); //End SPI so that locks on warning LED and buzzer are released
              PORTB |= FAULTLED; //Turn on warning LED
              for(a=0; a<500; a++){ //Generate tone for 0.1 seconds
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
}


//--------------------------------------------------------------SERIAL---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
    packetLength = Serial.readBytes(rxBuffer, 64); //If not initialized, retrieve the entire rx serial buffer
    if(packetLength >= HEADER+1){ //If minimum number of necessary bytes were recieved, check buffer for setup packet
      for(a=0; a<=(packetLength-HEADER-1); a++){ //Search for valid header in packet
        if(!rxBuffer[a]){ //If start byte is found, check for valid packet
          //Packet structure is: byte(0) STARTBYTE -> byte(1) packet identifier -> byte(2) packet total length -> byte(3) checksum (data only, excluding header) -> byte(4-n) data packet;
          if(rxBuffer[a] == 0 && rxBuffer[a+2] == COMMANDSIZE && rxBuffer[a+3] == rxBuffer[a+HEADER]){ //If header is valid, parse the command
            if(rxBuffer[a+1] == rxBuffer[a+HEADER]){ //If command is fixed command with no value (i.e. databyte = ID) 
              if(rxBuffer[a+HEADER] == DISCONNECTPACKET) driverStandby(); //If disconnect is received, stop driver until reconnect resets driver.  This keeps driver from spamming serial buffer
              else if(rxBuffer[a+HEADER] == RESETPACKET) resetPacket(); //If reset command is received, set program line index to and reinitialize driver without hard reset
              else if(rxBuffer[a+HEADER] == FAULTPACKET) failSafe(); //If fault command is received, enter failsafe (i.e. failsafe test). 
            }
            else{
              if(rxBuffer[a+1] == AWGPACKET) updateAWG(rxBuffer[a+HEADER]); 
            }
          }          
        }
      }
    }
  }
}

void updateAWG(uint8_t awg){
  //If intensity is not 0, turn on LED and set value
  if(awg){
    LEDstate1 = LEDstate1b; //Restore LED state 1 to the on state
    PORTB &= B11111110;
    SPI.beginTransaction(SPISettings(20000000, MSBFIRST, SPI_MODE0));
    SPI.transfer16(awg);
    SPI.endTransaction();
    PORTB |= B00000001;
  }
  
  //If intensity is 0, turn off LED
  else LEDstate1 = LEDstate0;
}
//--------------------------------------------------------------STATES---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
void rampLEDintensities(){
  nLine = (uint32_t) timeArray[rampIndex];
  if(arraySize-rampIndex){
    updateAWG(intensityArray[rampIndex]); 
    delay2 = (uint16_t) round((float) DELAY2 * pulseDurationArray[rampIndex]);
    delay3 = DELAY3 + (DELAY2-delay2);   
    rampIndex++;
  }
  else{ //If at the end of the ramp array, turn off led
    nLine = 65535;
    updateAWG(0);
  }
}

void driverStandby(){
  PORTD |= B00011000; //Set analog swich to negative voltage output - this will force the LED off (due to rail offset - grounding the LED would still leave LED with low current)
  PORTB |= B00100000; //Turn on LED 13 to indicate standby
  Serial.end(); //Stop serial communication so Arduino does not spam output buffer
  SPI.end(); //Stop SPI to restore access to PORTB
  TIMSK0 |= _BV(OCIE0A); //Turn interrupts on to continue monitoring driver temperature - and alarm if overtemp
  while(1){ //Hold until reset
    delay(1);
    checkStatus();
  }
}

//In the event of the driver or LED overheating, fail safe automatically turns off the LED circuit until the driver/LED both cool to a safe temperature
void failSafe(){
  uint8_t TIMSK0state = TIMSK0;
  fault = true;
  TIMSK0 &= ~_BV(OCIE0A); //Turn off interrupts - loop calls check status directly to monitor temp
  uint8_t PORTDstate = PORTD; //Record current state of ports so they can be restored after fault
  uint8_t PORTBstate = PORTB;
  
  
  //If fault temp is reached, enter failsafe mode until warn temp is reached
  PORTD |= B00011000; //Set analog swich to negative voltage output - this will force the LED off (due to rail offset - grounding the LED would still leave LED with low current)
  PORTB &= B11111101; //Turn off 5V input to digital pot
  SPI.end(); //End SPI so that locks on warning LED and buzzer are released
  
    
  while(fault){ //Stay in fault mode until all thermistors are recording below the warning temp
    PORTB |= FAULTLED; //Turn on warning LED
    //txPacket[4]=FAULTPACKET; //Send fault packet to GUI
    //buildPacket(FAULTPACKET, COMMANDSIZE);
    //Serial.write(txPacket, COMMANDSIZE); //Send assembled data packet to computer
       
    while(taskIndex){
      checkStatus(); 
      PORTB |= B00010000;
      delayMicroseconds(FAULTVOLUME);
      PORTB &= B11101111;
      delayMicroseconds(255-FAULTVOLUME);
    }
    checkStatus();
    PORTB &= B11111011; //Turn off warning LED
    while(taskIndex){
      checkStatus();
      delayMicroseconds(255);
    }
    checkStatus();
    if(txPacket[HEADER] > WARNTEMP[0] && txPacket[HEADER+1] > WARNTEMP[1] && txPacket[HEADER+2] > WARNTEMP[2]) fault = false; //If all thermistor temps are below the warn temperature, then exit the fault state
  }
  fault = false;
  SPI.begin(); //Restart SPI communication
  PORTB = PORTBstate; //Restore ports to prior configurations
  PORTD = PORTDstate;
  TIMSK0 = TIMSK0state; //Restore Timer0 interrupt settings
}

void manualMode(){
  TIMSK0 |= _BV(OCIE0A); //Turn on millis interrupt timer
  PORTB |= B00000010;
  while(!event){ //Loop until toggle switch changes
    interrupts(); //Maintain interrupts while in manual
    uint16_t anaRead = 0;
    for(a=0; a<64; a++){
      anaRead += analogRead(POT);
    }
    anaRead >>= 8; //Convert sum to byte
    if(anaRead) PORTD = B10110100;
    else PORTD = B10111100;
    updateAWG(anaRead);
    if(updateStatus) checkStatus();
    analogRead(POT); //Refresh pot
  }
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
