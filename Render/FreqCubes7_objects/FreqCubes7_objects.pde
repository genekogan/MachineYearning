// MACHINE YEARNING
// ================
// midi control
// interface for assigning sc3 to parameters
// occlusion, synchronization

String CALIBRATION_FILE = "/Users/Gene/Projects/MachineYearning/RobotCalibration.txt";

boolean debugGfx = true;
boolean drawOneSurface = false;
boolean updateGui = true;
boolean occlude = true;
boolean resetGfx = false;
boolean isPaused = false;

boolean isSerial = false;
boolean isRobotTimed = true;
boolean isRecordRobot = false;

int delay = 630;

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

void setup() 
{
  size(displayWidth, displayHeight, P3D);
  applet = this;
  setupGfx();  
  setupSc3();  
  
  if (isSerial) {
    setupSerial();
  } 
  setupSurfaces();
  
  if (isRobotTimed) {
    setupRobotTimed("positions.txt");
  }
  else if (isRecordRobot) {
    setupRecording();
  }
  
  cf = addControlFrame("gui", 1440, 1020);
}

void draw() 
{
  updateSc3Stats();
  updateGfx();

  if (isRobotTimed && hasFirstTime && !isPaused) {
    nextRobotTimed();
  }
  getRobotQuads();
  updateSurfaces();

  
  if (updateGui) {
    cf.updateGfx(gfx);
  }

  background(0);
  if (drawOneSurface) {
    surfaces.get(idxSurfaceProject).draw();
  } else {
    for (Surface surface : surfaces) {
      surface.draw();
    }
  }  
  
  if (resetGfx) {
    resetGraphics();
  }
}

void resetGraphics() {
  setupGfx();
  setupSurfaces();
  resetGfx = false;
}

void keyPressed() 
{
  if (key=='1') {
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
    gfxMode = (gfxMode+1)%3;
    resetGraphics();
  }
}
