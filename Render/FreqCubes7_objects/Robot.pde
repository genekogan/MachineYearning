Serial myPort;  // Create object from Serial class
String val;      // Data received from the serial port
String incomingLine; //our line received

float angleAxis1, angleAxis2, angleAxis3, angleAxis4, angleAxis5, angleAxis6;

//PVector projector = new PVector(-1994,3378,500);

PVector projector = new PVector(1504.7, -2832.28, -40.339);  // actual
//PVector projector = new PVector(-1504.7, 2832.28, 40.339); // inverted

boolean hasFirstTime = false;
int t0 = 0;

//DEFINE OUR QUADS
PVector qBA_TL,qBA_TR,qBA_BR,qBA_BL;
PVector q1A_TL,q1A_TR,q1A_BR,q1A_BL;
PVector q1B_TL,q1B_TR,q1B_BR,q1B_BL;
PVector q2A_TL,q2A_TR,q2A_BR,q2A_BL;
PVector q2B_TL,q2B_TR,q2B_BR,q2B_BL;
PVector q2C_TL,q2C_TR,q2C_BR,q2C_BL;
PVector q4A_TL,q4A_TR,q4A_BR,q4A_BL;
PVector q4B_TL,q4B_TR,q4B_BR,q4B_BL;
PVector q4C_TL,q4C_TR,q4C_BR,q4C_BL;

void setupSerial() {
  String portName = Serial.list()[5];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
}


void getRobotQuads() {
  pushMatrix(); //put all of our info inside of a push matrix for the sake of controlp5

  scale(1, -1);
  background(0);

  strokeWeight(.5);

  pushMatrix(); //because OBJloader comes in mirrored (for right hand rule), we have to unmirror our global mirror with each part
  scale(1, -1);
  //base_7600.draw();
    //quad A on Base
  qBA_TL = modelXYZ(new PVector(-719.484,-385.793,185.68));
  qBA_TR = modelXYZ(new PVector(410,-385.793,185.68));
  qBA_BR = modelXYZ(new PVector(410,-385.793,-0.101856));
  qBA_BL = modelXYZ(new PVector(-719.484,-385.793,-0.101856));
  popMatrix();

  rotateZ(angleAxis1);



  pushMatrix(); //because OBJloader comes in mirrored (for right hand rule), we have to unmirror our global mirror with each part
  scale(1, -1);
  //link1_7600.draw();
  //quad A on Axis 1
  q1A_TL = modelXYZ(new PVector(-454.787,-441.329,770.8));
  q1A_TR = modelXYZ(new PVector(519.611,-441.329,918.987));
  q1A_BR = modelXYZ(new PVector(519.611,-441.329,448.63));
  q1A_BL = modelXYZ(new PVector(-454.787,-441.329,436.449));
    //quad B on Axis 1
  q1B_TL = modelXYZ(new PVector(450.434,466,876.155));
  q1B_TR = modelXYZ(new PVector(259.038,466,876.155));
  q1B_BR = modelXYZ(new PVector(259.038,466,684.759));
  q1B_BL = modelXYZ(new PVector(450.434,466,684.759));
  popMatrix();


  //translate(ax2CenterX,ax2CenterY,ax2CenterZ);
  translate(410, 0, 780); //centerpoint of axis2
  rotateY(angleAxis2);
  translate(-410, -0, -780);
  // translate(-ax2CenterX,-ax2CenterY,-ax2CenterZ);


  pushMatrix(); //because OBJloader comes in mirrored (for right hand rule), we have to unmirror our global mirror with each part
  scale(1, -1);
  //link2_7600.draw();

  popMatrix();

    
     //quad A on Axis 2
   q2A_TL = modelXYZ(new PVector(360,-522,1557));
   q2A_TR = modelXYZ(new PVector(510,-522,1557));
   q2A_BR = modelXYZ(new PVector(510,-492,1257));
   q2A_BL = modelXYZ(new PVector(360,-492,1257));
  
    //quad B on Axis 2
  q2B_TL = modelXYZ(new PVector(241.11,-518,1670.7));
  q2B_TR = modelXYZ(new PVector(543.752,-518,1670.7));
  q2B_BR = modelXYZ(new PVector(590.707,-518,1017.26));
  q2B_BL = modelXYZ(new PVector(353.43,-518,1017.26));
  
      //quad C on Axis 2
  q2C_TL = modelXYZ(new PVector(543.752,-518,1670.7));
  q2C_TR = modelXYZ(new PVector(544.164,-145.86,1670.7));
  q2C_BR = modelXYZ(new PVector(692.316,-145.86,1028.09));
  q2C_BL = modelXYZ(new PVector(692.316,-518,1028.09));
  
  strokeWeight(5);
  stroke(255,0,0);
  point(360,-522,1557);
  point(510,-522,1557);
  point(510,-492,1257);
  point(360,-492,1257);
  strokeWeight(.5);
  //topLeft_Link2  360,-522,1557
  //topRight_Link2 510,-522,1557
  //bottomRight_Link2 510,-492,1257
  //bottomLeft_link 360,-492,1257
  
  translate(410, 0, 1855); //centerpoint of axis3
  rotateY(angleAxis3);
  translate(-410, -0, -1855);

  pushMatrix(); //because OBJloader comes in mirrored (for right hand rule), we have to unmirror our global mirror with each part
  scale(1, -1);
  //link3_7600.draw();
  popMatrix();

  translate(1466, 0, 2020); //centerpoint of axis4
  rotateX(angleAxis4);
  translate(-1466, -0, -2020);

  pushMatrix(); //because OBJloader comes in mirrored (for right hand rule), we have to unmirror our global mirror with each part
  scale(1, -1);
  //link4_7600.draw();
    

  popMatrix();
  //quad A on Axis 4
   q4A_TL = modelXYZ(new PVector(1027.09,-178.469,2223.45));
   q4A_TR = modelXYZ(new PVector(1669.99,-178.469,2223.45));
   q4A_BR = modelXYZ(new PVector(1669.99,-178.469,1816.55));
   q4A_BL = modelXYZ(new PVector(1027.09,-178.469,1816.55));
   
       //quad B on Axis 4
   q4B_TL = modelXYZ(new PVector(1027.09,-178.469,2158.9));
   q4B_TR = modelXYZ(new PVector(1027.09,181.867,2158.9));
   q4B_BR = modelXYZ(new PVector(1263.72,181.867,2158.9));
   q4B_BL = modelXYZ(new PVector(1263.72,-178.469,2158.9));
         //quad C on Axis 4
   q4C_TL = modelXYZ(new PVector(1658.64,181.867,2185.59));
   q4C_TR = modelXYZ(new PVector(1038.44,181.867,2185.59));
   q4C_BR = modelXYZ(new PVector(1038.44,181.867,1854.41));
   q4C_BL = modelXYZ(new PVector(1658.64,181.867,1854.41));
  //draw link 4 stuff here:
  //tl 1027.09,-178.469,2223.45
  //tr 1669.99,-178.469,2223.45
  //br 1669.99,-178.469,1816.55
  //bl 1027.09,-178.469,1816.55

  translate(1466, 0, 2020); //centerpoint of axis4
  rotateY(angleAxis5);
  translate(-1466, -0, -2020);

  pushMatrix(); //because OBJloader comes in mirrored (for right hand rule), we have to unmirror our global mirror with each part
  scale(1, -1);
  //link5_7600.draw();
  popMatrix();

  translate(1466, 0, 2020); //centerpoint of axis4
  rotateX(angleAxis6);
  translate(-1466, -0, -2020);

  pushMatrix(); //because OBJloader comes in mirrored (for right hand rule), we have to unmirror our global mirror with each part
  scale(1, -1);
  //link6_7600.draw();
  popMatrix();

  popMatrix(); //put all of our info inside of a push matrix for the sake of controlp5
  
  // assign robot coordinates to surfaces
  surfaces.get(0).setRobotCoordinates(qBA_TL,qBA_TR,qBA_BR,qBA_BL);
  surfaces.get(1).setRobotCoordinates(q1A_TL,q1A_TR,q1A_BR,q1A_BL);
  surfaces.get(2).setRobotCoordinates(q1B_TL,q1B_TR,q1B_BR,q1B_BL);
  surfaces.get(3).setRobotCoordinates(q2A_TL,q2A_TR,q2A_BR,q2A_BL);
  surfaces.get(4).setRobotCoordinates(q2B_TL,q2B_TR,q2B_BR,q2B_BL);
  surfaces.get(5).setRobotCoordinates(q2C_TL,q2C_TR,q2C_BR,q2C_BL);
  surfaces.get(6).setRobotCoordinates(q4A_TL,q4A_TR,q4A_BR,q4A_BL);
  surfaces.get(7).setRobotCoordinates(q4B_TL,q4B_TR,q4B_BR,q4B_BL);
  surfaces.get(8).setRobotCoordinates(q4C_TL,q4C_TR,q4C_BR,q4C_BL); 
}


