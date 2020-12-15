
import processing.net.*;
import controlP5.*;
import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import ipcapture.*;



OpenCV opencv;

IPCapture video;
String camIp = "http://192.168.0.198:81/"; //INSERT THE CAMERA STREAM IP HERE
//int camport = 63333;


Client screenClient;
//String yourIp ="192.168.0.199"; //INSERT THE IP YOU GOT FROM THE GOGGLES
String yourIp ="192.168.0.199"; //<<<<< INSERT THE IP YOU SEE ON CHEAPR HERE
int port = 63333;

byte[] msgBuffer = new byte[3];
String myString ;

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
float qualityValue = 0.45; //Almost full quality
PImage imgScreen, imgSmall;

int ctrl =0;
int maxctrl =3; //number of image in array [img number +1]

PFont a;
PFont b;
PFont c;

void setup() {
  size(800, 600);
  jpg = new JPGEncoder();
  screenClient = new Client(this, yourIp, port);
  //video = new Capture(this, 960/2, 480/2);
  video = new IPCapture(this, camIp, "", "");//http://192.168.0.24:81/view
  opencv = new OpenCV(this, 1600/2, 1200/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  video.start();
  imgScreen = createImage(video.pixelWidth, video.pixelHeight, RGB);
  a = createFont("SourceCodePro-Regular.ttf", 20 );
  textFont(a);  
  b = createFont("SourceCodePro-Regular.ttf", 7 );
  textFont(b);
  c = createFont("SourceCodePro-Regular.ttf", 150 );
  textFont(c);
}

void draw() {
  switch(ctrl) {
  case 0: 
    textFont(a);  
    simpleCam(); //WEBCAM
    break;
  case 1: 
    openCV(true);
    //println("One");  //OPENCV FACE RECOGNITION
    break;
  case 2: 
    openCV(false);
    //println("One");  //OPENCV FACE RECOGNITION NO BACKGROUND
    break;
  }

  initTcp(imgScreen);
  infoBox();
}

void simpleCam() {
  if (video.isAvailable()) {
    video.read();
    opencv.loadImage(video);
  }
  image(video, 0, 0 );
  imgScreen = get(0, 0, 800, 600); 
  imgScreen.updatePixels();
}


void openCV(boolean visible) {
  background(0);
  if (video.isAvailable()) {
    video.read();
    opencv.loadImage(video); //USE OPENCV CAMERA
  }
  if (visible) {
    image(video, 0, 0 );
  }

  noFill();
  stroke(0, 255, 0);
  strokeWeight(3);
  Rectangle[] faces = opencv.detect();
  println(faces.length);
  //DETECTING FACES
  for (int i = 0; i < faces.length; i++) {
    println(faces[i].x + "," + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
  textFont(a);  
  text("NUMBER OF FACES DETECTED", 10, 40);
  textFont(c);  
  text(faces.length, 100, 280);

  imgScreen = get(0, 0, 800, 600); 
  imgScreen.updatePixels();
}

void captureEvent(Capture c) {
  c.read();
}


void mousePressed() {
  ctrl++;
  if (ctrl >= maxctrl) {
    ctrl =0;
  }
  println("Changing image");
}


void infoBox() {
  textFont(a);  
  fill(255);
  if (ctrl ==1) {
    text("FACE REC ON", 10, 520);
  } else {
    text("FACE REC OFF", 10, 520);
  }
  text("cheApR Webcam and openCV stream", 10, 500);
  text("click here to switch between modes", 10, 550);
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
        int jpgRefresh = screenClient.readBytes(msgBuffer); 
        if (jpgRefresh > 0 ) {
          sendImgTransfer(imgStream);
        }//end client
      }
    } else {
      println("Client is not active.");
    }
  }
}

void sendImgTransfer(PImage img) {
  try {
    if (refreshRate == true) {
      img.resize(widthValue, heightValue);
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
