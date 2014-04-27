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
  float bitsMx, bitsMy;
  
  GfxBits() {
    bitsMx = 1.0;
    bitsMy = 1.0;
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
  
  void draw() 
  { 
    
  
  
    shadeBits.set("time", millis()/1000.0);  
    shadeBits.set("mx", bitsMx);
    shadeBits.set("my", bitsMy);
    
    
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
  float fullR, fullG, fullB; 
  
  GfxFull() {
    fullR = random(100,255);
    fullG = random(100,255);
    fullB = random(100,255);
    setup();
  }
  
  void setup() {
    pg = createGraphics(gfxResolution, gfxResolution, P2D);
  }
  
  void draw() {  
    pg.beginDraw();
    pg.background(fullR, fullG, fullB);
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
//====  GFX OUTLINES
//==============================================================================================================
//==============================================================================================================

class GfxOutlines implements Gfx {
  PGraphics pg;
  PShader outliner;
  float outlinesMult, outlinesPhase, outlinesRad, outlinesGive, outlinesR, outlinesG, outlinesB, threshLen, threshSpeed;
  
  GfxOutlines() {
    outlinesMult = 1.0;
    outlinesPhase = 0.0;
    outlinesRad = 0.93;
    outlinesGive = 0.06;
    outlinesR = random(0.6,1);
    outlinesG = random(0.6,1);
    outlinesB = random(0.6,1);
    threshLen = 0.57;
    threshSpeed = 4.5;
    setup();
  }
  
  void setup() {
    pg = createGraphics(gfxResolution, gfxResolution, P2D);
    outliner = loadShader("outlines.glsl");
    outliner.set("resolution", float(pg.width), float(pg.height));
  }
  
  void draw() {
    outliner = loadShader("outlines.glsl");
    outliner.set("resolution", float(pg.width), float(pg.height));
    outliner.set("time", millis() / 1000.0);
    outliner.set("mult", outlinesMult);
    outliner.set("phase", outlinesPhase);
    outliner.set("rad", outlinesRad);
    outliner.set("give", outlinesGive);
    outliner.set("r", outlinesR);
    outliner.set("g", outlinesG);
    outliner.set("b", outlinesB);
    outliner.set("threshLen", threshLen);
    outliner.set("threshSpeed", threshSpeed);
    outliner.set("b", outlinesB);
    
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
    setup();
  }
  
  void setup() {
    gfxRects = createGraphics(gfxResolution, gfxResolution, P2D);
    pg = createGraphics(gfxResolution, gfxResolution, P2D);
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
  
  void draw() 
  {
    pg.beginDraw();
    pg.fill(0, fade);
    pg.rect(0, 0, pg.width, pg.height); 
    for (NoisyRect nr : noisyRects) {
      nr.draw();
    }
    pg.endDraw();
    
    //gfxRects.shader(shade);
    gfxRects.beginDraw();
    gfxRects.image(pg, 0, 0);
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
      rectWidth = (int) (rectSizeMult * pg.width / nw);
      rectHeight = (int) (rectSizeMult * gfxRects.height / nh);
      nf = map(env[0]*freq[0], 0, 400, 0, 0.3);
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
  
  
  GfxSine() {
    setup();
  }
  
  void setup() {
    pg = createGraphics(gfxResolution, gfxResolution, P2D);
    sine = loadShader("sines.glsl");
    sine.set("resolution", float(pg.width), float(pg.height));
  }
  
  void draw() {
    sine.set("mode1", map(mouseX, 0, width, 0, 1));
    sine.set("mode2", map(mouseY, 0, height, 0, 1));
    sine.set("mode3", 0.0);
    sine.set("time", millis() / 1000.0);
    sine.set("r1", r1);
    sine.set("r2", r2);
    sine.set("t1", t1);
    sine.set("t2", t2);
    sine.set("bright", bright);
    
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




