#include <SPI.h>
uint16_t a = 0;
const int freqOutputPin = 9;   // OC1A output pin for ATmega32u4 (Arduino Micro)
const int ocr1aval  = 7; //Counter - 0 = 8 MHz, 1 = 4 MHz, 3 = 2 MHz, 7 = 1 MHz, etc. //Timer 1 is half as fast as timer 2

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


    // Set Timer 1 CTC mode with no prescaling.  OC1A toggles on compare match
    // WGM12:0 = 010: CTC Mode, toggle OC 
    // WGM2 bits 1 and 0 are in TCCR1A,
    // WGM2 bit 2 and 3 are in TCCR1B
    // COM1A0 sets OC1A (arduino pin 9 on Arduino Micro) to toggle on compare match
    TCCR1A = ((1 << COM1A0));
    // Set Timer 1  No prescaling  (i.e. prescale division = 1)  
    TCCR1B = ((1 << WGM12) | (1 << CS10));
    // Make sure Compare-match register A interrupt for timer1 is disabled
    TIMSK1 = 0;
    // This value determines the output frequency
    OCR1A = ocr1aval;
    pinMode (freqOutputPin, OUTPUT) ;
 

}

void loop() {

}
