import processing.serial.*;
Serial serial;
void openSerial() {
  String ports[] = Serial.list();
  String usbserial = "";
  for (String port : ports) {
    if (port.indexOf("serial")!=-1)usbserial=port;
  }
  if (usbserial!="")
  {
    println(usbserial);
    serial = new Serial(this, usbserial, 115200);
  } else exit();
}
void setup() {
  size(1024, 768, P3D);
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
  beginShape(QUADS);
  //box(150, 20, 100);
  box(300, 60, 450);
  endShape();
  popMatrix();
}
Double accG=0d,yaw=0d,roll=0d,pitch=0d;

int i=0;
void serialEvent(Serial p) { 
  String tmp = p.readString();
  if (tmp.equals("\n")) {
    String numbers[] = inString.split(",");
    if (numbers.length>=3) {
      if (i%10==0)println(inString);
      //i++;
      try {
        roll = Double.parseDouble(numbers[0])/180*Math.PI;
        pitch = Double.parseDouble(numbers[1])/180*Math.PI;
        yaw = Double.parseDouble(numbers[2])/180*Math.PI;
      }
      catch(Exception e) {
        println(e);
      }
    }
    inString = "";
  } else inString += tmp;
} 