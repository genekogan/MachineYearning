// TODO
// ====
// control resolution of graphics
// more gfx + shaders
// midi control
// interface for base graphics
// interface for assigning sc3 to parameters


boolean debugGfx = false;
boolean isRobot = false;
boolean updateGui = true;

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
  setupSc3();
  
  setupShader();
  setupSerial();
  setupSurfaces();
  
  cf = addControlFrame("gui", 1280, 960);
}

void draw() 
{
  updateSc3Stats();
  setShaderParameters();
  drawNoisyRects();
  getRobotQuads();
  updateSurfaces();
  
  if (updateGui) {
    cf.updateGfx(gfx);
  }
  
  background(0);
  for (Surface surface : surfaces) {
    surface.draw();
  }  
}

void keyPressed() {
  if      (keyCode==LEFT) {
    idxShader = (idxShader + shaders.length - 1) % shaders.length;
    setupShader();
  }    
  else if (keyCode==RIGHT) {
    idxShader = (idxShader + 1) % shaders.length;
    setupShader();
  }
  else if (key=='g') {
    if (cf.cp5.isVisible())  cf.cp5.hide();
    else                     cf.cp5.show();
  }  
  else if (key=='1') {
    debugGfx = !debugGfx;
  }
  else if (key=='2') {
    updateGui = !updateGui;
  }

}
