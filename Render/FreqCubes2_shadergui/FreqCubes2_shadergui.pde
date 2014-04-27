import oscP5.*;
import netP5.*;  
import controlP5.*;

ControlP5 cp5;
OscP5 oscP5;
NetAddress myRemoteLocation;
PGraphics stats;
boolean viewSc3;
float[] freq;
int[] env;
float offset, rectSizeMult;
int nw, nh, strokeWt, alphF, alphS, fade, rectSize;
ArrayList<NoisyRect> noisyRects;
PGraphics gfx;
PShader shade;
int idxShader;

// TODO
// ====
// midi control
// map gui parameters to audio
// map shader parameters  to audio


void setup() 
{
  size(1024, 800, P2D);
  textSize(22);
  fill(0);
  
  resetNoisyRects();
  gfx = createGraphics(width, height, P2D);
  setupSc3();
  setupGui();
  setupShader();
}

void draw() 
{
  setShaderParameters();
  updateStats();
  drawNoisyRects();
  
  shader(shade);
  image(gfx, 0, 0, width, height);
  resetShader();
  if (viewSc3) {
    image(stats, width - stats.width - 20, height - stats.height - 10);
  }
  if (cp5.isVisible()) {
    pushStyle();
    fill(0, 200);
    rect(2, 6, 250, height-12);
    popStyle();
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
  else if (key=='s') {
    viewSc3 = !viewSc3;
  }
  else if (key=='g') {
    if (cp5.isVisible())  cp5.hide();
    else                  cp5.show();
  }
}
