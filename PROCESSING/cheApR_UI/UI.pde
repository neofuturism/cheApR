//CONTROL CP5
//SLIDERS
ControlP5 textIp;
ControlP5 videoRate;
ControlP5 allSliders; // controlP5 object
ControlP5 encodingSlide; // controlP5 object
ControlP5 tresholdSlide; // controlP5 object
ControlP5 posterizeSlide; // controlP5 object
ControlP5 blurSlide; // controlP5 object
//BUTTONS
ControlP5 allBtn; // controlP5 object
ControlP5 erodeBtn; // controlP5 object
ControlP5 invertBtn; // controlP5 object
ControlP5 dilateBtn; // controlP5 object

int widthValue = 480;// DEFAULT DISPLAY WIDTH
int heightValue = 0;//DEFAULT DISPLAY HEIGHT
int btnWidth = 40;
int btnHeigth = 20;
int myColor = color(0, 0, 0);
int blurValue = 0;
int posterizeValue =1 ;
float qualityValue = 0.45; //DEFAULT QUALITY SET AT HALF
float thresholdValue = 0.75;
float encodingValue = 0.9;
boolean tresholdAtctive = false;
boolean grayValue = false;
boolean invertValue = false;
boolean erodeValue = false;
boolean dilateValue = false;
boolean posterizeAtctive = false;

void displayInfo() {
  //PFont font = createFont("arial", 20);

  allSliders = new ControlP5(this);
  videoRate = new ControlP5(this);
  encodingSlide = new ControlP5(this);
  tresholdSlide= new ControlP5(this);
  blurSlide= new ControlP5(this);
  allBtn= new ControlP5(this);
  textIp = new ControlP5(this);

  // add a horizontal sliders, the value of this slider will be linked
  allSliders.addSlider("qualityValue")
    .setColorValue(color(255))
    .setColorActive(color(50))
    .setColorForeground(color(190, 70, 50))
    .setColorBackground(50)
    .setPosition(10, 270)
    .setRange(0, 1)
    .setSize(width-80, 20)
    .setCaptionLabel("JPG QUALITY")
    ;

  allSliders.addSlider("wait")
    .setColorValue(color(255))
    .setColorActive(color(50))
    .setColorForeground(color(190, 70, 50))
    .setColorBackground(50)
    .setPosition(10, 300)
    .setRange(0, 1000)
    .setSize(width-80, 20)
    .setCaptionLabel("REFRESH RATE")
    ;  

  //allSliders.addSlider("encodingValue")
  //  .setColorValue(color(255))
  //  .setColorActive(color(50))
  //  .setColorForeground(color(190, 70, 50))
  //  .setColorBackground(50)
  //  .setPosition(0, 300)
  //  .setRange(0, 1)
  //  .setSize(width-80, 20)
  //  //.setLabel("ENCODING")
  //  .setCaptionLabel("ENCODING")
  //  //.setLabelVisible(true) 
  //  //.setColorCaptionLabel(0)    
  //  .setBroadcast(true)
  //  ;

  allSliders.addSlider("thresholdValue")
    .setColorValue(color(255))
    .setColorActive(color(50))
    .setColorForeground(color(190, 70, 50))
    .setColorBackground(50)
    .setPosition(10, 330)
    .setRange(0, 1)
    .setCaptionLabel("THRESHOLD")
    .setSize(width-80, 20)
    ;
  allSliders.addSlider("posterizeValue")
    .setColorValue(color(255))
    .setColorActive(color(50))
    .setColorForeground(color(190, 70, 50))
    .setColorBackground(50)
    .setPosition(10, 360)
    .setRange(2, 255)
    .setSize(width-80, 20)
    .setCaptionLabel("POSTERIZE")
    ;
  allSliders.addSlider("blurValue")
    .setColorValue(color(255))
    .setColorActive(color(50))
    .setColorForeground(color(190, 70, 50))
    .setColorBackground(50)
    .setPosition(10, 390)
    .setRange(0, 60)
    .setSize(width-80, 20)
    .setCaptionLabel("BLUR")
    ;

  allSliders.addSlider("widthValue")
    .setColorValue(color(255))
    .setColorActive(color(50))
    .setColorForeground(color(190, 70, 50))
    .setColorBackground(50)
    .setPosition(330, 420)
    .setRange(10, 480)
    .setSize(260, 20)
    .setCaptionLabel("WIDTH")
    ;

  allSliders.addSlider("heightValue")
    .setColorValue(color(255))
    .setColorActive(color(50))
    .setColorForeground(color(190, 70, 50))
    .setColorBackground(50)
    .setPosition(630, 420)
    .setRange(0, 320)
    .setSize(260, 20)
    .setCaptionLabel("HEIGTH")
    ;

  allBtn.addToggle("grayValue")
    .setColorValue(color(200, 55, 50))
    .setColorActive(color(30))
    .setColorForeground(color(50))
    .setColorBackground(color(190, 70, 50))
    .setPosition(10, 420)
    .setSize(btnWidth, btnHeigth)
    .setCaptionLabel("GRAYSCALE")
    ;
  allBtn.addToggle("tresholdAtctive")
    .setColorValue(color(200, 55, 50))
    .setColorActive(color(30))
    .setColorForeground(color(50))
    .setColorBackground(color(190, 70, 50))
    .setPosition(60, 420)
    .setSize(btnWidth, btnHeigth)
    .setCaptionLabel("THRESHOLD")
    ;
  allBtn.addToggle("erodeValue")
    .setColorValue(color(200, 55, 50))
    .setColorActive(color(30))
    .setColorForeground(color(50))
    .setColorBackground(color(190, 70, 50))
    .setPosition(110, 420)
    .setSize(btnWidth, btnHeigth)
    .setCaptionLabel("ERODE")
    ;
  allBtn.addToggle("dilateValue")
    .setColorValue(color(200, 55, 50))
    .setColorActive(color(30))
    .setColorForeground(color(50))
    .setColorBackground(color(190, 70, 50))
    .setPosition(160, 420)
    .setSize(btnWidth, btnHeigth)
    .setCaptionLabel("DILATE")
    ;
  allBtn.addToggle("invertValue")
    .setColorValue(color(200, 55, 50))
    .setColorActive(color(30))
    .setColorForeground(color(50))
    .setColorBackground(color(190, 70, 50))
    .setPosition(210, 420)
    .setSize(btnWidth, btnHeigth)
    .setCaptionLabel("INVERT")
    ;
  allBtn.addToggle("posterizeAtctive")
    .setColorValue(color(200, 55, 50))
    .setColorActive(color(30))
    .setColorForeground(color(50))
    .setColorBackground(color(190, 70, 50))
    .setPosition(260, 420)
    .setSize(btnWidth, btnHeigth)
    .setCaptionLabel("POSTERIZE")
    ;

  allBtn.addToggle("connectIp")
    .setColorValue(color(200, 55, 50))
    .setColorActive(color(0))
    .setColorForeground(color(50))
    .setColorBackground(color(190, 70, 50))
    .setPosition(10, 100)
    .setSize(80, 40)
    //.setSize(btnWidth, btnHeigth)
    .setCaptionLabel("PAUSE STREAM")
    ;

}

public void clear() {
  textIp.get(Textfield.class, "textValue").clear();
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
      +theEvent.getName()+"': "
      +theEvent.getStringValue()
      );
  }
}
