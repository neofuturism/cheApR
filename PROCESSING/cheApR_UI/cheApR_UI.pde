import processing.opengl.*;
import processing.net.*;
import processing.video.*;
import java.awt.Rectangle;
import java.awt.Robot;
import java.awt.AWTException;
import controlP5.*;


//JPEG ENCODER
JPGEncoder jpg;
PImage screenshot;

//SPLASH SCREEN
PImage photoSent, photoDisplayed;
String loadImgA = "cheapr_boot.png"; //CALLIBRATING IMAGE
String loadImgB = "img1.png";// LOAD YOUR OWN IMAGE BY SAVING IT IN THE DATA FOLDER MAX SIZE 480X240px
String slideShow[]={loadImgA, loadImgB};
int imgLoading =0;
//int maximgLoading =11; //number of image in array


//NETWORK SETTING
Client screenClient;
String ipNumber = "192.168.0.199"; //<<<<< INSERT THE IP YOU SEE ON CHEAPR HERE
int port = 63333;

byte[] msgBuffer = new byte[3]; //store OK message
String myString ;
boolean connectIp = true;

//DISPLAY SETUP
boolean refreshRate = false;
int refresh;
int frameReset = 0;
int screenWidth = 480; //SCREEN WIDTH
int screenHeight = 240; //SCREEN HEIGHT
float wait = 0;
PFont info;

void setup() {
  //size(960, 480, P3D);
  size(960, 480, P2D);
  smooth();
  refresh = millis();//TIMING
  jpg = new JPGEncoder(); // JPG ENCODER
  screenClient = new Client(this, ipNumber, port);// SCREEN CLIENT IP + PORT
  photoSent = loadImage(slideShow[imgLoading]);//CALLIBRATING IMAGE
  displayInfo(); // IMAGE SENDER
  initTcp(photoSent); //SPLASH SCREEN
}


void draw() {
  background(33);
  screenshot();// Takes a screenshot of the display 
  displayModes();// Allows you to modify the image settings
  initTcp(screenshot); //screen mirroring
  keyControl();// Change mirrored screen resolution by using the 1-2-3-4 Key
  infoBox();// Simple information
} 


//DISPLAY SOME TEXTS
void infoBox() {
  fill(255);
  text("LEFT", 200, 20);
  text("RIGHT", 740, 20);
  text(" 1 = 480x240 --- 2 = 720x360 --- 3 = 960x480 --- 4 = FULLSCREEN", 10, height -10);
}


//IMAGE MODIFICATIONS
void displayModes() {
  image(screenshot, width/2-screenWidth/2, 0, screenWidth, screenHeight);
  screenshot.filter(BLUR, blurValue);

  if (tresholdAtctive == true) {
    screenshot.filter(THRESHOLD, thresholdValue);
    //println(tresholdAtctive);
  }
  if (posterizeAtctive == true) {
    screenshot.filter(POSTERIZE, posterizeValue);
    println(posterizeAtctive);
  }
  if (invertValue == true) {
    screenshot.filter(INVERT);
    //println("grayscaleBool: " +grayValue);
  }
  if (grayValue == true) {
    screenshot.filter(GRAY);
    //println("grayscaleBool: " +grayValue);
  }
  if (erodeValue == true) {
    screenshot.filter(ERODE);
  }
  if (dilateValue == true) {
    screenshot.filter(DILATE);
  }
  stroke(255, 0, 0);

  noFill();
  rect(width/2-screenWidth/2, 0, screenWidth, screenHeight);
  line(480, 0, 480, screenHeight);
}

//IMAGE STREAMER
void initTcp(PImage imgStream) {
  //frameReset = millis() - refresh;
  //if (frameReset > wait) {
  //  refreshRate = true;
  //  refresh = millis();//also update the stored time
  //} else {  
  //  refreshRate = false;
  //} 

  if (connectIp == true) {//PAUSE STREAM
  if (screenClient.active() == true) {
      if (screenClient.available() > 0) {
        int jpgRefresh = screenClient.readBytes(msgBuffer); 
        if (jpgRefresh > 0 ) {
          myString = new String(msgBuffer);
          if (myString.equals("JPG") == true) {
            //background(255);
            sendImgTransfer(imgStream);
          }
        }
      }
    } else {
      println("Client is not active.");
      //screenClient.stop();
    }
  }
}


void sendImgTransfer(PImage img) {
  try {
    //if (refreshRate == true) {
    img.resize(widthValue, heightValue);//DISPLAY SIZE

    byte[] jpgBytes = jpg.encode(img, qualityValue);//JPEG ENCODING
    screenClient.write(0x4A);
    screenClient.write(0x50);
    screenClient.write(0x47);
    screenClient.write(jpgBytes.length & 0xFF);     
    screenClient.write((jpgBytes.length  >> 8)& 0xFF);     
    screenClient.write((jpgBytes.length  >> 16)& 0xFF);
    screenClient.write((jpgBytes.length  >> 24)& 0xFF);
    screenClient.write(jpgBytes);
    screenClient.clear();
    //}
  }  
  catch (IOException e) {
    // Ignore failure to encode
    println("IOException");
  }
}


void disconnectTcp() {
}

void screenshot() {
  try {
    Robot robot_Screenshot = new Robot();
    screenshot = new PImage(robot_Screenshot.createScreenCapture
      (new Rectangle(displayWidth/2-screenWidth/2, displayHeight/2-screenHeight/2, screenWidth, screenHeight))); // positioning and size of wiever, right now center
  }
  catch (AWTException e) {
  }
  frame.setLocation(screenWidth/2, screenHeight/2);
}


//KEYBOARD RESOLUTION CONTROL
void keyControl() {
  if (key == '1') { 
    screenWidth=480;
    screenHeight=240;
    surface.setTitle("CheApR_480X240");
  } else if (key == '2') { 
    screenWidth=720;
    screenHeight=360;
    surface.setTitle("CheApR_720X360");
  } else if (key == '3') { 
    screenWidth=960;
    screenHeight=480;
    surface.setTitle("CheApR_960X480");
  } else if (key == '4') { 
    screenWidth=displayWidth;
    screenHeight=displayHeight;
    surface.setTitle("CheApR_FULLSCREEN");
  }
}
