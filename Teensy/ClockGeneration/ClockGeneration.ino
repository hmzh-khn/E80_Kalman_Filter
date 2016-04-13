// ClockGeneration.c will be used to generate a sawtooth signal 
// for use when syncing in the analog and digital times

// Digital to analog converter is on pin 26
int DAC = 26;
int led = 13;
int ledCount = 0;
bool isLED = false;
// timer
elapsedMicros usec = 0;

// sawtooth wave settings
float FREQ = 1000; // Hz
float PERIOD = 1/FREQ;

float phase = 0;
int val = 0;

// 4096 possible values for voltage
float TIME_STEP = PERIOD/4096; 

void setup() {
  // The Teensy DAC can output values of 0 - 4096 (2^12)
  // which map to 0.001-3.307 V
  analogWriteResolution(12);

  pinMode(led, OUTPUT);
  
  Serial.begin(9600); // USB is always 12 Mbit/sec
}

void loop() {
  analogWrite(DAC, (int)val);
  Serial.println((int)val);
  delayMicroseconds(50);
  val = ++val % 4096;

  ++ledCount;
  if(ledCount % 3000 == 0) {
    int newLed = (!isLED)? HIGH: LOW;
    digitalWrite(led, newLed);   // turn the LED on (HIGH is the voltage level)
    isLED = !isLED;
  }
}
