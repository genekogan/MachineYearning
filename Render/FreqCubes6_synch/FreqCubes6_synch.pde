// MACHINE YEARNING
// ================
// midi control
// interface for assigning sc3 to parameters
// occlusion, synchronization

boolean debugGfx = true;
boolean drawOneSurface = false;
boolean updateGui = true;
boolean occlude = true;
boolean resetGfx = false;
boolean isPaused = false;

boolean isSerial = false;
boolean isRobotTimed = true;
boolean isRecordRobot = false;

int delay = 800;

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
  
  setupNoisyRects();
  setupBits();
  setupOutlines();
  setupFull();
  
  setupShader();
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
  
  //projector = new PVector(-1994,3378, map(mouseY, 0, height, 0, 1000));
  //projector = new PVector(-1994,map(mouseX, 0, width, -1000, 8000), map(mouseY, 0, height, -1000, 1000));
  
  updateSc3Stats();
  setShaderParameters();
  
  drawNoisyRects();
  drawBits();
  drawOutlines();
  drawFull();
  
  if (isRobotTimed && hasFirstTime && !isPaused) {
    nextRobotTimed();
  }
  getRobotQuads();
  updateSurfaces();
  
  if (updateGui) {
    cf.updateGfx(gfxRects, gfxBits, gfxOutlines, gfxFull);
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
  setupNoisyRects();
  setupBits();
  setupOutlines();
  setupFull();
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
}
