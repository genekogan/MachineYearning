class Surface 
{  
  CornerPinSurface surface;
  PGraphics offscreen;
  PGraphics surfaceGfx;
  color debugColor;
  
  PVector TL, TR, BR, BL;
  PVector pTL, pTR, pBR, pBL;
  int xTL, xTR, xBR, xBL, yTL, yTR, yBR, yBL;
  
  Surface(PGraphics surfaceGfx) {
    this.surfaceGfx = surfaceGfx;
    surface = ks.createCornerPinSurface(surfaceGfx.width, surfaceGfx.height, 24);  
    offscreen = createGraphics(surfaceGfx.width, surfaceGfx.height, P2D);  
    debugColor = color(random(40, 215), random(40, 215), random(40, 215));
    
    xTL = 0;
    yTL = 0;
    xTR = surfaceGfx.width;
    yTR = 0;
    xBR = surfaceGfx.width;
    yBR = surfaceGfx.height;
    xBL = 0;
    yBL = surfaceGfx.height;
    
    // matching pairs
    TL = new PVector();
    TR = new PVector();
    BR = new PVector();
    BL = new PVector();
    pTL = new PVector();
    pTR = new PVector();
    pBR = new PVector();
    pBL = new PVector();
  }
  
  void setRobotCoordinates(PVector TL0, PVector TR0, PVector BR0, PVector BL0) {
    TL = TL0;
    TR = TR0;
    BR = BR0;
    BL = BL0;    
    TL.y *= -1;
    TR.y *= -1;
    BR.y *= -1;
    BL.y *= -1;
  }
  
  void mapToRobot() {
    pTL = convertRobotToProjector(TL);
    pTR = convertRobotToProjector(TR);
    pBR = convertRobotToProjector(BR);
    pBL = convertRobotToProjector(BL);
    moveMeshTo((int) map(pTL.x, 0, 1, 0, width), (int) map(pTL.y, 0, 1, 0, height), 
             (int) map(pTR.x, 0, 1, 0, width), (int) map(pTR.y, 0, 1, 0, height), 
             (int) map(pBR.x, 0, 1, 0, width), (int) map(pBR.y, 0, 1, 0, height),
             (int) map(pBL.x, 0, 1, 0, width), (int) map(pBL.y, 0, 1, 0, height));   
  }
  
  void draw() 
  {
    if (debugGfx) {
      offscreen.beginDraw();
      offscreen.resetShader();
      offscreen.fill(red(debugColor)+random(-20, 20), green(debugColor)+random(-20, 20), blue(debugColor)+random(-20, 20), random(80, 180));
      offscreen.rect(random(offscreen.width),random(offscreen.height),random(100, 200), random(100, 200)); 
      offscreen.endDraw();
    } else {
      offscreen.beginDraw();
      offscreen.shader(shade);
      offscreen.image(surfaceGfx, 0, 0, offscreen.width, offscreen.height);
      offscreen.endDraw();
    }
    surface.render(offscreen);
  }
  
  void moveMeshTo(int xTL1, int yTL1, int xTR1, int yTR1, int xBR1, int yBR1, int xBL1, int yBL1) {
    surface.moveMeshPointBy(CornerPinSurface.TL, xTL1-xTL, yTL1-yTL);
    surface.moveMeshPointBy(CornerPinSurface.TR, xTR1-xTR, yTR1-yTR);
    surface.moveMeshPointBy(CornerPinSurface.BR, xBR1-xBR, yBR1-yBR);
    surface.moveMeshPointBy(CornerPinSurface.BL, xBL1-xBL, yBL1-yBL);
    xTL = xTL1;
    xTR = xTR1;
    xBR = xBR1;
    xBL = xBL1;
    yTL = yTL1;
    yTR = yTR1;
    yBR = yBR1;
    yBL = yBL1;  
  }
  
}
