// ROPG EzTime
// https://github.com/ropg/ezTime

#include <ezTime.h>

String utcTime;
String chosenTime;
String chosenTimeB;
String locationTime;





void timeSetup() {

  // Uncomment the line below to see what it does behind the scenes
  setDebug(INFO);

  waitForSync();

  Serial.println();
  Serial.println("UTC:             " + UTC.dateTime());
  utcTime = UTC.dateTime();
  Timezone myTZ;
  Timezone timeZoneA;
  Timezone timeZoneB;

  // Provide official timezone names
  // https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  timeZoneA.setLocation(F("Africa/Abidjan"));
  Serial.print(F("Ivory Coast:     "));
  Serial.println(timeZoneA.dateTime());
  chosenTime = timeZoneA.dateTime("l, d - M - y H: i: s");
  // Wait a little bit to not trigger DDoS protection on server
  // See https://github.com/ropg/ezTime#timezonedropnl
  delay(5000);

  // Or country codes for countries that do not span multiple timezones
  timeZoneB.setLocation(F("de"));
  Serial.print(F("Germany:         "));
  Serial.println(timeZoneB.dateTime());
  chosenTimeB = timeZoneB.dateTime("l, d - M - y H: i: s");

  // Same as above
  delay(5000);

  // See if local time can be obtained (does not work in countries that span multiple timezones)
  Serial.print(F("Local (GeoIP):   "));
  if (myTZ.setLocation()) {
    Serial.println(myTZ.dateTime("l, d - M - y H: i: s"));
    locationTime = myTZ.dateTime();
  } else {
    Serial.println(errorString());
  }

}


void timeLoop() {
  //  events();
  //
  //  lcd.fillScreen(0x000000);
  //  lcdB.fillScreen(0x000000);
  lcd.setFont(&fonts::Font4);
  lcd.setCursor(20, 20);
  lcd.print("ABIDJAN");
  lcd.setCursor(20, 40);
  lcd.print(chosenTime);
  //  chosenTime = myTZ.dateTime();
  lcd.setCursor(20, 100);
  lcd.print("UTC");
  lcd.setCursor(20, 120);
  lcd.print(utcTime);

  lcdB.setFont(&fonts::Font4);
  lcdB.setCursor(20, 20);
  lcdB.print("GERMANY");
  lcdB.setCursor(20, 40);
  lcdB.print(chosenTimeB);
  lcdB.setCursor(20, 100);
  lcdB.print("LOCAL TIME");
  lcdB.setCursor(20, 120);
  lcdB.print(locationTime);

}


//void timeSetup() {
//  // Uncomment the line below to see what it does behind the scenes
//  setDebug(INFO);
//
//  waitForSync();
//
//  Serial.println();
//  Serial.println("UTC:             " + UTC.dateTime());
//
//  Timezone myTZ;
//
//  // Provide official timezone names
//  // https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
//  myTZ.setLocation(F("Africa / Abidjan"));
//  Serial.print(F("Ivory Coast:     "));
//  Serial.println(myTZ.dateTime());
//  chosenTime = myTZ.dateTime();
//
//  lcd.setFont(&fonts::Font4);
//  lcd.setCursor(20, 60);
//  lcd.print("ABIDJAN");
//  lcd.setCursor(20, 80);
//  lcd.print(myTZ.dateTime());
//  chosenTime = myTZ.dateTime();
//  lcd.setCursor(20, 140);
//  lcd.print("UTC");
//  lcd.setCursor(20, 160);
//  lcd.print(myTZ.dateTime());
//
//  // Wait a little bit to not trigger DDoS protection on server
//  // See https://github.com/ropg/ezTime#timezonedropnl
//  delay(5000);
//
//  // Or country codes for countries that do not span multiple timezones
//  myTZ.setLocation(F("de"));
//  Serial.print(F("Germany:         "));
//  Serial.println(myTZ.dateTime());
//  chosenTimeB = myTZ.dateTime();
//  lcdB.setFont(&fonts::Font4);
//  lcdB.setCursor(20, 60);
//  lcdB.print("GERMANY");
//  lcdB.setCursor(20, 80);
//  lcdB.print(myTZ.dateTime());
//  // Same as above
//  delay(5000);
//
//
//  // See if local time can be obtained (does not work in countries that span multiple timezones)
//  Serial.print(F("Local (GeoIP):   "));
//  if (myTZ.setLocation()) {
//    Serial.println(myTZ.dateTime());
//    locationTime = myTZ.dateTime();
//    lcdB.setCursor(20, 140);
//    lcdB.print("LOCAL TIME");
//    lcdB.setCursor(20, 160);
//    lcdB.print(myTZ.dateTime());
//
//  } else {
//    Serial.println(errorString());
//  }
//
//}
//



//
//
//void timeSetup() {
//  // Uncomment the line below to see what it does behind the scenes
//  setDebug(INFO);
//
//  waitForSync();
//
//  Serial.println();
//  Serial.println("UTC:             " + UTC.dateTime());
//
//  Timezone myTZ;
//
//  // Provide official timezone names
//  // https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
//  myTZ.setLocation(F("Africa / Abidjan"));
//  Serial.print(F("Ivory Coast:     "));
//  Serial.println(myTZ.dateTime());
//  chosenTime = myTZ.dateTime();
//
//  lcd.setFont(&fonts::Font4);
//  lcd.setCursor(20, 60);
//  lcd.print("ABIDJAN");
//  lcd.setCursor(20, 80);
//  lcd.print(myTZ.dateTime());
//  chosenTime = myTZ.dateTime();
//  lcd.setCursor(20, 140);
//  lcd.print("UTC");
//  lcd.setCursor(20, 160);
//  lcd.print(myTZ.dateTime());
//
//  // Wait a little bit to not trigger DDoS protection on server
//  // See https://github.com/ropg/ezTime#timezonedropnl
//  delay(5000);
//
//  // Or country codes for countries that do not span multiple timezones
//  myTZ.setLocation(F("de"));
//  Serial.print(F("Germany:         "));
//  Serial.println(myTZ.dateTime());
//  chosenTimeB = myTZ.dateTime();
//  lcdB.setFont(&fonts::Font4);
//  lcdB.setCursor(20, 60);
//  lcdB.print("GERMANY");
//  lcdB.setCursor(20, 80);
//  lcdB.print(myTZ.dateTime());
//  // Same as above
//  delay(5000);
//
//
//  // See if local time can be obtained (does not work in countries that span multiple timezones)
//  Serial.print(F("Local (GeoIP):   "));
//  if (myTZ.setLocation()) {
//    Serial.println(myTZ.dateTime());
//    locationTime = myTZ.dateTime();
//    lcdB.setCursor(20, 140);
//    lcdB.print("LOCAL TIME");
//    lcdB.setCursor(20, 160);
//    lcdB.print(myTZ.dateTime());
//
//  } else {
//    Serial.println(errorString());
//  }
//
//}
//
