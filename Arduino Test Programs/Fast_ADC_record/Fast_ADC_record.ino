uint8_t a = 0;
uint8_t b[256];
int c = 0;
int d = 0;
uint16_t anaRead = 0;
uint8_t nShift = 2; //Number of memory shifts - >2 will result in averaging
uint8_t nSample = pow(2, (nShift-2));
int nRepeat = round(100.0/(float) nSample);
uint8_t mag = 1; //Sets range of ADC to use (1 = 0-255, 2 = 0-127, ...)
uint8_t pin = 3;
long timer = 0;
float totalTime = 0;
//**********************Add option to use 1V internal to measure very small voltages***************************************************


// Define various ADC prescaler
//const unsigned char PS_2 = (1 << ADPS0); //Does not seem to work, ADC stops.
const unsigned char PS_4 = (1 << ADPS1);
//const unsigned char PS_8 = (1 << ADPS1) | (1 << ADPS0);
//const unsigned char PS_16 = (1 << ADPS2);
//const unsigned char PS_32 = (1 << ADPS2) | (1 << ADPS0);
//const unsigned char PS_64 = (1 << ADPS2) | (1 << ADPS1);
const unsigned char PS_128 = (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0); //Default pre-scaler in Arduino

void setup() {
  //analogReference(INTERNAL);
  Serial.begin(250000);
  nShift -= (mag >> 1); //Allows for smaller voltages to be measured
    // set up the ADC
  ADCSRA &= ~PS_128;  // remove bits set by Arduino library
  ADCSRA |= PS_4;    //Sets sample rate to 308kHz - best temporal precision for 1-10kHz mirror
  DIDR0 = B11111111; //Turns off digital input on pins A0-A5 (PORTC) to decrease noise to ADC and current load

  b[0] = 0;
  while(++a) analogRead(pin); //Stabilize ADC
  timer = millis();
  for(d=0; d < nRepeat; d++){ //Repeat reading to get accurate time measurement
    while(++a){
      anaRead = 0;
      for(c = 0; c < nSample; c++){
        anaRead += analogRead(pin);
      }
      b[a] = anaRead >> nShift;
    }
  }
  timer = millis() - timer;
  totalTime = (float) timer / (float) nRepeat;
  while(++a) Serial.println(b[a]);
  Serial.println(totalTime);
  //delay(10000);
  //while(++a) Serial.println();
}

void loop() {


}
