/*----------------------------------------------------------------------------/
  cheApR - Open Source A.R. Goggles by Arnaud Atchimon.
  Neofuturism - https://www.neofuturism.dev

  What started it all:
  https://homemadegarbage.com/makerfabs05

  ESP32 ScreenShotReceiver <<<<<<< Super Awesome
  Original Source:
  https://github.com/lovyan03/ESP32_ScreenShotReceiver/

  LovyanGFX <<<<<<< Even more Awesome
  https://github.com/lovyan03/LovyanGFX

  Licence:
  [MIT](https://github.com/lovyan03/ESP32_ScreenShotReceiver/blob/master/LICENSE)

  Author:
  [lovyan03](https://twitter.com/lovyan03)

  /----------------------------------------------------------------------------*/

//DISABLE  BROWN_OUT DETECTOR
#include "soc/soc.h"
#include "soc/rtc_cntl_reg.h"

//#define DEBUG 1 // flag to turn on/off debugging

#if defined(ARDUINO_M5Stack_Core_ESP32) || defined(ARDUINO_M5STACK_FIRE)
#include <M5StackUpdater.h>     // https://github.com/tobozo/M5Stack-SD-Updater/
#endif

#include <Arduino.h>
#include <esp_wifi.h>
//#include <sdkconfig.h>

#include "display_setup.h";   //DISPLAY SETUP
#include "graphics.h";    //PARTY PARROT EXAMPLE
#include "profont.h";   //FONTS SETUP
#include "fonts.h";
#include "wifiSetup.h";
#include "buttons.h";   //BUTTON MANAGEMENT
#include "battery.h";   //BATTERY MANAGEMENT
//#include "ntpTime.h";   //TINE MANAGEMENT NOT USED

void setup(void)
{
  WRITE_PERI_REG(RTC_CNTL_BROWN_OUT_REG, 0); //disable brownout detector
  Serial.begin(115200);
  Serial.flush();
  //BTN SETUP
  /////////////////////////////////////////////////////////////////
  btnSetup();
  //SETUP AND SET BOTH PANELS
  /////////////////////////////////////////////////////////////////
  displaySetup(); // Start displays
  delay(100);
  //WIFI BEGIN
  /////////////////////////////////////////////////////////////////
  //  normalConnect(true);//Normal connection with ssid + pass, Set to false to use static IP 192.168.0.199
  smartConfig(false); //Set to false to use static IP 192.168.0.199
  //SMART CONFIG
  /////////////////////////////////////////////////////////////////
  //  timeSetup(); //NTP TIME not necessary
  //SETTING TCPRECEIVER VALUE
  /////////////////////////////////////////////////////////////////
  recv.setup( &lcd, &lcdB); //If all pass, we start the stream
}


void loop(void)
{
//  recv.loop(); // Simple mode with stream only
  
    control(); // TO DO, missing MPU6050 UDP STREAM 
}


void control(void)
{
  if (btnCount >= maxCount) {
    btnCount = 0;
  }
  if (btnCount <= minCount) {
    btnCount = 0;
  }
  btn.read();
  btnB.read();

  switch (btnCount) {
    case 0:
      recv.loop(); //VIDEO STREAM
      break;
    case 1:
      displayReset();
      delay(500);
      btnCount = 2;
      break;
    case 2:
      displayBatt(); // BATTERY
      displayUptime();
      break;
    case 3:
      displayReset();
      delay(500);
      btnCount = 4;
    case 4:
      //      timeLoop(); // TIME TRACKING
      //      timeSetup();
      break;
    case 5:
      displayReset();
      delay(500);
      btnCount = 0;
      break;
  }

}

void displayReset() {
  //set displays to black
  lcd.fillScreen(0x000000);
  lcdB.fillScreen(0x000000);
//
}
