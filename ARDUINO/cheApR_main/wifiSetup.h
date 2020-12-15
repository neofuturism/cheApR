
// STATIC IP/////////////////////////////////////////////////////////////////
//NOT NECESSARY BUT USE THIS IF SMART CONFIG ISN'T WORKING AND COMMENT/UNCOMMENT THE DESIRED WIFI CONFIG

#define WIFI_SSID "<***********>"
#define PASSWORD "<***********>"



IPAddress local_IP(192, 168, 0, 199);// SET STATIC IP 192.168.0.199
IPAddress gateway(192, 168, 0, 1);// CHECK YOUR LOCAL GATEWAY
IPAddress subnet(255, 255, 0, 0);
IPAddress primaryDNS(8, 8, 8, 8); //optional
IPAddress secondaryDNS(8, 8, 4, 4); //optional
int channel = 11;



void normalConnect(bool staticIp) {
  if (!staticIp) {
    if (!WiFi.config(local_IP, gateway, subnet)) {
      Serial.println("STA Failed to configure");
    }
  }

  //  //WIFI NORMAL
  //  /////////////////////////////////////////////////////////////////
  WiFi.begin(WIFI_SSID, PASSWORD);
  //
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println();
  //  WiFi.mode(WIFI_MODE_STA);


  //END SMART CONFIG


  Serial.println("");
  Serial.println("WiFi connected!");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
  Serial.print("ESP Mac Address: ");
  Serial.println(WiFi.macAddress());
  Serial.print("Subnet Mask: ");
  Serial.println(WiFi.subnetMask());
  Serial.print("Gateway IP: ");
  Serial.println(WiFi.gatewayIP());
  Serial.print("DNS: ");
  Serial.println(WiFi.dnsIP());

  //SMART CONFIGR
  /////////////////////////////////////////////////////////////////

  Serial.println(String("IP:") + WiFi.localIP().toString());

  lcd.setFont(&fonts::Orbitron_Light_24); lcdB.setFont(&fonts::Orbitron_Light_24);
  lcd.setCursor(25, 110); lcd.print("YOUR IP # IS:");
  lcdB.setCursor(25, 110); lcdB.print(WiFi.localIP().toString());

  lcd.setFont(&fonts::Font2); lcdB.setFont(&fonts::Font2);
  lcd.setCursor(25, 140); lcd.print("WAITING FOR YOU TO START ");
  lcdB.setCursor(25, 140); lcdB.print("THE PROCESSING SCRIPT  ");

  //  lcd.drawString(WiFi.localIP().toString(),  40, 140);
  //  lcdB.drawString(WiFi.localIP().toString(),  40,  140);
  delay(3000);


}

void smartConfig(bool staticIp) {
  if (!staticIp) {
    if (!WiFi.config(local_IP, gateway, subnet)) {
      Serial.println("STA Failed to configure");
    }
  }
  // 記憶しているAPへ接続試行
  WiFi.mode(WIFI_STA);
  WiFi.begin();

  // 接続できるまで10秒待機
  for (int i = 0; WiFi.status() != WL_CONNECTED && i < 100; i++) {
    delay(100);
  }

  // 接続できない場合はSmartConfigを起動
  // https://itunes.apple.com/app/id1071176700
  // https://play.google.com/store/apps/details?id=com.cmmakerclub.iot.esptouch

  //
  if (WiFi.status() != WL_CONNECTED) {
    Serial.print("SmartConfig start.");
    lcd.setTextDatum( textdatum_t::top_left   );
    lcdB.setTextDatum( textdatum_t::top_left   );
    lcd.drawString("STARTING",  lcd.width() / 2,  lcd.height() / 2 + 30);
    lcdB.drawString("SMART_CONFIG",  lcd.width() / 2,  lcd.height() / 2 + 30);
    //WiFi.mode(WIFI_MODE_STA);
    WiFi.beginSmartConfig();

    while (WiFi.status() != WL_CONNECTED) {
      delay(100);
    }
    WiFi.stopSmartConfig();
    //    WiFi.mode(WIFI_MODE_APSTA);
  }


  //END SMART CONFIG


  Serial.println("");
  Serial.println("WiFi connected!");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
  Serial.print("ESP Mac Address: ");
  Serial.println(WiFi.macAddress());
  Serial.print("Subnet Mask: ");
  Serial.println(WiFi.subnetMask());
  Serial.print("Gateway IP: ");
  Serial.println(WiFi.gatewayIP());
  Serial.print("DNS: ");
  Serial.println(WiFi.dnsIP());

  //SMART CONFIGR
  /////////////////////////////////////////////////////////////////

  Serial.println(String("IP:") + WiFi.localIP().toString());

  lcd.setFont(&fonts::Orbitron_Light_24); lcdB.setFont(&fonts::Orbitron_Light_24);
  lcd.setCursor(25, 110); lcd.print("YOUR IP # IS:");
  lcdB.setCursor(25, 110); lcdB.print(WiFi.localIP().toString());

  lcd.setFont(&fonts::Font2); lcdB.setFont(&fonts::Font2);
  lcd.setCursor(25, 140); lcd.print("WAITING FOR YOU TO START ");
  lcdB.setCursor(25, 140); lcdB.print("THE PROCESSING SCRIPT  ");
  delay(3000);

}
