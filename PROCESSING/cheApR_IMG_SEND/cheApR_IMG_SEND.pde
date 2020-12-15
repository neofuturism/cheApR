import processing.net.*;
import processing.video.*;
import controlP5.*;



//JPEG ENCODER
JPGEncoder jpg;
float qualityValue = 1; //Almost full quality

//NETWORK SETTING

Client screenClient;
String yourIp ="192.168.0.199";//<<<<< INSERT THE IP YOU SEE ON CHEAPR HERE
int port = 63333;
boolean connectIp = true;
//DISPLAY SETUP
boolean refreshRate = false;
int refresh;
int frameReset =0;
float wait = 0;
int widthValue = 480; //Display width 240px * 2
int heightValue = 240; //Display Height 240px
int imgWidth = 480; //Your image size
int imgHeight = 240; // Your image height


//put your images in the data folder and write their name below
PImage photoSent, photoDisplayed;
String loadImgA = "img.png";
String loadImgB = "img1.png";
String loadImgC = "img2.png";
String loadImgD = "img3.png";
String loadImgE = "img4.png";
String loadImgF = "img5.png";
String loadImgG = "img6.png";
String loadImgH = "img7.png";
String loadImgI = "img8.png";
String loadImgJ = "img9.png";
String loadImgK = "img10.png";

String slideShow[]={loadImgA, loadImgB, loadImgC, loadImgD, loadImgE, loadImgF, 
  loadImgG, loadImgH, loadImgI, loadImgJ, loadImgK };

int clicky =0;
int maxClicky =11; //number of image in array [img number +1]


void setup() {
  size(640, 260);
  jpg = new JPGEncoder();
  screenClient = new Client(this, yourIp, port);
  photoDisplayed = loadImage(slideShow[clicky]);
  photoSent = loadImage(slideShow[clicky]);
}//END SETUP


void draw() {
  background(33);
  initTcp(photoSent);
  image(photoDisplayed, (width/2- imgWidth / 2), (height/2- imgHeight / 2));
  infoBox();

}//END DRAW

void infoBox() {
  fill(255);
  text("Image Width = " + imgWidth + "px", 160, 20);
  text("Image Height =" + imgHeight + "px", 300, 20);
  text("cheApR Send Image", 20, 20);
}

void mousePressed() {
  clicky++;
  if (clicky >= maxClicky) {
    clicky =0;
  }
  photoDisplayed = loadImage(slideShow[clicky]);
  photoSent = loadImage(slideShow[clicky]);

  println("Changing image");
}
//IMAGE STREAMER
void initTcp(PImage imgStream) {
  if (connectIp == true) {
    if (screenClient.active() == true) {
      if (screenClient.available() > 0) {
        sendImgTransfer(imgStream);
      }//end client
    } else {
      println("Client is not active.");
    }
  }
}

void sendImgTransfer(PImage img) {
  try {
    img.resize(widthValue, heightValue);//DOUBLE DISPLAY 240x240
    byte[] jpgBytes = jpg.encode(img, qualityValue);
    screenClient.write(0x4A);
    screenClient.write(0x50);
    screenClient.write(0x47);
    screenClient.write(jpgBytes.length & 0xFF);     
    screenClient.write((jpgBytes.length  >> 8)& 0xFF);     
    screenClient.write((jpgBytes.length  >> 16)& 0xFF);
    screenClient.write((jpgBytes.length  >> 24)& 0xFF);
    screenClient.write(jpgBytes);
    screenClient.clear();
  }
  catch (IOException e) {
    // Ignore failure to encode
    println("IOException");
  }
}
