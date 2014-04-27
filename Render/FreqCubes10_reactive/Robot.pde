Serial myPort;  // Create object from Serial class
String val;      // Data received from the serial port
String incomingLine; //our line received

float angleAxis1, angleAxis2, angleAxis3, angleAxis4, angleAxis5, angleAxis6;

//PVector projector = new PVector(-1994,3378,500); // old projector placement

PVector projector = new PVector(1504.7, -2832.28, -40.339);  

boolean hasFirstTime = false;
int t0 = 0;


//DEFINE OUR QUADS
PVector qBA_TL, qBA_TR, qBA_BR, qBA_BL;

PVector q1A_TL, q1A_TR, q1A_BR, q1A_BL;
PVector q1B_TL, q1B_TR, q1B_BR, q1B_BL;
PVector q1C_TL, q1C_TR, q1C_BR, q1C_BL;
PVector q1D_TL, q1D_TR, q1D_BR, q1D_BL;
PVector q1E_TL, q1E_TR, q1E_BR, q1E_BL;

PVector q2A_TL, q2A_TR, q2A_BR, q2A_BL;
PVector q2B_TL, q2B_TR, q2B_BR, q2B_BL;
PVector q2C_TL, q2C_TR, q2C_BR, q2C_BL;
PVector q2D_TL, q2D_TR, q2D_BR, q2D_BL;
PVector q2E_TL, q2E_TR, q2E_BR, q2E_BL;

PVector q3A_TL, q3A_TR, q3A_BR, q3A_BL;
PVector q3B_TL, q3B_TR, q3B_BR, q3B_BL;
PVector q3C_TL, q3C_TR, q3C_BR, q3C_BL;
PVector q3D_TL, q3D_TR, q3D_BR, q3D_BL;

PVector q4A_TL, q4A_TR, q4A_BR, q4A_BL;
PVector q4B_TL, q4B_TR, q4B_BR, q4B_BL;
PVector q4C_TL, q4C_TR, q4C_BR, q4C_BL;
PVector q4D_TL, q4D_TR, q4D_BR, q4D_BL;
PVector q4E_TL, q4E_TR, q4E_BR, q4E_BL;
PVector q4F_TL, q4F_TR, q4F_BR, q4F_BL;
PVector q4G_TL, q4G_TR, q4G_BR, q4G_BL;
PVector q4H_TL, q4H_TR, q4H_BR, q4H_BL;

PVector q6A_TL, q6A_TR, q6A_BR, q6A_BL;


