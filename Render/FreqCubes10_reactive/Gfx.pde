interface Gfx {
  void setup();
  void draw();
  PGraphics get();
  PImage getImage();
}

//==============================================================================================================
//==============================================================================================================
//====  GFX BITS
//==============================================================================================================
//==============================================================================================================

class GfxBits implements Gfx {
  PGraphics pg;
  PShader shadeBits;  
  float mx, my, dx, dy, speed, dSpeed;

  GfxBits() {
    mx = 1.0;
    my = 1.0;
    dx = 0.03;
    dy = 0.15;
    speed = 0.0;
    dSpeed = 0;
    setup();
  }

  void setup() {
    pg = createGraphics(gfxResolution, gfxResolution, P2D);
    shadeBits = loadShader("bits.glsl");
    shadeBits.set("resolution", float(pg.width), float(pg.height));
    pg.shader(shadeBits); 
    pg.beginDraw();
    pg.background(255);
    pg.endDraw();
  }

  void setParameters(float p1, float p2, float p3) {
    dx = p1;
    dy = p2; 
    dSpeed = p3;
  }

  void draw() 
  { 
    speed += dSpeed;
    shadeBits.set("time", millis()/1000.0 + speed);  
    shadeBits.set("mx", mx);
    shadeBits.set("my", my);
    shadeBits.set("dx", dx);
    shadeBits.set("dy", dy);


    pg.beginDraw();
    pg.background(255);
    pg.rect(0, 0, pg.width, pg.height);
    pg.endDraw();
  } 

  PGraphics get() {
    return pg;
  }

  PImage getImage() {
    return pg.get();
  }
}



//==============================================================================================================
//==============================================================================================================
//====  GFX FULL
//==============================================================================================================
//==============================================================================================================

class GfxFull implements Gfx {
  PGraphics pg;
  float h, s, b; 

  GfxFull() {
    h = random(0, 255);
    s = random(100, 255);
    b = random(100, 255);
    setup();
  }

  void setup() {
    pg = createGraphics(gfxResolution, gfxResolution, P2D);
  }

  void draw() {  
    pg.beginDraw();
    pg.colorMode(HSB);
    pg.background(h, s, b);
    pg.endDraw();
  }

  void setParameters(float h1, float s1, float b1) {
    h = h1;
    s = s1;
    b = b1;
  }

  PGraphics get() {
    return pg;
  }

  PImage getImage() {
    return pg.get();
  }
}  




//==============================================================================================================
//==============================================================================================================
//====  GFX OUTLINES
//==============================================================================================================
//==============================================================================================================

class GfxOutlines implements Gfx {
  PGraphics pg;
  PShader outliner;
  float mult, phase, rad, give, r, g, b, threshLen, threshSpeed;

  GfxOutlines() {
    mult = 1.0;
    phase = 0.0;
    rad = 0.93;
    give = 0.06;
    r = random(0.7, 1);
    g = random(0.8, 1);
    b = random(0.7, 1);
    threshLen = 0.57;
    threshSpeed = 4.5;
    setup();
  }

  void setup() {
    pg = createGraphics(gfxResolution, gfxResolution, P2D);
    outliner = loadShader("outlines.glsl");
    outliner.set("resolution", float(pg.width), float(pg.height));
  }

  void setParameters(float p1, float p2, float p3, float p4, float p5, float p6) {
    mult = p1;
    phase = p2;
    rad = p3;
    give = p4;
    threshLen = p5;
    threshSpeed = p6;
  }

  void draw() {
    outliner.set("time", millis() / 1000.0);
    outliner.set("mult", mult);
    outliner.set("phase", phase);
    outliner.set("rad", rad);
    outliner.set("give", give);
    outliner.set("r", r);
    outliner.set("g", g);
    outliner.set("b", b);
    outliner.set("threshLen", threshLen);
    outliner.set("threshSpeed", threshSpeed);

    pg.beginDraw();
    pg.shader(outliner);
    pg.rect(0, 0, pg.width, pg.height);
    pg.endDraw();
  }

  PGraphics get() {
    return pg;
  }

  PImage getImage() {
    return pg.get();
  }
}


//==============================================================================================================
//==============================================================================================================
//====  GFX NOISY RECTS
//==============================================================================================================
//==============================================================================================================

