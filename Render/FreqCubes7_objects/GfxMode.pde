int gfxResolution = 250;

int gfxMode = 1;

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
}

void updateGfx() {
  for (Gfx g : gfx) {
    g.draw();
  }
}


