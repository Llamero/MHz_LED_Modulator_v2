// add this to the top of your sketch
#define NOP __asm__ __volatile__ ("nop\n\t");
#include <SPI.h>
uint8_t a = 0;

void setup() {
  
  //Configure digital pins
  DDRB |= B00111111; //Set all pins as output
  PORTB |= B00111111;
  DDRD |= B11111000; //Set all pins but USB and toggle switch as output
  PORTD |= B10111000; //Set pins 3, 4, 5 and 7 high to start with off diode
  PORTD &= B10111111; //Set pin 6 low for digital sync 
  

  //Configure Timer0 to send an intterupt every 1 ms - https://learn.adafruit.com/multi-tasking-the-arduino-part-2/timers
  TIMSK0 &= ~_BV(OCIE0A); //Disable compare A interrupts if using confocal sync - turn off auto-interrupts for initialization so that they do not currupt startup sequence
  //TIMSK0 |= _BV(OCIE0A); //Otherwise set interrupt to "Compare A" if not d

  Serial.begin(250000);
  // put your setup code here, to run once:
  SPI.begin();
  PORTB &= B11111110;
  SPI.beginTransaction(SPISettings(20000000, MSBFIRST, SPI_MODE0));
  SPI.transfer16(256);
  SPI.endTransaction();
  PORTB |= B00000001;
  delay(1);
  PORTB &= B11111110;
  SPI.beginTransaction(SPISettings(20000000, MSBFIRST, SPI_MODE0));
  SPI.transfer16(255);
  SPI.endTransaction();
  PORTB |= B00000001;
  SPI.end();
  noInterrupts();
}

void loop() {
  //PORTD = B10110100; //Set pin 3 and 5 low
  NOP;
  NOP;
  NOP;
  NOP;
  NOP;
  NOP;
  delayMicroseconds(100);
  PORTD = B10011100; //Set pins 3, 4, 5 and 7 high to start with off diode
  delayMicroseconds(100);

}