void setupSerial() {
  println("setup serial");
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
  qBA_TL = modelXYZ(new PVector(-302.364, 0, 397));
  qBA_TR = modelXYZ(new PVector(302.364, 0, 397));
  qBA_BR = modelXYZ(new PVector(302.364, 0, 144));
  qBA_BL = modelXYZ(new PVector(-302.364, 0, 144));
  popMatrix();

  rotateZ(angleAxis1);

  pushMatrix(); //because OBJloader comes in mirrored (for right hand rule), we have to unmirror our global mirror with each part
  scale(1, -1);
  //link1_7600.draw();
  popMatrix();
  //quad A on Axis 1
  q1A_TL = modelXYZ(new PVector(-545.424,-435.096,763.485));
  q1A_TR = modelXYZ(new PVector(513.775, -435.096, 916.496));
  q1A_BR = modelXYZ(new PVector(513.775, -435.096, 402.081));
  q1A_BL = modelXYZ(new PVector(-545.424,-435.096,402.081));
  //quad B on Axis 1
  q1B_TL = modelXYZ(new PVector(513.775, -435.096, 916.496));
  q1B_TR = modelXYZ(new PVector(513.775, 125, 916.496));
  q1B_BR = modelXYZ(new PVector(513.775, 125, 402.081));
  q1B_BL = modelXYZ(new PVector(513.775, -435.096, 402.081));

  q1C_TL = modelXYZ(new PVector(444.343,140,875.591));
  q1C_TR = modelXYZ(new PVector(444.343,461,875.591));
  q1C_BR = modelXYZ(new PVector(444.343,461,689.967));
  q1C_BL = modelXYZ(new PVector(444.343,140,689.967));

  q1D_TL = modelXYZ(new PVector(-546.869,6.60708,841.412));
  q1D_TR = modelXYZ(new PVector(-546.869,-436.607,841.412));
  q1D_BR = modelXYZ(new PVector(-546.869,-436.607,398.198));
  q1D_BL = modelXYZ(new PVector(-546.869,6.60708,398.198));
  
  q1E_TL = modelXYZ(new PVector(-545.424,-214.1,850.224));
  q1E_TR = modelXYZ(new PVector(112.917,-214.1,945.328));
  q1E_BR = modelXYZ(new PVector(112.917,-435.096,858.589));
  q1E_BL = modelXYZ(new PVector(-545.424,-435.096,763.485));

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
  q2A_TL = modelXYZ(new PVector(242.267, -518, 1670.7));
  q2A_TR = modelXYZ(new PVector(649.369, -518, 1670.7));
  q2A_BR = modelXYZ(new PVector(680.434, -340.661, 869.25));
  q2A_BL = modelXYZ(new PVector(237.187, -340.661, 869.25));

  //quad B on Axis 2
  q2B_TL = modelXYZ(new PVector(649.369, -518, 1670.7));
  q2B_TR = modelXYZ(new PVector(649.369, -232.051, 1670.7));
  q2B_BR = modelXYZ(new PVector(680.434, -54.7125, 869.25));
  q2B_BL = modelXYZ(new PVector(680.434, -340.661, 869.25));

  //quad C on Axis 2
  q2C_TL = modelXYZ(new PVector(649.369, -232.051, 1670.7));
  q2C_TR = modelXYZ(new PVector(242.267, -152.379, 1670.7));
  q2C_BR = modelXYZ(new PVector(237.187, 24.9599, 869.25));
  q2C_BL = modelXYZ(new PVector(680.434, -54.7125, 869.25));

  q2D_TL = modelXYZ(new PVector(242.267, -152.379, 1670.7));
  q2D_TR = modelXYZ(new PVector(242.267, -518, 1670.7));
  q2D_BR = modelXYZ(new PVector(237.187, -340.661, 869.25));
  q2D_BL = modelXYZ(new PVector(237.187, 24.9599, 869.25));

  q2E_TL = modelXYZ(new PVector(227.001, -380, 2038));
  q2E_TR = modelXYZ(new PVector(593, -380, 2038));
  q2E_BR = modelXYZ(new PVector(593, -380, 1672));
  q2E_BL = modelXYZ(new PVector(227.001, -380, 1672));

  strokeWeight(5);
  stroke(255, 0, 0);
  point(360, -522, 1557);
  point(510, -522, 1557);
  point(510, -492, 1257);
  point(360, -492, 1257);
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
  q3A_TL = modelXYZ(new PVector(668.286, 350.979, 2206.08));
  q3A_TR = modelXYZ(new PVector(668.286, -255, 2206.08));
  q3A_BR = modelXYZ(new PVector(106.061, -255, 2206.08));
  q3A_BL = modelXYZ(new PVector(106.061, 350.979, 2206.08));

  q3B_TL = modelXYZ(new PVector(668.286, 350.979, 2206.08));
  q3B_TR = modelXYZ(new PVector(106.061, 350.979, 2206.08));
  q3B_BR = modelXYZ(new PVector(106.061, 350.979, 1833.92));
  q3B_BL = modelXYZ(new PVector(668.286, 350.979, 1833.92));

  q3C_TL = modelXYZ(new PVector(106.061, 350.979, 2206.08));
  q3C_TR = modelXYZ(new PVector(106.061, -255, 2206.08));
  q3C_BR = modelXYZ(new PVector(106.061, -255, 1833.92));
  q3C_BL = modelXYZ(new PVector(106.061, 350.979, 1833.92));

  q3D_TL = modelXYZ(new PVector(593, -380, 2038));
  q3D_TR = modelXYZ(new PVector(593, 157, 2038));
  q3D_BR = modelXYZ(new PVector(593, 157, 1672));
  q3D_BL = modelXYZ(new PVector(593, -380, 1672));

  translate(1466, 0, 2020); //centerpoint of axis4
  rotateX(angleAxis4);
  translate(-1466, -0, -2020);
  pushMatrix(); //because OBJloader comes in mirrored (for right hand rule), we have to unmirror our global mirror with each part
  scale(1, -1);
  //link4_7600.draw();
  popMatrix();

  //quad A on Axis 4
  q4A_TL = modelXYZ(new PVector(1027.09, -178.469, 2219.44));
  q4A_TR = modelXYZ(new PVector(1669.99, -178.469, 2219.44));
  q4A_BR = modelXYZ(new PVector(1669.99, -178.469, 1820.56));
  q4A_BL = modelXYZ(new PVector(1027.09, -178.469, 1820.56));

  //quad B on Axis 4
  q4B_TL = modelXYZ(new PVector(1027.09, 221.489, 2219.44));
  q4B_TR = modelXYZ(new PVector(1669.99, 221.489, 2219.44));
  q4B_BR = modelXYZ(new PVector(1669.99, -178.469, 2219.44));
  q4B_BL = modelXYZ(new PVector(1027.09, -178.469, 2219.44));
  //quad C on Axis 4
  q4C_TL = modelXYZ(new PVector(1027.09, 221.489, 1820.56));
  q4C_TR = modelXYZ(new PVector(1669.99, 221.489, 1820.56));
  q4C_BR = modelXYZ(new PVector(1669.99, 221.489, 2219.44));
  q4C_BL = modelXYZ(new PVector(1027.09, 221.489, 2219.44));
  //draw link 4 stuff here:
  q4D_TL = modelXYZ(new PVector(1027.09, -178.469, 1820.56));
  q4D_TR = modelXYZ(new PVector(1669.99, -178.469, 1820.56));
  q4D_BR = modelXYZ(new PVector(1669.99, 221.489, 1820.56));
  q4D_BL = modelXYZ(new PVector(1027.09, 221.489, 1820.56));



  q4E_TL = modelXYZ(new PVector(670.001, -97.8369, 2124.14));
  q4E_TR = modelXYZ(new PVector(1027.09, -97.8369, 2124.14));
  q4E_BR = modelXYZ(new PVector(1027.09, -97.8369, 1915.86));
  q4E_BL = modelXYZ(new PVector(670.001, -97.8369, 1915.86));

  q4F_TL = modelXYZ(new PVector(670.001, 97.8369, 2124.14));
  q4F_TR = modelXYZ(new PVector(1027.09, 97.8369, 2124.14));
  q4F_BR = modelXYZ(new PVector(1027.09, -97.8369, 2124.14));
  q4F_BL = modelXYZ(new PVector(670.001, -97.8369, 2124.14));

  q4G_TL = modelXYZ(new PVector(1027.09, 97.8369, 2124.14));
  q4G_TR = modelXYZ(new PVector(670.001, 97.8369, 2124.14));
  q4G_BR = modelXYZ(new PVector(670.001, 97.8369, 1915.86));
  q4G_BL = modelXYZ(new PVector(1027.09, 97.8369, 1915.86));

  q4H_TL = modelXYZ(new PVector(1027.09, 97.8369, 1915.86));
  q4H_TR = modelXYZ(new PVector(670.001, 97.8369, 1915.86));
  q4H_BR = modelXYZ(new PVector(670.001, -97.8369, 1915.86));
  q4H_BL = modelXYZ(new PVector(1027.09, -97.8369, 1915.86));

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

  q6A_TL = modelXYZ(new PVector(1766, -124.837, 2144.84));
  q6A_TR = modelXYZ(new PVector(1766, 124.837, 2144.84));
  q6A_BR = modelXYZ(new PVector(1766, 124.837, 1895.16));
  q6A_BL = modelXYZ(new PVector(1766, -124.837, 1895.16));

  popMatrix(); //put all of our info inside of a push matrix for the sake of controlp5
  
  
  // assign robot coordinates to surfaces
  surfaces.get(0).setRobotCoordinates(qBA_TL, qBA_TR, qBA_BR, qBA_BL);
  
  surfaces.get(1).setRobotCoordinates(q1A_TL, q1A_TR, q1A_BR, q1A_BL);
  surfaces.get(2).setRobotCoordinates(q1B_TL, q1B_TR, q1B_BR, q1B_BL);
  surfaces.get(3).setRobotCoordinates(q1C_TL, q1C_TR, q1C_BR, q1C_BL);
  surfaces.get(4).setRobotCoordinates(q1D_TL, q1D_TR, q1D_BR, q1D_BL);
  surfaces.get(5).setRobotCoordinates(q1E_TL, q1E_TR, q1E_BR, q1E_BL);
  
  surfaces.get(6).setRobotCoordinates(q2A_TL, q2A_TR, q2A_BR, q2A_BL);
  surfaces.get(7).setRobotCoordinates(q2B_TL, q2B_TR, q2B_BR, q2B_BL);
  surfaces.get(8).setRobotCoordinates(q2C_TL, q2C_TR, q2C_BR, q2C_BL);
  surfaces.get(9).setRobotCoordinates(q2D_TL, q2D_TR, q2D_BR, q2D_BL);
  surfaces.get(10).setRobotCoordinates(q2E_TL, q2E_TR, q2E_BR, q2E_BL);
  
  surfaces.get(11).setRobotCoordinates(q3A_TL, q3A_TR, q3A_BR, q3A_BL);
  surfaces.get(12).setRobotCoordinates(q3B_TL, q3B_TR, q3B_BR, q3B_BL);
  surfaces.get(13).setRobotCoordinates(q3C_TL, q3C_TR, q3C_BR, q3C_BL);
  surfaces.get(14).setRobotCoordinates(q3D_TL, q3D_TR, q3D_BR, q3D_BL);
  
  surfaces.get(15).setRobotCoordinates(q4A_TL, q4A_TR, q4A_BR, q4A_BL);
  surfaces.get(16).setRobotCoordinates(q4B_TL, q4B_TR, q4B_BR, q4B_BL);
  surfaces.get(17).setRobotCoordinates(q4C_TL, q4C_TR, q4C_BR, q4C_BL);
  surfaces.get(18).setRobotCoordinates(q4D_TL, q4D_TR, q4D_BR, q4D_BL);
  surfaces.get(19).setRobotCoordinates(q4E_TL, q4E_TR, q4E_BR, q4E_BL);
  surfaces.get(20).setRobotCoordinates(q4F_TL, q4F_TR, q4F_BR, q4F_BL);
  surfaces.get(21).setRobotCoordinates(q4G_TL, q4G_TR, q4G_BR, q4G_BL);
  surfaces.get(22).setRobotCoordinates(q4H_TL, q4H_TR, q4H_BR, q4H_BL);
  
  surfaces.get(23).setRobotCoordinates(q6A_TL, q6A_TR, q6A_BR, q6A_BL);
  
}


void serialEvent(Serial myPort) {
  
  if (frameCount < 30) {
     myPort.readString();
  }
  else {
    
    val = myPort.readString(); //Until('\n');
    //println(val);
    String[] list = split(val, ' ');
    if (list[1].equals("1")) 
    {
      int ts = millis();
         
      if (!hasFirstTime) {
        t0 = ts;
        hasFirstTime = true;
      }
      
            
      if (isRecordRobot) {
        //println("fakePointsTimed.add(new float[]{"+(ts-t0)+", "+ list[5] + ", " + list[6] + ", " + list[7] + ", " + list[8] + ", " + list[9] + ", " + split(list[10],"\n")[0] +"});");
        //output.println("fakePointsTimed.add(new float[]{"+(ts-t0)+", "+ list[5] + ", " + list[6] + ", " + list[7] + ", " + list[8] + ", " + list[9] + ", " + split(list[10],"\n")[0] +"});");  
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
