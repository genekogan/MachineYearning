import oscP5.*;
import netP5.*;  
import controlP5.*;

ControlP5 cp5;
OscP5 oscP5;
NetAddress myRemoteLocation;

float[] freq;
int[] env;
float offset;
int rectSize;
ArrayList<NoisyRect> noisyRects;
PShader neon;
PGraphics gfx;
boolean viewSc3 = false;

int nw = 12;
int nh = 12;

void setup() {
  size(800, 800, P2D);
  oscP5 = new OscP5(this, 12000);
  rectSize = (int) (1.2 * width / nw);
  noisyRects = new ArrayList<NoisyRect>();
  for (int i=0; i<nw; i++) {
    for (int j=0; j<nh; j++) {
      float x = map(i, 0, nw, 0, width);
      float y = map(j, 0, nh, 0, height);
      PVector pos = new PVector(x, y);
      noisyRects.add(new NoisyRect(pos));
    }
  }
  gfx = createGraphics(width, height, P2D);
 
  setupSc3();
  setupGui();
  freq = new float[6];
  env = new int[6];
  
  neon = loadShader("neon.glsl");
  
}

void draw() 
{
  updateStats();
  offset = map(mouseX, 0, width, 0, 80);
  
  
  // draw graphics
  gfx.beginDraw();
  gfx.fill(0, 80);
  gfx.rect(0, 0, width, height); 
  for (NoisyRect nr : noisyRects) {
    nr.draw();
  } 
  gfx.endDraw();
  
  // render
  PImage gfx2 = gfx.get();
  
  // set parameters
  float brt = map(mouseX, 0, width, 0, 0.5);
  int rad = (int) map(mouseY, 0, height, 0, 3);
  neon.set("brt", brt);
  neon.set("brt", rad);
  
  shader(neon);
  image(gfx2, 0, 0); 
  if (viewSc3) {
    image(stats, 10, 320);
  }
}

void keyPressed() {
  if      (key=='s')  viewSc3 = !viewSc3;
  else if (key=='g') {
    if (cp5.isVisible())  cp5.hide();
    else                  cp5.show();
  }
}

class NoisyRect {
  PVector noisePosition, offPosition, position;
  float nf;
  NoisyRect(PVector position) {
    noisePosition = new PVector(random(20), random(20));
    offPosition = new PVector(0, 0);
    this.position = position;
  }
  void draw() {
    nf = map(env[0]*freq[0], 0, 400, 0, 0.3);
    noisePosition.add(new PVector(nf, nf));
    float x = map(noise(noisePosition.x), 0, 1, -offset, offset);
    float y = map(noise(noisePosition.y), 0, 1, -offset, offset);
    offPosition.set(x, y);
    gfx.pushMatrix();
    gfx.translate(position.x, position.y);
    gfx.translate(offPosition.x, offPosition.y);
    gfx.stroke(255, 50);
    gfx.fill(255, 10);
    gfx.rect(0, 0, rectSize, rectSize);
    gfx.popMatrix();
  }
}
