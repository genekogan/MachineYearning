// TODO
// ====
// midi control
// interface for assigning sc3 to parameters
// occlusion, synchronization

boolean debugGfx = true;
boolean isRobot = true;
boolean updateGui = true;
boolean occlude = true;

// getting params from robot
// reading params from robot

boolean isRobotTimed = true;
boolean isRecordRobot = false;

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
boolean resetGfx;
int idxSurfaceProject;


void setup() 
{
  size(displayWidth, displayHeight, P3D);
  applet = this;
  
  setupNoisyRects();
  setupBits();
  setupOutlines();
  setupSc3();  
  setupShader();
  setupSerial(); 
  setupSurfaces();
  
  if (isRobotTimed) {
    setupRobotTimed();
  }
  
  if (isRecordRobot) {
    setupRecording();
  }
  
  cf = addControlFrame("gui", 1280, 960);
}

void draw() 
{
  updateSc3Stats();
  setShaderParameters();
  drawNoisyRects();
  drawBits();
  drawOutlines();
  if (isRobotTimed && hasFirstTime) {
    nextRobotTimed();
  }
  getRobotQuads();
  updateSurfaces();
  
  if (updateGui) {
    cf.updateGfx(gfxRects, gfxBits, gfxOutlines);
  }

  background(0);
  for (Surface surface : surfaces) {
    surface.draw();
  }
  //surfaces.get(idxSurfaceProject).draw();
  
  if (resetGfx) {
    setupNoisyRects();
    setupBits();
    setupOutlines();
    setupSurfaces();
    resetGfx = false;
  }  
}

void keyPressed() {
  if (key=='1') {
    debugGfx = !debugGfx;
  }
  else if (key=='2') {
    updateGui = !updateGui;
  }
  else if (key=='3') {
    idxSurfaceProject = (idxSurfaceProject+1)%surfaces.size();    
  }
  else if (key=='4') {
    occlude = !occlude;
  }
  else if (key=='s') {
    output.flush();  // Writes the remaining data to the file
    output.close();  // Finishes the file
  }
}
