//  LovyanGFX by Lovyan03
//  https://github.com/lovyan03/LovyanGFX
//  https://github.com/lovyan03/ESP32_ScreenShotReceiver Better version than my cheApR_UI, give it a try

#include <LovyanGFX.hpp>
#include "src/TCPReceiverdual.h"

/////////////////////////////////////////////////////////////////
//DISPLAY SETUP

struct LGFX_DisplayA
{
  static constexpr spi_host_device_t spi_host = HSPI_HOST;
  static constexpr int dma_channel = 1;
  static constexpr int spi_sclk = 17;   //SCL_PIN
  static constexpr int spi_mosi = 2;    //SDA_PIN
  static constexpr int spi_miso = -1;   //NOT NEEDED
  static constexpr int spi_dlen = 8;
};

struct LGFX_DisplayB
{
  static constexpr spi_host_device_t spi_host = VSPI_HOST;
  static constexpr int dma_channel = 2;
  static constexpr int spi_sclk = 22;   //SCL_PIN
  static constexpr int spi_mosi = 21;   //SDA_PIN
  static constexpr int spi_miso = -1;   //NOT NEEDED
  static constexpr int spi_dlen = 8;
};

//
//
static LGFX_Sprite sprite[10];
static std::uint32_t count = 0;
static float zoom = 0;

static lgfx::LGFX_SPI<LGFX_DisplayA> lcd;  //display LEFT = LCD
static lgfx::LGFX_SPI<LGFX_DisplayB> lcdB; //display LEFT = LCD

static lgfx::Panel_ST7789 panel;
static lgfx::Panel_ST7789 panelB;

static TCPReceiver recv;
static TCPReceiver recvB;

/////////////////////////////////////////////////////////////////

void displaySetup() {
  //SETTING RIGHT PANEL
  panel.freq_write = 40000000;
  panel.freq_fill = 40000000;
  panel.freq_read = 6000000;
  panel.spi_mode = 3;
  panel.spi_mode_read = 0;
  panel.len_dummy_read_pixel = 8;
  panel.spi_read = false;
  panel.spi_3wire = false;
  panel.spi_cs = 12;   //CS PIN
  panel.spi_dc = 13;   //DC PIN
  panel.gpio_rst = 15;  //RST PIN
  panel.gpio_bl = 25; //BL PIN
  panel.pwm_ch_bl = 7;
  panel.backlight_level = false;
  panel.invert = true;
  panel.rgb_order = false;
  //  panel.memory_width  = 240;
  //  panel.memory_height = 240;
  //  panel.panel_width = 240;
  panel.panel_height = 240; //SET THIS WITH YOUR DISPLAY HEIGHT
  lcd.setPanel(&panel);//STARTING RIGHT PANEL

  //SETTING LEFT PANEL
  panelB.freq_write = 40000000;
  panelB.freq_fill = 40000000;
  panelB.freq_read = 6000000;
  panelB.spi_mode = 3;
  panelB.spi_mode_read = 0;
  panelB.len_dummy_read_pixel = 8;
  panelB.spi_read = false;
  panelB.spi_3wire = false;
  panelB.spi_cs = 32;   //CS PIN
  panelB.spi_dc = 27;   //DC_PIN
  panelB.gpio_rst = 33;   //RST_PIN
  panelB.gpio_bl = 38;    //BL_PIN
  panelB.pwm_ch_bl = 7;
  panelB.backlight_level = false;
  panelB.invert = true;
  panelB.rgb_order = false;
  //  panelB.memory_width  = 240;
  //  panelB.memory_height = 240;
  //  panelB.panel_width = 240;
  panelB.panel_height = 240; //SET THIS WITH YOUR DISPLAY HEIGHT
  lcdB.setPanel(&panelB); //STARTING RIGHT PANEL

  lcd.init();
  lcdB.init();

  //SET ROTATION OF DISPLAYS
  lcd.setRotation(1);
  lcdB.setRotation(3);

  //  MIRROR MODE
  //    lcd.setRotation(5);
  //    lcdB.setRotation(7);

  lcd.setTextColor(0x000000U, 0xFFFFFFU);
  lcdB.setTextColor(0x000000U, 0xFFFFFFU);


  // DISPLAY QUICK TEST LOOP
  //  while (1) {
  //    displayBatt();
  //    displayUptime();
  //    loopImg();
  //  }

  for ( int i = 0; i < 240; i++) {
    lcd.drawRect(0, i, lcd.width(), lcd.height(), 0xFF0000U);
    lcdB.drawRect(0, i, lcdB.width(), lcdB.height(), 0xFF0000U);
    delay(2);
  }

  for ( int i = 0; i < 240; i++) {
    lcd.drawRect(i, 0, lcd.width(), lcd.height(), 0xFFFFFFU);
    lcdB.drawRect(i, 0, lcdB.width(), lcdB.height(), 0xFFFFFFU);
    delay(2);
  }

  lcd.setFont(&fonts::Font2); lcdB.setFont(&fonts::Font2);
  lcd.setCursor(40, 110); lcd.print("CONNECTING TO WIFI");
  lcdB.setCursor(40, 110); lcdB.print("WAITING FOR IP");


}
