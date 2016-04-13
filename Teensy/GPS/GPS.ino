//#include <SoftwareSerial.h>
#include <TinyGPS.h>
// 
//long lat,lon; // create variable for latitude and longitude object
// 
//SoftwareSerial gpsSerial(9, 10); // create gps sensor connection
//TinyGPS gps; // create gps object

String msg="";
int input = 0;
TinyGPS gps;

long lat,lon; // create variable for latitude and longitude object
unsigned long fix_age, time, date, speed, course;
unsigned long chars;
unsigned short sentences, failed_checksum;
 
void setup(){
  Serial.begin(9600); // connect serial
  Serial2.begin(9600); // connect gps sensor
}
 
void loop(){
  while(Serial2.available()) {
    input = Serial2.read();
    if (gps.encode(input)) {
      // process new gps info here
      gps.get_position(&lat, &lon, &fix_age);
      gps.stats(&chars, &sentences, &failed_checksum);

      Serial.println("Lat: "+ (String)lat);
      Serial.println("Lon: "+ (String)lon);
    }
  }

//  delay(100);
//  Serial.println("Lat: "+ (String)lat);
//  Serial.println("Lon: "+ (String)lon);

  
  
  //while(gpsSerial.available()){ // check for gps data
//   if(gps.encode(Serial2.read())){ // encode gps data
//    gps.get_position(&lat,&lon); // get latitude and longitude
//    // display position
//    Serial.print("Position: ");
//    Serial.print("lat: ");Serial.print(lat);Serial.print(" ");// print latitude
//    Serial.print("lon: ");Serial.println(lon); // print longitude
//   }
  //}
}
