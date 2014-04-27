float offset, rectSizeMult;
int nw, nh, strokeWt, alphF, alphS, fade, rectSize;
ArrayList<NoisyRect> noisyRects;
PGraphics gfx;
PShader shade;
int idxShader;

void setupNoisyRects() {
  gfx = createGraphics(500, 500, P2D);
  resetNoisyRects();
}

void resetNoisyRects() {
  noisyRects = new ArrayList<NoisyRect>();
  for (int i=0; i<nw; i++) {
    for (int j=0; j<nh; j++) {
      float x = map(i+0.5, 0, nw, 0, gfx.width);
      float y = map(j+0.5, 0, nh, 0, gfx.height);
      PVector pos = new PVector(x, y);
      noisyRects.add(new NoisyRect(pos));
    }
  }
}

void drawNoisyRects() {
  gfx.beginDraw();
  gfx.fill(0, fade);
  gfx.rect(0, 0, gfx.width, gfx.height); 
  for (NoisyRect nr : noisyRects) {
    nr.draw();
  }
  gfx.endDraw();
}

class NoisyRect 
{
  PVector noisePosition, offPosition, position;
  float nf, rectWidth, rectHeight;
  
  NoisyRect(PVector position) {
    noisePosition = new PVector(random(20), random(20));
    offPosition = new PVector(0, 0);
    this.position = position;
  }
  
  void draw() {
    
    rectWidth = (int) (rectSizeMult * gfx.width / nw);
    rectHeight = (int) (rectSizeMult * gfx.height / nh);
    nf = map(env[0]*freq[0], 0, 400, 0, 0.3);
    noisePosition.add(new PVector(nf, nf));
    float x = map(noise(noisePosition.x), 0, 1, -offset, offset);
    float y = map(noise(noisePosition.y), 0, 1, -offset, offset);
    offPosition.set(x, y);
    gfx.pushMatrix();
    gfx.pushStyle();
    gfx.rectMode(CENTER);
    gfx.translate(position.x, position.y);
    gfx.translate(offPosition.x, offPosition.y);
    gfx.stroke(255, alphS);
    gfx.strokeWeight(strokeWt);
    gfx.fill(255, alphF);
    gfx.rect(0, 0, rectWidth, rectHeight);
    gfx.popStyle();
    gfx.popMatrix();
  }
}
