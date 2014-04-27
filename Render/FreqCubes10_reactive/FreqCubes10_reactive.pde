// MACHINE YEARNING
// ================
// midi control
// interface for assigning sc3 to parameters
// occlusion, synchronization

String CALIBRATION_FILE = "/Users/Gene/Projects/MachineYearning/RobotCalibration.txt";
String POINTS_RECORDING = "/Users/Gene/Projects/MachineYearning/Robot_Recorder/positions.txt";


boolean debugGfx = false;
boolean drawOneSurface = false;
boolean updateGui = true;
boolean occlude = true;
boolean resetGfx = false;
boolean isPaused = false;
boolean toResetGfx = false;

boolean isSerial = true;
boolean isRobotTimed = true;
boolean isRecordRobot = false;

int lookAhead = 590;

import oscP5.*;
import netP5.*;  
import controlP5.*;
import java.awt.Frame;
import java.awt.BorderLayout;
import deadpixel.keystone.*;
import javax.swing.JFrame;
import KinectProjectorToolkit.*;
import processing.serial.*;

PApplet applet;
float alph = 0.0;
boolean hasStarted = false;

void setup() 
{
  size(displayWidth, displayHeight, P3D);
  applet = this;
  setupGfx();  
  
  setupMachineStats();
  
  setupBackwall();
  
  if (isSerial) {
    setupSerial();
  } 
  setupSurfaces();
  
  if (isRobotTimed) {
    setupRobotTimed(POINTS_RECORDING);
  }
  else if (isRecordRobot) {
    setupRecording();
  }
  
  cf = addControlFrame("gui", 1440, 1020);
}

void draw() 
{  
  /*
  if (frameCount % 800 == 0) {
    debugGfx = !debugGfx;
  }
  */
  
  try {
    updateMachineStats();
    if (toResetGfx) {
      resetGraphics();
      toResetGfx = false;
    }
    updateGfx();
  
    if (isRobotTimed && hasFirstTime && !isPaused) {
      try {
        nextRobotTimed();
      } catch(Exception e) {
        println("error "+e.toString());
      }
    }
    getRobotQuads();
    updateSurfaces();
  
    if (updateGui) {
      cf.updateGfx(gfx);
    }
  
    background(0);
    if (hasStarted) {
      alph = min(alph + 0.3, 255);
    }
    if (alph < 254) {
      tint(255, alph);
    }
    if (drawOneSurface) {
      surfaces.get(idxSurfaceProject).draw();
    } else {      
      for (int i=0; i<sortedIndexes.length; i++) {
        Surface s = surfaces.get(sortedIndexes[i]);
        s.draw();
      }
    }      
    if (resetGfx) {
      resetGraphics();
    }    
  }
  catch (Exception e) {
    println("ERROR! "+e.toString());
  }
}

void resetGraphics() {
  setupGfx();
  resetSurfaces();
  resetGfx = false;
}

void resetGraphics(int idx) {
  gfxMode = idx;
  toResetGfx = true;
}



void keyPressed() 
{
  if (key=='~') {
    hasStarted = true;
  }
  else if (key=='1') {
    debugGfx = !debugGfx;
  }
  else if (key=='2') {
    updateGui = !updateGui;
  }
  else if (key=='3') {
    idxSurfaceProject = (idxSurfaceProject+1) % surfaces.size();    
  }
  else if (key=='4') {
    occlude = !occlude;
  }
  else if (key=='5') {
    isPaused = !isPaused;
  }
  else if (key=='6') {
    gfxMode = (gfxMode+1) % 9;
    resetGraphics();
  }
  
  /*
  
  else if (key=='q') {
    moveBackwall1(mouseX, w1xTR, w1xBR, w1xBL, mouseY, w1yTR, w1yBR, w1yBL);
  }
  else if (key=='w') {
    moveBackwall1(w1xTL, mouseX, w1xBR, w1xBL, w1yTL, mouseY, w1yBR, w1yBL);
  }
  else if (key=='e') {
    moveBackwall1(w1xTL, w1xTR, mouseX, w1xBL, w1yTL, w1yTR, mouseY, w1yBL);
  }
  else if (key=='r') {
    moveBackwall1(w1xTL, w1xTR, w1xBR, mouseX, w1yTL, w1yTR, w1yBR, mouseY);
  }
    else if (key=='a') {
    moveBackwall2(mouseX, w2xTR, w2xBR, w2xBL, mouseY, w2yTR, w2yBR, w2yBL);
  }
  else if (key=='s') {
    moveBackwall2(w2xTL, mouseX, w2xBR, w2xBL, w2yTL, mouseY, w2yBR, w2yBL);
  }
  else if (key=='d') {
    moveBackwall2(w2xTL, w2xTR, mouseX, w2xBL, w2yTL, w2yTR, mouseY, w2yBL);
  }
  else if (key=='e') {
    moveBackwall2(w2xTL, w2xTR, w2xBR, mouseX, w2yTL, w2yTR, w2yBR, mouseY);
  }
  */
  
  
}
