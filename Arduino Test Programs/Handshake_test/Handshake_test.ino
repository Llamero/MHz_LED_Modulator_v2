static char ID[] = "I'm just an Arduino";
static byte startShake[] = {38, 77, 46, 64, (uint8_t) sizeof(ID)}; //Numerical code to ID start of communication and length of ID string
static byte endShake[] = {114, 1, 97, 57}; //Numerical code to ID end of communication
int a = 0; //universal loop counter - only use in isolated functions

void setup() {
  initializeSerial();
  
}

void loop() {
  // put your main code here, to run repeatedly:

}


void initializeSerial(){
  Serial.begin(250000);
  Serial.write(startShake,5); //Send handshake code
  Serial.write(ID);
  Serial.write(endShake,4); //Send handshake code
}


