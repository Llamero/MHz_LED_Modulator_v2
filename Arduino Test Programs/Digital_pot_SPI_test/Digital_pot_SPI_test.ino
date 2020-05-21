#include <SPI.h>
uint16_t a = 90;
uint8_t b = 0;
void setup() {
  DDRB = B00111111;
  PORTB = B00000011; //Set pin 8, 9 high
  DDRD = B11111100;
  PORTD = B10000000; //Set pins 4 and 7 high
  delay(500);
  updateAWG(256);
  updateAWG(255);

}

void loop() {
updateAWG(b++);
}

void updateAWG(uint16_t awg){
  PORTB &= B11111110;
  SPI.beginTransaction(SPISettings(20000000, MSBFIRST, SPI_MODE0));
  SPI.transfer16(awg);
  SPI.endTransaction();
  PORTB |= B00000001;
  delayMicroseconds(2);
}
