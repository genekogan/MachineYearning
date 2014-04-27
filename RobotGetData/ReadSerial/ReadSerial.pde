// reading serial data from robot
// make sure the correct serial port is chosen

int idxSerialPort = 5;

import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;      // Data received from the serial port
String incomingLine; //our line received

float robotX, robotY, robotZ;


void setup() 
{
  size(200, 200);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  
  println(Serial.list());
  String portName = Serial.list()[idxSerialPort];
  
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
  
}

void draw()
{
}


void serialEvent(Serial myPort){
  val = myPort.readString(); //Until('\n');
  //println(val);
  String[] list = split(val, ',');
  //if the second value is "1" then we are getting a joint angle string
  println("x = " + list[0].replace("[","") + " y = " + list[1] + " z = " + list[2].replace("]",""));
  
  robotX = float(list[0].replace("[",""));
  robotY = float(list[1]);
  robotZ = float(list[2].replace("]",""));
}
