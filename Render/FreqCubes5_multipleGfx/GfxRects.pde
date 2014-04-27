float offset, rectSizeMult;
int nw, nh, strokeWt, alphF, alphS, fade, rectSize;
ArrayList<NoisyRect> noisyRects;
PGraphics gfxRects, gfxNoisyRects;
PShader shade;
int idxShader;

void setupNoisyRects() {
  gfxRects = createGraphics(gfxResolution, gfxResolution, P2D);
  gfxNoisyRects = createGraphics(gfxResolution, gfxResolution, P2D);
  resetNoisyRects();
}

void resetNoisyRects() {
  noisyRects = new ArrayList<NoisyRect>();
  for (int i=0; i<nw; i++) {
    for (int j=0; j<nh; j++) {
      float x = map(i+0.5, 0, nw, 0, gfxRects.width);
      float y = map(j+0.5, 0, nh, 0, gfxRects.height);
      PVector pos = new PVector(x, y);
      noisyRects.add(new NoisyRect(pos));
    }
  }
}

void drawNoisyRects() 
{
  gfxNoisyRects.beginDraw();
  gfxNoisyRects.fill(0, fade);
  gfxNoisyRects.rect(0, 0, gfxNoisyRects.width, gfxNoisyRects.height); 
  for (NoisyRect nr : noisyRects) {
    nr.draw();
  }
  gfxNoisyRects.endDraw();
  
  gfxRects.shader(shade);
  gfxRects.beginDraw();
  gfxRects.image(gfxNoisyRects, 0, 0);
  gfxRects.endDraw();
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
    rectWidth = (int) (rectSizeMult * gfxNoisyRects.width / nw);
    rectHeight = (int) (rectSizeMult * gfxRects.height / nh);
    nf = map(env[0]*freq[0], 0, 400, 0, 0.3);
    noisePosition.add(new PVector(nf, nf));
    float x = map(noise(noisePosition.x), 0, 1, -offset, offset);
    float y = map(noise(noisePosition.y), 0, 1, -offset, offset);
    offPosition.set(x, y);
    gfxNoisyRects.pushMatrix();
    gfxNoisyRects.pushStyle();
    gfxNoisyRects.rectMode(CENTER);
    gfxNoisyRects.translate(position.x, position.y);
    gfxNoisyRects.translate(offPosition.x, offPosition.y);
    gfxNoisyRects.stroke(255, alphS);
    gfxNoisyRects.strokeWeight(strokeWt);
    gfxNoisyRects.fill(255, alphF);
    gfxNoisyRects.rect(0, 0, rectWidth, rectHeight);
    gfxNoisyRects.popStyle();
    gfxNoisyRects.popMatrix();
  }
}
