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
uint8_t WARNTEMP[] = {255, 255, 255}; //1:3-warn temps, warn of overheating at 60oC (60oC = 98 on 8-bit ADC)
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


//Packet structure is: byte(0) STARTBYTE -> byte(1) packet length -> byte(2) checksum -> byte(3) packet identifier -> byte(4-n) data packet;
//Maximum data packet size is 252 bytes (256 bytes - 4 bytes for header and stop byte)
uint8_t checkSum = 0; //byte for verifying data integrity
uint8_t txPacket[64]; //Array for storing data packets to be sent to GUI - start of packet is {0, 0}
uint8_t txIndex = 0; //Current index position in txPacket assembly
uint8_t rxBuffer[256]; //Array for storing data stream from GUI
uint8_t rxIndex = 0; //Index for placing next received byte in the rx circular buffer
uint8_t rxStart = 0; //Index for start of packet in rx buffer
uint8_t wavePacket[256]; //Array for storing recorded wave packets before transmission
boolean initialized = false; //Whether device has received initialization intructions from GUI
uint8_t taskIndex = 0; //Index for recording current position in background tasks 0-2 - record temperatures, 3 - sync status (on/off), 4-5 - record panel, 6 - build header, 7-17 - send byte[n-7]
boolean syncStatus = false;

//Dummy  variables
int a = 0; //Dummy int counter
uint8_t counter = 0; //Dummy 8-bit counter

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

// Interrupt is called once a millisecond, 
SIGNAL(TIMER0_COMPA_vect) 
{
  PORTB |= B00100000;
  checkStatus();// put your main code here, to run repeatedly:
  PORTB &= B11011111;
  taskIndex++;
}


void setup() {
  // set up the ADC
  ADCSRA &= ~PS_128;  // remove bits set by Arduino library
  ADCSRA |= PS_4;    //Sets sample rate to 308kHz - best temporal precision for 1-10kHz mirror
  DIDR0 = B11111111; //Turns off digital input on pins A0-A5 (PORTC) to decrease noise to ADC and current load

  //Configure Timer0 to send an intterupt every 1 ms - https://learn.adafruit.com/multi-tasking-the-arduino-part-2/timers
  if(SYNCTYPE) TIMSK0 &= ~_BV(OCIE0A); //Disable compare A interrupts if using confocal sync
  else TIMSK0 |= _BV(OCIE0A); //Otherwise set interrupt to "Compare A" if not d
  
  DDRB |= B00111111; //Set pin8 as timing toggle pin
  PORTB &= B11000000;
  Serial.begin(BAUDRATE);
}

void loop() {
   if (Serial.available()){
    TIMSK0 &= ~_BV(OCIE0A);
  }
}

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
    if(!txPacket[5]) syncStatus = false; //If toggle switch is in manual, sync status is false.
    buildPacket(STATUSPACKET, STATUSPACKET);
  }
 else{ //Check for received serial packet
  if (Serial.available()) processReceivedPackets(); //Read packet if data is available
  if(taskIndex == 20) taskIndex = 0;
 }
 if(SYNCTYPE) noInterrupts(); //Turn interrupts back off if in confocal mode - removes 5us jitter in sync timing
}

//--------IN DEBUG-------------------------------------------------------------------------------------------------------------------------------------------
//Assemble header onto packet
void buildPacket(uint8_t identifier, uint8_t packetSize){
  txPacket[0] = STARTBYTE;
  txPacket[1] = packetSize; //Add packet length to data packet
  checkSum = identifier; //Add identifier to checksum
  txPacket[3] = identifier; //Add identifier to data packet
  for(a=0; a<packetSize+HEADER; a++){ //Load packet and update checksum 
    txPacket[a] = a+47;
  }
}

void failSafe(){
  
}

void processReceivedPackets(){
  
}























