int value;

int storeIndex = 0;
int speakerPin = 9;
int ledPin = 13;
int morseInputPin = 12;
int modePin = 8;

void setup()
{
  Serial.begin(9600);
  pinMode(ledPin, OUTPUT);
  pinMode(speakerPin, OUTPUT);
  pinMode(morseInputPin, INPUT);
  pinMode(modePin, INPUT);
}

void playTone(int duration) {
  for (long i = 0; i < duration * 1000L; i += 1400 * 2) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(1400);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(1400);
  }
}

void loop()
{
  if(digitalRead(modePin) == 1){
    if (Serial.available() > 0)
    {
  
      boolean checker = true;
      int theValue[100];
      while(checker){
        value = Serial.read();
        if(value != -1){
          theValue[storeIndex] = value;
          storeIndex++;
        }
        if(value == 3){
          checker = false;
        }
      }
        
  
      for (int i = 0; i < storeIndex; i++) {
          if(theValue[i] == 1){
            digitalWrite(ledPin,HIGH);
            analogWrite(speakerPin, 200);
            delay(200);
            digitalWrite(ledPin,LOW);
            analogWrite(speakerPin, 0);
          } else if(theValue[i] == 2){
            digitalWrite(ledPin,HIGH);
            analogWrite(speakerPin, 200);
            delay(400);
            digitalWrite(ledPin,LOW);
            analogWrite(speakerPin, 0);
          } else if(theValue[i] == 0){
            digitalWrite(ledPin,LOW);
            analogWrite(speakerPin, 0);
            delay(400);
          }
          delay(10);
      }
  
    }
  } else {

    
    
  }
}
