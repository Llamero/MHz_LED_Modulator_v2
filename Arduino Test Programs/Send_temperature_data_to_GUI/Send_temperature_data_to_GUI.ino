static char IDARRAY[] = "MOM Test Box";
//static char IDARRAY[] = "Just an Arduino";

//Packet structure is: byte(0) STARTBYTE -> byte(1) packet length -> byte(2) checksum -> byte(3) packet identifier -> byte(4-n) data packet;
//Maximum data packet size is 252 bytes (256 bytes - 4 bytes for header and stop byte)
uint8_t checkSum = 0; //byte for verifying data integrity
uint8_t dataPacket[256]; //Array for storing data packets to be sent to GUI - start of packet is {0, 0}
uint8_t tempArray[3]; //Array for storing temperature recordings: 0 - input; 1 - output; 2 - external
uint8_t panelArray[2]; //Array for storing 
uint8_t counter = 1; //Dummy counter so while loops quit after 256 tries
boolean packetSent = false; //Whether there the packet was successfully transmitted

static uint8_t STARTBYTE = 0; //Identifies start of packet
static uint8_t IDPACKET = 1; //Identifies packet as device identification packet
static uint8_t TEMPPACKET = 2; //Identifies packet as temperature recordings
static uint8_t PANELPACKET = 3; //Identifies packet as panel status
static uint8_t WAVEPACKET = 4; //Identifies packet as recorded analog waveform
static uint8_t HEADER = 4; //Indentifies length of header
static uint8_t IDSIZE = sizeof(IDARRAY); //Size of ID packet
static uint8_t TEMPSIZE = sizeof(tempArray); //Size of temperature packet
static uint8_t PANELSIZE = sizeof(panelArray); //Size of temperature packet
static uint8_t WAVESIZE = 252; //Size of wave packet

// Define various ADC prescaler
//const unsigned char PS_2 = (1 << ADPS0); //Does not seem to work, ADC stops.
const unsigned char PS_4 = (1 << ADPS1);
//const unsigned char PS_8 = (1 << ADPS1) | (1 << ADPS0);
//const unsigned char PS_16 = (1 << ADPS2);
//const unsigned char PS_32 = (1 << ADPS2) | (1 << ADPS0);
//const unsigned char PS_64 = (1 << ADPS2) | (1 << ADPS1);
const unsigned char PS_128 = (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0); //Default pre-scaler in Arduino

int a = 0; //universal loop counter - only use in isolated functions
uint16_t anaRead = 0; //Ttemporarilly stores ADC outputs - can also be used as an accumulator
static uint8_t ADCSHIFT = 4+2; //Number of times to shift ADC register for 8-bit conversion - Resample is calculated based on this value
static uint8_t NSAMPLE = 1<<(ADCSHIFT-2); //Subtract two from ADC shift since ADC is already 10 bit

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

//PORTC: Thermometers, Analog Input, Potentiometer
//A0 - Temp - Input
//A1 - Temp - Output
//A2 - Temp - LED
//A3 - Analog Input 1 (diode)
//A4 - Analog Input 2
//A5 - Potentiometer

void setup() {
  // set up the ADC
  ADCSRA &= ~PS_128;  // remove bits set by Arduino library
  ADCSRA |= PS_4;    //Sets sample rate to 308kHz - best temporal precision for 1-10kHz mirror
  DIDR0 = B11111111; //Turns off digital input on pins A0-A5 (PORTC) to decrease noise to ADC and current load
  
  DDRB |= B00111111; //Set all pins as output
  PORTB &= B11000000; //Set all pins low
  DDRD |= B11111100; //Set all pins but USB as output
  PORTD |= B10001000; //Set pins 3 and 7 high
  PORTD &= B11101111; //Set pin 4 low
  Serial.begin(250000);
  initializeDevice();
}

void loop() {
  tempArray[0] = recordAnalog(0);
  tempArray[1] = recordAnalog(1);
  tempArray[2] = recordAnalog(2);
  sendPacket(tempArray, TEMPPACKET, TEMPSIZE);
  panelArray[0] = recordAnalog(5);
  sendPacket(panelArray, PANELPACKET, PANELSIZE);
  PORTB &= B11000000;
  PORTB |= B00100100; 
}

void initializeDevice(){
  while(!packetSent){
    sendPacket(IDARRAY, IDPACKET, IDSIZE); //Keep sending ID packet until successful connection
    clearBuffer();
    if(!packetSent) packetError();
  }

  //ADCs tend to read high on reboot, so take a set of dummy reads to calibrate them
  counter = 6;
  while(counter){
    tempArray[0] = recordAnalog(0);
    tempArray[1] = recordAnalog(1);
    tempArray[2] = recordAnalog(2);
    delay(100);
    counter--;
  }
}

void sendPacket(uint8_t packet[], uint8_t identifier, uint8_t packetSize){
  dataPacket[0] = STARTBYTE;
  dataPacket[1] = packetSize; //Add packet length to data packet
  checkSum = identifier; //Add identifier to checksum
  dataPacket[3] = identifier; //Add identifier to data packet
  for(a=0; a<packetSize; a++){ //Load packet and update checksum
    dataPacket[a + HEADER] = packet[a];
    checkSum += packet[a];
  }
  dataPacket[2] = checkSum; //Add checksum to data packet
  Serial.write(dataPacket, (packetSize + HEADER)); //Send assembled data packet to computer
}

byte recordAnalog(byte pin){
  analogRead(pin);
  anaRead = 0;
  for(a = 0; a < NSAMPLE; a++) anaRead += analogRead(pin);
  anaRead >>= ADCSHIFT;
  return anaRead;
}

void recordPanel(){
  analogRead(5);
  panelArray[0] = analogRead(5) >> 2;  
}

//Try to clear buffer until cleared, or 256 attempts made.
void clearBuffer(){
  packetSent = false;
  counter = 1;
  //Wait for confirm byte to arrive
  while(Serial.available() == 0 && counter){
    delay(10); 
    counter++; 
  }
  counter = 1;
  while(Serial.available() > 0 && counter){
    if(Serial.read() == 0) packetSent = true; //If confirm byte is received remove error flag
    else counter++;
  }
}

void packetError(){
        PORTB |= B00100100; 
        delay(500);
        PORTB &= B11000000;
        delay(500);
        PORTB |= B00100100; 
        delay(500);
        PORTB &= B11000000;
        delay(500);
        PORTB |= B00100100; 
        delay(500);
        PORTB &= B11000000;
        delay(500);
}

