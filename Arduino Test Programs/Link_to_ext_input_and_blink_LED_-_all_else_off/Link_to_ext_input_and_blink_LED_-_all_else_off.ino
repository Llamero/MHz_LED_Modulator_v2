static char ID[] = "MOM Test Box1";
static byte startShake[] = {38, 77, 46, 64, (uint8_t) sizeof(ID)}; //Numerical code to ID start of communication and length of ID string
static byte endShake[] = {114, 1, 97, 57}; //Numerical code to ID end of communication
int a = 0; //universal loop counter - only use in isolated functions

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

uint8_t temp1 = 0;
uint8_t temp2 = 0;

void setup() {
  
  DDRB |= B00111111;
  PORTB &= B11000000; //Set all pins low
  DDRD |= B11111100;
  PORTD |= B10001000; //Set pins 3 and 7 high
  PORTD &= B11101111; //Set pin 4 low
  initializeSerial();
  
}

void loop() {
  PORTB |= B00000100; 
  analogRead(0);
  temp1 = analogRead(0) >> 2;
  delay(500);
  PORTB &= B11000000;
  delay(500);
  analogRead(1);
  temp2 = analogRead(1) >> 2;
  Serial.print(temp1);
  Serial.print(" ");
  Serial.println(temp2);
}

void initializeSerial(){
  Serial.begin(250000);
  Serial.write(startShake,5); //Send handshake code
  Serial.write(ID);
  Serial.write(endShake,4); //Send handshake code
}
 
