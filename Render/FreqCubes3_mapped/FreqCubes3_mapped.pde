// TODO
// ====
// control resolution of graphics
// more gfx + shaders
// midi control
// interface for base graphics
// interface for assigning sc3 to parameters


boolean debugGfx = false;
boolean isRobot = false;


import oscP5.*;
import netP5.*;  
import controlP5.*;
import java.awt.Frame;
import java.awt.BorderLayout;
import deadpixel.keystone.*;
import javax.swing.JFrame;
import KinectProjectorToolkit.*;
import processing.serial.*;

void setup() 
{
  size(displayWidth, displayHeight, P3D);
  
  setupNoisyRects();
  setupSc3();
  cf = addControlFrame("gui", 1024, 800);
  setupShader();
  setupSerial();
  setupSurfaces();
}

void draw() 
{
  updateSc3Stats();
  setShaderParameters();
  drawNoisyRects();
  getRobotQuads();
  updateSurfaces();

  // render surfaces  
  
  background(0);
  for (Surface surface : surfaces) {
  //  surface.draw();
  }
  
  //background(0);
  image(gfx, 0, 0);
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
}
