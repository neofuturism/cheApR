//   UPTIME (Uptime Library by Yiannis Bourkelis)
//   https://github.com/YiannisBourkelis/Uptime-Library

#include "uptime_formatter.h"
#include "uptime.h"


float mapfloat(float x, float in_min, float in_max, float out_min, float out_max)
{
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

//UPTIME
void displayUptime() {
  Serial.println("up " + uptime_formatter::getUptime());

  uptime::calculateUptime();
  //
  lcdB.setFont(&fonts::Font2);
  lcdB.setCursor(20, 60);
  lcdB.print("UPTIME:");

  lcdB.setFont(&profont29);
  lcdB.setCursor(20, 80);
  lcdB.print(uptime_formatter::getUptime());

}



//BATTERY
uint8_t percentage = 100;
float voltage = analogRead(36) / 4096.0 * 7.23;
float maxVolt = 3.9;
float minVolt = 3.3;

float voltMap = mapfloat(voltage, minVolt, maxVolt, 0, 100);
int charging = 0;

/////////////////////////////////////////////////////////////////


void displayBatt() {

  if (voltage > 3.99) {
    voltMap = 100;
    charging = 0;
  }

  if (voltage >= 3.35 && voltage <= 3.99) {
    charging = 1;
  }

  if (voltage < 3.35) {
    btnCount = 1;
    charging = 2;
  }

  if (charging == 0) {
    Serial.print("voltMap:: ");
    Serial.println(voltMap);

    lcd.setFont(&fonts::Font2);
    lcd.setCursor(20, 130);
    lcd.print("BATTERY MAPPED %");

    lcd.setCursor(20, 50);
    lcd.print("CURRENT VOLT");

    lcd.setCursor(110, 70);
    lcd.print("%");

    lcd.setFont(&fonts::Font4);
    lcd.setCursor(20, 210);
    lcd.print("USB CHARGING");

    lcd.setFont(&fonts::Font7);
    lcd.setCursor(15, 70);
    lcd.print(voltage, 1);

    lcd.setCursor(15, 150);
    lcd.print(voltMap, 1);

  }

  if (charging == 1) {
    Serial.print("voltMap:: ");
    Serial.println(voltMap);

    lcd.setFont(&fonts::Font2);
    lcd.setCursor(20, 130);
    lcd.print("BATTERY MAPPED %");
    lcd.setFont(&fonts::Font2);

    lcd.setCursor(20, 50);
    lcd.print("CURRENT VOLT");

    lcd.setCursor(110, 70);
    lcd.print("%");

    lcd.setFont(&fonts::Font7);
    lcd.setCursor(15, 70);
    lcd.print(voltage, 1);

    lcd.setCursor(15, 150);
    lcd.print(voltMap, 1);

  }

  if (charging == 2) {
    Serial.print("voltMap:: ");
    Serial.println(voltMap);

    lcd.setFont(&fonts::Font2);
    lcd.setCursor(20, 130);
    lcd.print("PLEASE CHARGE NOW");

    lcdB.setCursor(20, 130);
    lcdB.print("PLEASE CHARGE NOW");
  }

}
