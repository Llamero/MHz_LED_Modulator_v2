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
  PORTB &= B11111110;
  SPI.beginTransaction(SPISettings(20000000, MSBFIRST, SPI_MODE0));
  SPI.transfer16(256);
  SPI.endTransaction();
  PORTB |= B00000001;
  updateAWG(50);
  noInterrupts();
}

void loop() {
PORTD = B11110100;
delayMicroseconds(2);
//delay(1000);
PORTD = B11111100;
delayMicroseconds(2);
//delay(1000);
}

void updateAWG(uint8_t awg){
  PORTB &= B11111110;
  SPI.beginTransaction(SPISettings(20000000, MSBFIRST, SPI_MODE0));
  SPI.transfer16(awg);
  SPI.endTransaction();
  PORTB |= B00000001;
}
