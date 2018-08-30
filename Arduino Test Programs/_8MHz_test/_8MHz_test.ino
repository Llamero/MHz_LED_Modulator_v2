#include <SPI.h>
uint16_t a = 0;
const int freqOutputPin = 9;   // OC1A output pin for ATmega32u4 (Arduino Micro)
const int ocr1aval  = 3; //Counter - 0 = 8 MHz, 1 = 4 MHz, 3 = 2 MHz, 7 = 1 MHz, etc. 

void setup() {
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

  // set up Timer 1
    pinMode(freqOutputPin, OUTPUT); 
    TCCR1A = ( (1 << COM1A0));
    TCCR1B = ((1 << WGM12) | (1 << CS10));
    TIMSK1 = 0;
    OCR1A = ocr1aval; 

}

void loop() {

}
