import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;      // Data received from the serial port
String incomingLine; //our line received

float robotX, robotY, robotZ;

void setupSerial() {
  String portName = Serial.list()[5];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
}

PVector getRobotPoint() {
  PVector rp = new PVector(robotX, robotY, robotZ);
  return rp;
}

void serialEvent(Serial myPort){
  if (frameCount < 30) {
     myPort.readString();
  }
  else {
  val = myPort.readString(); //Until('\n');
  //println(val);
  try {
  String[] list = split(val, ',');
  //if the second value is "1" then we are getting a joint angle string
  //println("x = " + list[0].replace("[","") + " y = " + list[1] + " z = " + list[2].replace("]",""));
  
  float newRobotX = float(list[0].replace("[",""));
  float newRobotY = float(list[1]);
  float newRobotZ = float(list[2].replace("]",""));
  
  if (robotX != newRobotX || robotY != newRobotY || robotZ != newRobotZ) {
    robotX = newRobotX;
    robotY = newRobotY;
    robotZ = newRobotZ;
    isNewRobotPoint = true;
  }
  } catch(Exception e) {
  }
  }
}