void serialEvent(Serial myPort) {
  if (frameCount < 30) {
     myPort.readString();
  }
  else {
    val = myPort.readString(); //Until('\n');
    String[] list = split(val, ' ');
    if (list[1].equals("1")) 
    {
      int ts = millis();
      
      if (!hasFirstTime) {
        t0 = ts;
        hasFirstTime = true;
      }
      
      //println("fakePointsTimed.add(new float[]{"+(ts-t0)+", "+ list[5] + ", " + list[6] + ", " + list[7] + ", " + list[8] + ", " + list[9] + ", " + split(list[10],"\n")[0] +"});");      
      if (isRecordRobot) {
        output.println("fakePointsTimed.add(new float[]{"+(ts-t0)+", "+ list[5] + ", " + list[6] + ", " + list[7] + ", " + list[8] + ", " + list[9] + ", " + split(list[10],"\n")[0] +"});");  
      }
    
      if (!isRobotTimed) {
        angleAxis1 = radians(float(list[5]));
        angleAxis2 = radians(float(list[6]));
        angleAxis3 = radians(float(list[7]));
        angleAxis4 = radians(float(list[8]));
        angleAxis5 = radians(float(list[9]));
        angleAxis6 = radians(float(list[10]));
      }
    }
  }  
}


PVector modelXYZ(PVector localXYZ) {
  return new PVector(modelX(localXYZ.x, localXYZ.y, localXYZ.z), modelY(localXYZ.x, localXYZ.y, localXYZ.z), modelZ(localXYZ.x, localXYZ.y, localXYZ.z));
}
