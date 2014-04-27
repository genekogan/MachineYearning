int gfxResolution = 250;

final int MODE_BITS_STANDARD = 0;
final int MODE_OUTLINES_STANDARD = 1;
final int MODE_OUTLINES_CIRCLING = 2;
final int MODE_OUTLINES_PULSATING = 3;
final int MODE_FULL_PHASES = 4;

final int MODE_SINES_STANDARD1 = 5;
final int MODE_SINES_STANDARD2 = 6;
final int MODE_SINES_STANDARD3 = 7;
final int MODE_SINES_STANDARD4 = 8;
final int MODE_RECTS_STANDARD = 9;

int gfxMode = MODE_SINES_STANDARD4;

ArrayList<Gfx> gfx;

String[] modes = new String[] {
  "MODE_BITS_STANDARD", "MODE_OUTLINES_STANDARD", "MODE_OUTLINES_CIRCLING", "MODE_OUTLINES_PULSATING", 
  "MODE_FULL_PHASES", "MODE_SINES_STANDARD1", "MODE_SINES_STANDARD2", "MODE_SINES_STANDARD3", "MODE_SINES_STANDARD4",
  "MODE_RECTS_STANDARD" };


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

    for (int i=0; i<11; i++) {
      gfx.add(new GfxFull());
    }
  }
  else if (gfxMode == MODE_SINES_STANDARD1
        || gfxMode == MODE_SINES_STANDARD2
        || gfxMode == MODE_SINES_STANDARD3
        || gfxMode == MODE_SINES_STANDARD4) {
    gfx.add(new GfxSine());
    gfx.add(new GfxSine());
    gfx.add(new GfxSine());
    gfx.add(new GfxSine());
  }
  
  else if (gfxMode == MODE_RECTS_STANDARD) {
    gfx.add(new GfxNoisyRects());
    gfx.add(new GfxNoisyRects());
    gfx.add(new GfxNoisyRects());
    gfx.add(new GfxNoisyRects());
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
  if (gfxMode == MODE_BITS_STANDARD) {
    GfxBits g1 = (GfxBits) gfx.get(0);
    GfxBits g2 = (GfxBits) gfx.get(1);
    GfxBits g3 = (GfxBits) gfx.get(2);
    GfxBits g4 = (GfxBits) gfx.get(3);
    
    g1.setParameters(0.03, map(env[0], 0, rmaxEnv, 0.1, 0.01), map(env[0], 0, rmaxEnv, 0, 0.1));
    g2.setParameters(0.03, map(env[1], 0, rmaxEnv, 0.1, 0.01), map(env[1], 0, rmaxEnv, 0, 0.1));
    g3.setParameters(0.03, map(env[2], 0, rmaxEnv, 0.1, 0.01), map(env[2], 0, rmaxEnv, 0, 0.1));
    g4.setParameters(0.03, map(env[3], 0, rmaxEnv, 0.1, 0.01), map(env[3], 0, rmaxEnv, 0, 0.1));
    
  } 
  
  else if (gfxMode == MODE_OUTLINES_STANDARD) {
    GfxOutlines g1 = (GfxOutlines) gfx.get(0);
    GfxOutlines g2 = (GfxOutlines) gfx.get(1);
    GfxOutlines g3 = (GfxOutlines) gfx.get(2);
    GfxOutlines g4 = (GfxOutlines) gfx.get(3);
    
    g1.setParameters(1.0, 0, map(sin(0.01*frameCount+65), -1, 1, 0.7, 0.85), map(sin(0.13*frameCount+5), -1, 1, 0.05, 0.13),  map(sin(0.12*frameCount+25), -1, 1, 1.2, 1.5), 2.6);
    g2.setParameters(1.0, 0, map(sin(0.01*frameCount+75), -1, 1, 0.7, 0.85), map(sin(0.12*frameCount+15), -1, 1, 0.05, 0.14), map(sin(0.1*frameCount+35), -1, 1, 1.1, 1.4), 2.8);
    g3.setParameters(1.0, 0, map(sin(0.01*frameCount+85), -1, 1, 0.7, 0.85), map(sin(0.14*frameCount+25), -1, 1, 0.05, 0.13), map(sin(0.13*frameCount+45), -1, 1, 1.0, 1.5), 2.3);
    g4.setParameters(1.0, 0, map(sin(0.01*frameCount+95), -1, 1, 0.7, 0.85), map(sin(0.135*frameCount+35), -1, 1, 0.05, 0.13), map(sin(0.09*frameCount+55), -1, 1, 1.2, 1.5), 2.5);
    
  }
  
  else if (gfxMode == MODE_OUTLINES_CIRCLING) { 
    GfxOutlines g1 = (GfxOutlines) gfx.get(0);
    GfxOutlines g2 = (GfxOutlines) gfx.get(1);
    GfxOutlines g3 = (GfxOutlines) gfx.get(2);
    GfxOutlines g4 = (GfxOutlines) gfx.get(3);
    
    g1.setParameters(8.0, map(env[0], 0, rmaxEnv, 0.01, 0.15)*frameCount+5, 0.92, map(sin(0.13*frameCount+5), -1, 1, 0.08, 0.23),  1.6, 0.0);
    g2.setParameters(8.0, map(env[1], 0, rmaxEnv, 0.01, 0.15)*frameCount+15, 0.92, map(sin(0.12*frameCount+15), -1, 1, 0.08, 0.24),  1.6, 0.0);
    g3.setParameters(8.0, map(env[2], 0, rmaxEnv, 0.01, 0.15)*frameCount+25, 0.93, map(sin(0.14*frameCount+25), -1, 1, 0.08, 0.33),  1.6, 0.0);
    g4.setParameters(8.0, map(env[3], 0, rmaxEnv, 0.01, 0.15)*frameCount+35, 0.94, map(sin(0.135*frameCount+35), -1, 1, 0.08, 0.33),  1.6, 0.0);
  }
  
  else if (gfxMode == MODE_OUTLINES_PULSATING) { 
  }
  
  else if (gfxMode == MODE_FULL_PHASES) {
    GfxFull g1 = (GfxFull) gfx.get(0);
    GfxFull g2 = (GfxFull) gfx.get(1);
    GfxFull g3 = (GfxFull) gfx.get(2);
    GfxFull g4 = (GfxFull) gfx.get(3);
    GfxFull g5 = (GfxFull) gfx.get(4);
    GfxFull g6 = (GfxFull) gfx.get(5);
    GfxFull g7 = (GfxFull) gfx.get(6);
    GfxFull g8 = (GfxFull) gfx.get(7);
    GfxFull g9 = (GfxFull) gfx.get(8);
    GfxFull g10 = (GfxFull) gfx.get(9);
    
    g1.setParameters(25, 240, map(sin(0.1*frameCount+5), -1, 1, 0, 255));
    g2.setParameters(100, 240, map(sin(0.1*frameCount+10), -1, 1, 0, 255));
    g3.setParameters(200, 240, map(sin(0.1*frameCount+15), -1, 1, 0, 255));
    g4.setParameters(65, 240, map(sin(0.1*frameCount+20), -1, 1, 0, 255));
    g5.setParameters(175, 240, map(sin(0.1*frameCount+25), -1, 1, 0, 255));
    g6.setParameters(240, 240, map(sin(0.1*frameCount+30), -1, 1, 0, 255));
    g7.setParameters(125, 240, map(sin(0.1*frameCount+35), -1, 1, 0, 255));
    g8.setParameters(50, 240, map(sin(0.1*frameCount+40), -1, 1, 0, 255));
    g9.setParameters(150, 240, map(sin(0.1*frameCount+45), -1, 1, 0, 255));
    g10.setParameters(75, 240, map(sin(0.1*frameCount+50), -1, 1, 0, 255));
    
  }
  
  
  else if (gfxMode == MODE_SINES_STANDARD1) {    
    GfxSine g1 = (GfxSine) gfx.get(0);
    GfxSine g2 = (GfxSine) gfx.get(1);
    GfxSine g3 = (GfxSine) gfx.get(2);
    GfxSine g4 = (GfxSine) gfx.get(3);    
    g1.setParameters(10.0, 3.0, 8.0, 3.0, 0.9, 0.0, 0.0, 1);
    g2.setParameters(20.0, 43.0, 8.0, 3.0, 0.9, 0.0, 0.0, 1);
    g3.setParameters(30.0, 33.0, 8.0, 3.0, 0.9, 0.0, 0.0, 1);
    g4.setParameters(15.0, 13.0, 8.0, 3.0, 0.9, 0.0, 0.0, 1);
  }
  else if (gfxMode == MODE_SINES_STANDARD2) {    
    GfxSine g1 = (GfxSine) gfx.get(0);
    GfxSine g2 = (GfxSine) gfx.get(1);
    GfxSine g3 = (GfxSine) gfx.get(2);
    GfxSine g4 = (GfxSine) gfx.get(3);    
    g1.setParameters(8.0, 32.0, 8.0, 3.0, 3.9, 1.0, 0.0, 1);
    g2.setParameters(8.0, 32.0, 8.0, 3.0, 3.9, 1.0, 0.0, 1);
    g3.setParameters(8.0, 32.0, 8.0, 3.0, 3.9, 1.0, 0.0, 1);
    g4.setParameters(8.0, 32.0, 8.0, 3.0, 3.9, 1.0, 0.0, 1);
  }
  else if (gfxMode == MODE_SINES_STANDARD3) {    
    GfxSine g1 = (GfxSine) gfx.get(0);
    GfxSine g2 = (GfxSine) gfx.get(1);
    GfxSine g3 = (GfxSine) gfx.get(2);
    GfxSine g4 = (GfxSine) gfx.get(3);    
    g1.setParameters(10.0, 3.0, 8.0, 3.0, 0.9, 0.0, 1.0, 1);
    g2.setParameters(10.0, 3.0, 8.0, 3.0, 0.9, 0.0, 1.0, 1);
    g3.setParameters(10.0, 3.0, 8.0, 3.0, 0.9, 0.0, 1.0, 1);
    g4.setParameters(10.0, 3.0, 8.0, 3.0, 0.9, 0.0, 1.0, 1);
  }
  else if (gfxMode == MODE_SINES_STANDARD4) {    
    GfxSine g1 = (GfxSine) gfx.get(0);
    GfxSine g2 = (GfxSine) gfx.get(1);
    GfxSine g3 = (GfxSine) gfx.get(2);
    GfxSine g4 = (GfxSine) gfx.get(3);    
    g1.setParameters(env[0]*200.0, 3.0, 8.0, 3.0, 0.9, 1.0, 1.0, 1);
    g2.setParameters(env[1]*200.0, 3.0, 8.0, 3.0, 0.9, 1.0, 1.0, 1);
    g3.setParameters(env[2]*200.0, 3.0, 8.0, 3.0, 0.9, 1.0, 1.0, 1);
    g4.setParameters(env[3]*200.0, 3.0, 8.0, 3.0, 0.9, 1.0, 1.0, 1);
  }
  
  else if (gfxMode == MODE_RECTS_STANDARD) {    
    GfxNoisyRects g1 = (GfxNoisyRects) gfx.get(0);
    GfxNoisyRects g2 = (GfxNoisyRects) gfx.get(1);
    GfxNoisyRects g3 = (GfxNoisyRects) gfx.get(2);
    GfxNoisyRects g4 = (GfxNoisyRects) gfx.get(3);
    g1.setParameters(30, 3, 60, 190, 120, 1.5, env[0]*1000.0);
    g2.setParameters(60, 3, 120, 90, 100, 1.5, env[1]*1000.0);
    g3.setParameters(40, 3, 80, 190, 100, 1.5, env[2]*1000.0);
    g4.setParameters(70, 3, 135, 150, 105, 1.5, env[3]*1000.0);
  }  
}

