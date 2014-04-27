import processing.serial.*;

Serial myPort;  // Create object from Serial class
String val;      // Data received from the serial port
String incomingLine; //our line received

float angleAxis1, angleAxis2, angleAxis3, angleAxis4, angleAxis5, angleAxis6;
PVector topLeft_Link2, topRight_Link2, bottomRight_Link2, bottomLeft_Link2;

void setupSerial() {
  String portName = Serial.list()[5];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
}

void getRobotQuad() {
    pushMatrix(); //put all of our info inside of a push matrix for the sake of controlp5

  scale(1, -1);
  //background(0);

  strokeWeight(.5);

  pushMatrix(); //because OBJloader comes in mirrored (for right hand rule), we have to unmirror our global mirror with each part
  scale(1, -1);
  //base_7600.draw();
  popMatrix();

  rotateZ(angleAxis1);



  pushMatrix(); //because OBJloader comes in mirrored (for right hand rule), we have to unmirror our global mirror with each part
  scale(1, -1);
  //link1_7600.draw();
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
  //here is where points on axis2 should be drawn
  topLeft_Link2 = modelXYZ(new PVector(360,-522,1557));
  topRight_Link2 = modelXYZ(new PVector(510,-522,1557));
  bottomRight_Link2 = modelXYZ(new PVector(510,-492,1257));
  bottomLeft_Link2 = modelXYZ(new PVector(360,-492,1257));
  
  
  //strokeWeight(5);
  //stroke(255,0,0);
  //point(360,-522,1557);
  //point(510,-522,1557);
  //point(510,-492,1257);
  //point(360,-492,1257);
 // strokeWeight(.5);
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
  
  TL = topLeft_Link2;
  TR = topRight_Link2;
  BR = bottomRight_Link2;
  BL = bottomLeft_Link2;
  
  TL.y *= -1;
  TR.y *= -1;
  BR.y *= -1;
  BL.y *= -1;
}


void serialEvent(Serial myPort) {
  if (frameCount < 100) {
     myPort.readString();
  }
  else {
    val = myPort.readString(); //Until('\n');
    //println(val);
    String[] list = split(val, ' ');
    //if the second value is "1" then we are getting a joint angle string
    if (list[1].equals("1")) {
      //println("axis1 = " + list[5] + "axis2 = " + list[6] + "axis3 = " + list[7] + "axis4 = " + list[8] + "axis5 = " + list[9] + "axis6 = " + list[10]);
      println(list[5]+"," + list[6]+"," + list[7]+"," +  list[8] +"," +  list[9] +"," +  list[10]);
      angleAxis1 = radians(float(list[5]));
      angleAxis2 = radians(float(list[6]));
      angleAxis3 = radians(float(list[7]));
      angleAxis4 = radians(float(list[8]));
      angleAxis5 = radians(float(list[9]));
      angleAxis6 = radians(float(list[10]));
    }
  }
  
}


PVector modelXYZ(PVector localXYZ) {
  return new PVector(modelX(localXYZ.x, localXYZ.y, localXYZ.z), modelY(localXYZ.x, localXYZ.y, localXYZ.z), modelZ(localXYZ.x, localXYZ.y, localXYZ.z));
}
