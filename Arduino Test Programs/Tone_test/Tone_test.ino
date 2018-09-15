int a = 0;
uint8_t volume = 0;
void setup() {
  // put your setup code here, to run once:
DDRB |= B00111111; //Set all pins as output
}

void loop() {
  // put your main code here, to run repeatedly:
  PORTB |= B00000100; //Turn on warning LED
  for(a=0; a<100; a++){ //Generate tone for 0.1 seconds
    PORTB |= B00010000;
    delayMicroseconds(volume);
    PORTB &= B11101111;
    delayMicroseconds(255-volume);
  }
  volume = (analogRead(5) >> 3);
  PORTB &= B11111011; //Turn off warning LED
  delay(500); //Wait for reset from GUI in case setup packet does not match
}
