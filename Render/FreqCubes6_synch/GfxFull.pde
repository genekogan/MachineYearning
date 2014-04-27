PGraphics gfxFull;
float fullR, fullG, fullB; 

void setupFull() {
  gfxFull = createGraphics(gfxResolution, gfxResolution, P2D);
}

void drawFull() {  
  gfxFull.beginDraw();
  gfxFull.background(fullR, fullG, fullB);
  gfxFull.endDraw();
}


