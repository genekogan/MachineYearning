PGraphics gfxOutlines;

void setupOutlines() {
  gfxOutlines = createGraphics(gfxResolution, gfxResolution, P2D);
}

void drawOutlines() {
  int n = 10;  
  float maxAlph = map(mouseX, 0, width, 250, 20);
  gfxOutlines.beginDraw();
  gfxOutlines.background(0);
  gfxOutlines.rectMode(CENTER);
  for (int i=0; i<n; i++) {
    float sw = map(abs(i-(float)n/2), (float)n/2, 0, 0, 6);
    float alph = map(abs(i-(float)n/2), 0, (float)n/2, maxAlph, 4); 
    float rectWidth = map(i, 0, n, gfxOutlines.width-50, gfxOutlines.width-10);
    float rectHeight = map(i, 0, n, gfxOutlines.height-50, gfxOutlines.height-10); 
    gfxOutlines.stroke(255, alph);
    gfxOutlines.noFill();
    gfxOutlines.strokeWeight(sw);
    //gfxOutlines.rect(6, 6, gfxOutlines.width-12, gfxOutlines.height-12);
    gfxOutlines.rect(gfxOutlines.width/2, gfxOutlines.height/2, rectWidth, rectHeight);
  }
  gfxOutlines.endDraw();
}


