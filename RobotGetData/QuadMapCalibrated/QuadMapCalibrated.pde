import deadpixel.keystone.*;
import javax.swing.JFrame;
import KinectProjectorToolkit.*;

boolean calibrated = false;
boolean isRobot = true;
boolean isKeystone = true;
boolean debug = false;
boolean isFake = true;

PVector TL, TR, BR, BL;
PVector pTL, pTR, pBR, pBL;

void setup() {
  size(displayWidth, displayHeight, P3D);
  textFont(createFont("Courier", 24));
  loadCalibration("/Users/Gene/Desktop/robotCalib.txt");
  
  // matching pairs
  TL = new PVector();
  TR = new PVector();
  BR = new PVector();
  BL = new PVector();

  if (isFake) {
    fakeIt();
  } else {
    setupSerial();
  }

  setupKeystone();
}

void draw() {
  if (isFake) {
    nextFake();
  }
  
  if (isRobot) {
    getRobotQuad();
  }
  
  if (debug) {
    println(TL); println(TR);
    println(BR); println(BL);
    println("====");
  }
  
  pTL = convertKinectToProjector(TL);
  pTR = convertKinectToProjector(TR);
  pBR = convertKinectToProjector(BR);
  pBL = convertKinectToProjector(BL);

  moveMeshTo((int) map(pTL.x, 0, 1, 0, width), (int) map(pTL.y, 0, 1, 0, height), 
             (int) map(pTR.x, 0, 1, 0, width), (int) map(pTR.y, 0, 1, 0, height), 
             (int) map(pBR.x, 0, 1, 0, width), (int) map(pBR.y, 0, 1, 0, height),
             (int) map(pBL.x, 0, 1, 0, width), (int) map(pBL.y, 0, 1, 0, height));   
  
  float pfsize = map(sin(0.1*frameCount), -1, 1, 1, 32);
  background(255);
  if (isKeystone) {
    drawQuad();
  } else {
    fill(0, 255, 0);
    ellipse(map(pTL.x, 0, 1, 0, width), map(pTL.y, 0, 1, 0, height), pfsize, pfsize);
    ellipse(map(pTR.x, 0, 1, 0, width), map(pTR.y, 0, 1, 0, height), pfsize, pfsize);
    ellipse(map(pBR.x, 0, 1, 0, width), map(pBR.y, 0, 1, 0, height), pfsize, pfsize);
    ellipse(map(pBL.x, 0, 1, 0, width), map(pBL.y, 0, 1, 0, height), pfsize, pfsize);
  }
  redraw();
}

void keyPressed() {
  if (key==' ') {
    isKeystone = !isKeystone;
  } else if (key=='1') {
    debug = !debug;
  }
}

