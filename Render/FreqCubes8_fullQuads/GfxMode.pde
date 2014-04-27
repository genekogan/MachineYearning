int gfxResolution = 250;

int gfxMode = 3;

ArrayList<Gfx> gfx;

GfxBits bits;
GfxFull full;
GfxOutlines outlines;
GfxNoisyRects rects;

void setupGfx() {
  gfx = new ArrayList<Gfx>();
  if (gfxMode == 0) {
    gfx.add(new GfxBits());
    gfx.add(new GfxFull());
    gfx.add(new GfxOutlines());
    gfx.add(new GfxNoisyRects());
  } 
  else if (gfxMode == 1) {
    gfx.add(new GfxBits());
    gfx.add(new GfxBits());
    gfx.add(new GfxBits());
    gfx.add(new GfxBits());
    gfx.add(new GfxBits());
  }
  else if (gfxMode == 2) {
    gfx.add(new GfxFull());
    gfx.add(new GfxFull());
    gfx.add(new GfxFull());
    gfx.add(new GfxFull());
    gfx.add(new GfxFull());
    gfx.add(new GfxFull());
    gfx.add(new GfxFull());
  }
  else if (gfxMode == 3) {
    gfx.add(new GfxOutlines());
    gfx.add(new GfxOutlines());
    gfx.add(new GfxOutlines());
    gfx.add(new GfxOutlines());
    gfx.add(new GfxOutlines());
    gfx.add(new GfxOutlines());
    gfx.add(new GfxOutlines());
  }
}

void updateGfx() {
  for (Gfx g : gfx) {
    g.draw();
  }
  
  if (gfxMode == 3) {
    for (int i=0; i<gfx.size(); i++) {
      try {
      GfxOutlines g = (GfxOutlines) gfx.get(i);
      g.outlinesPhase += 0.1;
      g.outlinesMult = 6.0;
      } catch(Exception e) {}
    }
  }
}


