int gfxResolution = 250;

final int MODE_BITS_STANDARD = 0;
final int MODE_OUTLINES_STANDARD = 1;
final int MODE_OUTLINES_CIRCLING = 2;
final int MODE_OUTLINES_PULSATING = 3;
final int MODE_FULL_PHASES = 4;
final int MODE_SINES_STANDARD = 5;

int gfxMode = 0;
ArrayList<Gfx> gfx;

/* MODES
1a Bits Standard
2a Outlines Standard
2b Outlines Circling
2c Outlines Pulsating
3a Full Saturated Phases
4a Sinewaves Standard

*/




void setupGfx() 
{
  gfx = new ArrayList<Gfx>();

  if (gfxMode == MODE_BITS_STANDARD) {
    gfx.add(new GfxBits());
    gfx.add(new GfxBits());
    gfx.add(new GfxBits());
    gfx.add(new GfxBits());
  } 
  else if (gfxMode == MODE_OUTLINES_STANDARD 
        || gfxMode == MODE_OUTLINES_CIRCLING
        || gfxMode ==MODE_OUTLINES_PULSATING) {
    gfx.add(new GfxOutlines());
    gfx.add(new GfxOutlines());
    gfx.add(new GfxOutlines());
    gfx.add(new GfxOutlines());
  }
  else if (gfxMode == MODE_FULL_PHASES) {
    gfx.add(new GfxFull());
    gfx.add(new GfxFull());
    gfx.add(new GfxFull());
    gfx.add(new GfxFull());
  }
  else if (gfxMode == MODE_SINES_STANDARD) {
    gfx.add(new GfxSine());
    gfx.add(new GfxSine());
    gfx.add(new GfxSine());
    gfx.add(new GfxSine());
  }
}

void updateGfx() {
  try {
    doUpdate();
  } 
  catch(Exception e) {}
    for (Gfx g : gfx) {
    g.draw();
  }
}

void doUpdate() 
{
  if      (gfxMode == MODE_BITS_STANDARD) {
  } 
  
  else if (gfxMode == MODE_OUTLINES_STANDARD) {
  }
  
  else if (gfxMode == MODE_OUTLINES_CIRCLING) { 
  }
  
  else if (gfxMode == MODE_OUTLINES_PULSATING) { 
  }
  
  else if (gfxMode == MODE_FULL_PHASES) {
  }
  
  else if (gfxMode == MODE_SINES_STANDARD) {
  }
}

