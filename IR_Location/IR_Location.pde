import processing.serial.*;

int lf = 10;    // Linefeed in ASCII
String myString = null;
Serial myPort;  // The serial port

void setup() {
  String ports[] = Serial.list();
  String usbserial = "";
  for (String port : ports) {
    if (port.indexOf("usbserial")>0)usbserial=port;
  }
  myPort = new Serial(this, usbserial, 115200);
  myPort.clear();
  myString = myPort.readStringUntil(lf);
  myString = null;
  size(800, 800);
  //frameRate(30);
}

int xx = 0, yy = 0;
void draw() {
  background(77);
  //while (myPort.available() > 0) {
  myString = myPort.readStringUntil(lf);
  if (myString != null) {
    try {
      int[] output = int (split(myString, ','));

      println(output[0] + "," + output[1]); // display the incoming string

      xx = output[0];
      yy = output[1];
    }
    catch(Exception e) { 
      println(e);
    }
  }
  ellipseMode(RADIUS);  // Set ellipseMode to RADIUS
  fill(255, 0, 0);  // Set fill to white
  ellipse(xx, yy, 20, 20);
}