
import processing.net.*;
import controlP5.*;
import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Capture video;
OpenCV opencv;

Client screenClient;
String yourIp ="192.168.0.199"; //<<<<< INSERT THE IP YOU SEE ON CHEAPR HERE
int port = 63333;
boolean connectIp = true;
boolean refreshRate = false;
int refresh;
int frameReset =0;
float wait = 0;
int widthValue = 480; //Display width 240px * 2
int heightValue = 240; //Display Height 240px
int imgWidth = 480; //Your image size
int imgHeight = 240; // Your image height

//JPEG ENCODER
JPGEncoder jpg;
float qualityValue = 0.9; //Almost full quality
PImage imgScreen, imgSmall;

int clicky =0;
int maxClicky =2; //number of image in array [img number +1]

PFont f;

void setup() {
  size(640, 480);
  jpg = new JPGEncoder();
  screenClient = new Client(this, yourIp, port);
  video = new Capture(this, 960/2, 480/2);// WEBCAM STARTED HERE
  //video = new Capture(this, 960/2, 480/2, "Snap Camera", 30);//USE THIS FOR SNAPCHAT FAVE FILTER
  //video = new Capture(this, 960/2, 480/2, "FaceTime HD Camera", 30);//USE THIS FOR SNAPCHAT FAVE FILTER
  opencv = new OpenCV(this, 960/2, 480/2);//LOAD OPEN CV 
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  video.start();
  imgScreen = createImage(video.pixelWidth, video.pixelHeight, RGB);

  f = createFont("SourceCodePro-Regular.ttf", 7 );
  textFont(f);
}

void draw() {
  if (clicky ==1) {
    simpleCam();
  } else {
    openCV();
  }
  initTcp(imgScreen);
  infoBox();
}

void simpleCam() {
  scale(2);
  image(video, 0, 0 );
  imgScreen = get(0, 0, 640, 480); 
  imgScreen.updatePixels();
}


void openCV() {
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );

  //imgScreen =  get(video, 0, 0);
  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  println(faces.length);

  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + "," + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
  imgScreen = get(0, 0, 640, 480); 
  imgScreen.updatePixels();
}

void captureEvent(Capture c) {
  c.read();
}


void mousePressed() {
  clicky++;
  if (clicky >= maxClicky) {
    clicky =0;
  }
  //photoDisplayed = loadImage(slideShow[clicky]);
  //photoSent = loadImage(slideShow[clicky]);

  println("Changing image");
}


void infoBox() {
  fill(255);
  if (clicky ==1) {
    text("FACE REC OFF", 10, 220);
  } else {
    text("FACE REC ON", 10, 220);
  }
  text("cheApR Webcam and openCV stream", 10, 200);
  text("click here to switch between modes", 10, 210);
}

void initTcp(PImage imgStream) {
  frameReset = millis() - refresh;
  if (frameReset > wait) {
    refreshRate = true;
    refresh = millis();//also update the stored time
  } else {
    refreshRate = false;
  } 

  if (connectIp == true) {
    if (screenClient.active() == true) {
      if (screenClient.available() > 0) {
        sendImgTransfer(imgStream);
      }//end client
    } else {
      println("Client is not active.");

      //screenClient.stop();
    }
  }
}

void sendImgTransfer(PImage img) {
  try {
    if (refreshRate == true) {
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
  }
  catch (IOException e) {
    // Ignore failure to encode
    println("IOException");
  }
}