class GfxNoisyRects implements Gfx 
{
  float offset, rectSizeMult;
  int nw, nh, strokeWt, alphF, alphS, fade, rectSize;
  ArrayList<NoisyRect> noisyRects;
  PGraphics gfxRects, pg;
  //PShader shade;
  //int idxShader;

  GfxNoisyRects() {
    nw = 6;
    nh = 7;
    strokeWt = 2;
    alphS = alphF = 70;
    setup();
  }

  void setup() {
    pg = createGraphics(gfxResolution, gfxResolution, P2D);
    resetNoisyRects();
  }

  void setParameters(float p0, float p1, float p2, float p3, float p4, float p5, float p6) {
    rectSize = (int) p0;
    strokeWt = (int) p1;
    alphF = (int) p2;
    alphS = (int) p3;
    fade = (int) p4;
    rectSizeMult = p5;
    offset = p6;
  }


  void resetNoisyRects() {
    noisyRects = new ArrayList<NoisyRect>();
    for (int i=0; i<nw; i++) {
      for (int j=0; j<nh; j++) {
        float x = map(i+0.5, 0, nw, 0, pg.width);
        float y = map(j+0.5, 0, nh, 0, pg.height);
        PVector pos = new PVector(x, y);
        noisyRects.add(new NoisyRect(pos));
      }
    }
  }

  void draw() 
  {
    pg.beginDraw();
    pg.fill(0, fade);
    pg.rect(0, 0, pg.width, pg.height); 
    for (NoisyRect nr : noisyRects) {
      nr.draw();
    }
    pg.endDraw();
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
      rectWidth = (int) (rectSizeMult * pg.width / nw);
      rectHeight = (int) (rectSizeMult * pg.height / nh);
      nf = map(env[0], 0, 1, 0, 0.3);
      noisePosition.add(new PVector(nf, nf));
      float x = map(noise(noisePosition.x), 0, 1, -offset, offset);
      float y = map(noise(noisePosition.y), 0, 1, -offset, offset);
      offPosition.set(x, y);
      pg.pushMatrix();
      pg.pushStyle();
      pg.rectMode(CENTER);
      pg.translate(position.x, position.y);
      pg.translate(offPosition.x, offPosition.y);
      pg.stroke(255, alphS);
      pg.strokeWeight(strokeWt);
      pg.fill(255, alphF);
      pg.rect(0, 0, rectWidth, rectHeight);
      pg.popStyle();
      pg.popMatrix();
    }
  }

  PGraphics get() {
    return pg;
  }

  PImage getImage() {
    return pg.get();
  }
}


//==============================================================================================================
//==============================================================================================================
//====  GFX SINEWAVES
//==============================================================================================================
//==============================================================================================================

class GfxSine implements Gfx {
  PGraphics pg;
  PShader sine;

  float r1 = 50.0;
  float r2 = 3.0;
  float t1 = 8.0;
  float t2 = 3.0;
  float bright = 0.9;
  float mode1 = 1.0;
  float mode2 = 1.0;
  float mode3 = 1.0;

  GfxSine() {
    setup();
  }

  void setup() {
    pg = createGraphics(gfxResolution, gfxResolution, P2D);
    sine = loadShader("sines.glsl");
    sine.set("resolution", float(pg.width), float(pg.height));
  }

  void setParameters(float p1, float p2, float p3, float p4, float p5, float p6, float p7, float p8) {
    r1 = p1;
    r2 = p2;
    t1 = p3;
    t2 = p4;
    bright = p5;
    mode1 = p6;
    mode2 = p7;
    mode3 = p8;
  }

  void draw() {
    sine.set("time", millis() / 1000.0);
    sine.set("r1", r1);
    sine.set("r2", r2);
    sine.set("t1", t1);
    sine.set("t2", t2);
    sine.set("bright", bright);
    sine.set("mode1", mode1);
    sine.set("mode2", mode2);
    sine.set("mode3", mode3);

    pg.beginDraw();
    pg.shader(sine);
    pg.rect(0, 0, pg.width, pg.height);
    pg.endDraw();
  }

  PGraphics get() {
    return pg;
  }

  PImage getImage() {
    return pg.get();
  }
}



