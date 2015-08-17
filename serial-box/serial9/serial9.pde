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
  rotateX(-pitch);
  rotateY(-yaw);
  rotateZ(-roll);
  noStroke();
  beginShape(QUADS);
  box(150, 20, 100);
  endShape();
  popMatrix();

  //stroke(255);
  //strokeWeight(5); 
  //translate(width/2, height/2, 0);
  //line(0, 0, 0, -1000, 0, 0);
  //line(0, 0, 0, 0, -1000, 0);
  //line(0, 0, 0, 0, 0, 1000);
}
Double accG=0d,yaw=0d,roll=0d,pitch=0d;

int i=0;
void serialEvent(Serial p) { 
  String tmp = p.readString();
  if (tmp.equals("\n")) {
    String numbers[] = inString.split("\t");
    if (numbers.length==11) {
      if (i%10==0)println(inString);
      //i++;
      try {
        accX = Double.parseDouble(numbers[1])/32768*4;
        accY = Double.parseDouble(numbers[2])/32768*4;
        accZ = Double.parseDouble(numbers[3])/32768*4;

        gyroX = Double.parseDouble(numbers[4]);
        gyroY = Double.parseDouble(numbers[5]);
        gyroZ = Double.parseDouble(numbers[6]);

        magX = Double.parseDouble(numbers[7]);
        magY = Double.parseDouble(numbers[8]);
        magZ = Double.parseDouble(numbers[9]);
        
        accG = Math.sqrt(accX*accX + accY*accY + accZ*accZ);
        //Double xy = accX*accX + accY*accY;
        Double yz = accZ*accZ + accY*accY;
        Double xz = accX*accX + accZ*accZ;
        
        Double phi = Math.acos(Math.sqrt(xz)/accG);
        Double omega = Math.acos(Math.sqrt(yz)/accG);
        if(accX<0)omega=-omega;
        if(accZ<0)omega=-omega;
        if(accZ<0)phi=-phi;
        if(accY>0)phi=-phi;
        roll = phi;
        pitch = omega;
      }
      catch(Exception e) {
        println(e);
      }
    }
    inString = "";
  } else inString += tmp;
} 
