int gfxResolution = 250;

PGraphics gfxBits;
PShader shadeBits;

float bitsMx, bitsMy, bitsFade;

void setupBits() {
  gfxBits = createGraphics(gfxResolution, gfxResolution, P2D);
  shadeBits = loadShader("bits.glsl");
  shadeBits.set("resolution", float(gfxBits.width), float(gfxBits.height));
  gfxBits.shader(shadeBits); 
  gfxBits.beginDraw();
  gfxBits.background(255);
  gfxBits.endDraw();
}


void drawBits() {
  
  shadeBits = loadShader("bits.glsl");
  shadeBits.set("resolution", float(gfxBits.width), float(gfxBits.height));
  gfxBits.shader(shadeBits);
  
  shadeBits.set("time", millis()/1000.0);  
  shadeBits.set("mx", bitsMx);
  shadeBits.set("my", bitsMy);
  shadeBits.set("fade", bitsFade);
  
  gfxBits.beginDraw();
  gfxBits.background(255);
  gfxBits.rect(0, 0, gfxBits.width, gfxBits.height);
  gfxBits.endDraw();
}


