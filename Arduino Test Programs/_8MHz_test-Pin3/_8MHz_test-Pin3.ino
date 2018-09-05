#include <SPI.h>
uint16_t a = 0;
const uint8_t freqOutputPin = 3;   // OC2B output pin for ATmega32u4 (Arduino Micro)
const uint8_t freq  =2; //Counter - 0 = 16 MHz, 1 = 8 MHz, 3 = 4 MHz, 7 = 2 MHz, etc. //Timer 2 is twice as fast as timer 1
uint8_t counter = freq/2;


void setup() {
  //Fastest modulation with full off is freq = 2, OCR2B = 0 -- 5.33MHz
  if(freq == 2) counter = 0;

  DDRB |= B00111111;
  PORTB &= B11000001; //Set all pins but 8 low
  PORTB |= B00000011; //Set pin 8, 9 high
  DDRD |= B11111100;
  PORTD |= B10010000; //Set pins 4 and 7 high
  PORTD &= B11110111; //Set pin 3 low
  
  SPI.begin();
  PORTB &= B11111110;
  SPI.beginTransaction(SPISettings(20000000, MSBFIRST, SPI_MODE0));
  SPI.transfer16(256+255);
  SPI.endTransaction();
  PORTB |= B00000001;
delay(1);
  PORTB &= B11111110;
  SPI.beginTransaction(SPISettings(20000000, MSBFIRST, SPI_MODE0));
  SPI.transfer16(255);
  SPI.endTransaction();
  PORTB |= B00000001;
  SPI.end();

https://www.reddit.com/r/arduino/comments/3898g6/generating_14_mhz_clock_on_arduino/
pinMode(3, OUTPUT);
//Enable Fast PWM Mode
//When the counter equals OCR2A, start over from 0.
//When the counter equals OCR2B, set pin3 to 0; when the counter equals 0, set OCR1B to 1.
TCCR2A = 0x23;
TCCR2B = 0x09;
OCR2A = freq;
OCR2B = counter;
pinMode (freqOutputPin, OUTPUT) ;
 

}

void loop() {

}
