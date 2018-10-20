#include <SPI.h>
uint16_t a = 90;
void setup() {
  DDRB |= B00111111;
  PORTB &= B11000001; //Set all pins but 8 low
  PORTB |= B00000011; //Set pin 8, 9 high
  DDRD |= B11111100;
  PORTD |= B10010000; //Set pins 4 and 7 high
  PORTD &= B11110111; //Set pin 3 low
  SPI.begin();
  PORTB &= B11111100;
  SPI.beginTransaction(SPISettings(20000000, MSBFIRST, SPI_MODE0));
  SPI.transfer16(256+255);
  SPI.endTransaction();
  PORTB |= B00000001;
  updateAWG(0);

}

void loop() {
PORTD = B11110100;
delayMicroseconds(a);
PORTD = B11111100;
delayMicroseconds(a);
}

void updateAWG(uint8_t awg){
  PORTB &= B11111110;
  SPI.beginTransaction(SPISettings(20000000, MSBFIRST, SPI_MODE0));
  SPI.transfer16(awg);
  SPI.endTransaction();
  PORTB |= B00000001;
}
