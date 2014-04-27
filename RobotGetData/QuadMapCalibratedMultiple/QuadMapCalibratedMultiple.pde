import deadpixel.keystone.*;
import javax.swing.JFrame;
import KinectProjectorToolkit.*;

boolean calibrated = false;
boolean isRobot = true;
boolean isKeystone = true;
boolean debug = true;
boolean isFake = true;

//PVector TL, TR, BR, BL;
//PVector pTL, pTR, pBR, pBL;


KS kks;
ArrayList<KS> kkss;

void setup() {
  size(displayWidth, displayHeight, P3D);
  //textFont(createFont("Courier", 24));
  
  ks = new Keystone(this);
  
    
  
  if (isFake) {
    fakeIt();
  } else {
    setupSerial();
  }

  setupSurfaces();
//  setupKeystone();
  
  kks = new KS();
  
  kkss = new ArrayList<KS>();
  for (int i=0; i<9; i++) {
    kkss.add(new KS());
  }
  
  // matching pairs
  /*
  TL = new PVector();
  TR = new PVector();
  BR = new PVector();
  BL = new PVector();
*/
}

void draw() {
  background(0);
  if (isFake) {
    nextFake();
  }
  
  if (isRobot) {
    //getRobotQuad();
    getRobotQuads();
  }
  
  for (Surface s :surfaces) {
   // s.draw();
  }
  
  
  for (KS k : kkss) {
    k.mapToRobot();
    k.drawQuad();
  }
  
  kks.mapToRobot();
  
  
  kks.drawQuad();
  
}

void keyPressed() {
  if (key==' ') {
    isKeystone = !isKeystone;
  } else if (key=='1') {
    debug = !debug;
  }
  else if (key=='2')   idxS = (idxS + 1) % 9;
}

