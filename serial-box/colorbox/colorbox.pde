import processing.serial.*;
Serial serial;
void openSerial() {
  String ports[] = Serial.list();
  String usbserial = "";
  for (String port : ports) {
    if (port.indexOf("usbserial")>0)usbserial=port;
  }
  if (usbserial!="")
  {
    println(usbserial);
    serial = new Serial(this, usbserial, 115200);
  } else exit();
}
void setup() {
  size(640, 360, P3D);
  colorMode(RGB, 1);
  stroke(0);
  openSerial();
}


void rotateX(Double lalala) {
  rotateX(lalala.floatValue());
}
void rotateY(Double lalala) {
  rotateY(lalala.floatValue());
}
void rotateZ(Double lalala) {
  rotate(lalala.floatValue());
}
Double accX=0d, accY=0d, accZ=0d, gyroX=0d, gyroY=0d, gyroZ=0d, magX=0d, magY=0d, magZ=0d;

color red = #F44336;
color pink = #E91E63;
color pulple = #9C27B0;
color indigo = #3F51B5;
color blue = #2196F3;
color lblue = #03A9F4;
color cyan = #00BCD4;
color teal = #009688;
color green = #76FF03;
color lgreen = #8BC34A;
color lime = #CDDC39;
color yellow = #FFEB3B;
color amber = #FFC107;
color orange = #FF9800;
color dorange = #FF5722;
color brown = #795548;

String inString = "";
void draw() {
  background(0);
  lights();
  pushMatrix();
  translate(width/2, height/2, -100);
  rotateX(pitch);
  rotateY(yaw);
  rotateZ(roll);
  noStroke();
  int a=150,b=20,c=100;
  
  beginShape(QUADS);
  
  fill(red);
  vertex(a, b, -c);
  vertex(a, -b, -c);
  vertex(-a, -b, -c);
  vertex(-a, b, -c);
  
  fill(yellow);
  vertex(a, b, -c);
  vertex(a, -b, -c);
  vertex(a, -b, c);
  vertex(a, b, c);
  
  fill(green);
  vertex(a, b, c);
  vertex(a, -b, c);
  vertex(-a, -b, c);
  vertex(-a, b, c);
  
  fill(cyan);
  vertex(-a, b, -c);
  vertex(-a, -b, -c);
  vertex(-a, -b, c);
  vertex(-a, b, c);
  
  fill(blue);
  vertex(a, b, c);
  vertex(-a, b, c);
  vertex(-a, b, -c);
  vertex(a, b, -c);
  
  fill(brown);
  vertex(a, -b, c);
  vertex(-a, -b, c);
  vertex(-a, -b, -c);
  vertex(a, -b, -c);
  
  endShape();
  
  //box(150, 20, 100);
  
  
  popMatrix();
}
Double accG=0d,yaw=0d,roll=0d,pitch=0d;

int i=0;
void serialEvent(Serial p) { 
  String tmp = p.readString();
  if (tmp.equals("\n")) {
    String numbers[] = inString.split("\t");
    if (numbers.length>=3) {
      if (i%10==0)println(inString);
      //i++;
      try {
        roll = Double.parseDouble(numbers[0]);
        pitch = Double.parseDouble(numbers[1]);
        yaw = Double.parseDouble(numbers[2]);
      }
      catch(Exception e) {
        println(e);
      }
    }
    inString = "";
  } else inString += tmp;
} 