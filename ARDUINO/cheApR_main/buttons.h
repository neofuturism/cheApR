 //Button Fever (button Library by)
 //https://github.com/mickey9801/ButtonFever
 //BUTTON SETUP/////////////////////////////////////////////////////////////////
//BUTTON ONE - btnPin [ REBOOT & SHUTDOWN]/////////////////////////////////////
//BUTTON TWO - btnPinB [STREAM/ CLOCK/ BATTERY]////////////////////////////////

#include <BfButton.h>  


const unsigned int btnPin = 18;  //RESET BUTTON
const unsigned int btnPinB = 19; //MODE BUTTON

BfButton btn(BfButton::STANDALONE_DIGITAL, btnPin, true, LOW);
BfButton btnB(BfButton::STANDALONE_DIGITAL, btnPinB, true, LOW);

int btnCount = 0;
int maxCount = 5;
int minCount = 0;


// BUTTONS /////////////////////////////////////////////////////////////////

void pressHandler (BfButton *btn, BfButton::press_pattern_t pattern) {
  Serial.print(btn->getID());
  switch (pattern) {
    case BfButton::SINGLE_PRESS:
      btnCount++;
      Serial.print(" COUNT=");
      Serial.println( btnCount);
      break;
    case BfButton::DOUBLE_PRESS:
      Serial.println(" double pressed.");
      break;
    case BfButton::LONG_PRESS:
      Serial.println(" long pressed.");
      break;
  }
}

void pressHandlerB (BfButton *btnB, BfButton::press_pattern_t pattern) {
  Serial.print(btnB->getID());
  switch (pattern) {
    case BfButton::SINGLE_PRESS:
      btnCount--;
      Serial.print(" COUNT=");
      Serial.println( btnCount);
      break;
    case BfButton::DOUBLE_PRESS:
      Serial.println(" double pressed.");
      break;
    case BfButton::LONG_PRESS:
      Serial.println(" long pressed.");
      break;
  }
}

void btnSetup() {

  btn.onPress(pressHandler)
  .onDoublePress(pressHandler)
  .onPressFor(pressHandler, 1000);

  btnB.onPress(pressHandlerB)
  .onDoublePress(pressHandlerB) // default timeout
  .onPressFor(pressHandler, 1000); // custom timeout for 1 second

}
