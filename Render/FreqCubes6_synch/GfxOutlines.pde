PGraphics gfxOutlines;
PShader outliner;
float outlinesMult, outlinesPhase, outlinesRad, outlinesGive, outlinesR, outlinesG, outlinesB;

void setupOutlines() {
  gfxOutlines = createGraphics(gfxResolution, gfxResolution, P2D);
  outliner = loadShader("outlines.glsl");
  outliner.set("resolution", float(gfxOutlines.width), float(gfxOutlines.height));
}

void drawOutlines() {
  outliner.set("mult", outlinesMult);
  outliner.set("phase", outlinesPhase);
  outliner.set("rad", outlinesRad);
  outliner.set("give", outlinesGive);
  outliner.set("r", outlinesR);
  outliner.set("g", outlinesG);
  outliner.set("b", outlinesB);
  
  gfxOutlines.beginDraw();
  gfxOutlines.shader(outliner);
  gfxOutlines.rect(0, 0, gfxOutlines.width, gfxOutlines.height);
  gfxOutlines.endDraw();
}


