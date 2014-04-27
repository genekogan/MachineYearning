class Surface 
{  
  CornerPinSurface surface;
  PGraphics offscreen;
  PGraphics surfaceGfx;
  color debugColor;
  PVector TL, TR, BR, BL;
  PVector pTL, pTR, pBR, pBL;
  int xTL, xTR, xBR, xBL, yTL, yTR, yBR, yBL;
  
  Surface() {//PGraphics surfaceGfx) {
    //this.surfaceGfx = surfaceGfx;
    surfaceGfx = createGraphics(400, 300, P2D);
    surfaceGfx.beginDraw();
    surfaceGfx.background(random(255), random(255), random(25));
    surfaceGfx.endDraw();
    
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
  }
  
  void setRobotCoordinates(PVector TL0, PVector TR0, PVector BR0, PVector BL0, boolean invert) {
    TL = TL0;
    TR = TR0;
    BR = BR0;
    BL = BL0;
    if (invert) {
      TL.y *= -1;
      TR.y *= -1;
      BR.y *= -1;
      BL.y *= -1;
    }
  }
  
  void mapToRobot() {
    pTL = convertRobotToProjector(TL);
    pTR = convertRobotToProjector(TR);
    pBR = convertRobotToProjector(BR);
    pBL = convertRobotToProjector(BL);
    moveMeshTo((int) pTL.x, (int) pTL.y, (int) pTR.x, (int) pTR.y, (int) pBR.x, (int) pBR.y, (int) pBL.x, (int) pBL.y);
  }
  
  void draw() {
    if (debug) {
      offscreen.beginDraw();
      offscreen.resetShader();
      offscreen.fill(red(debugColor)+random(-20, 20), green(debugColor)+random(-20, 20), blue(debugColor)+random(-20, 20), random(80, 180));
      offscreen.rect(random(offscreen.width),random(offscreen.height),random(100, 200), random(100, 200)); 
      offscreen.endDraw();
    } else {
      offscreen.beginDraw();
      //offscreen.shader(shade);
      //offscreen.image(surfaceGfx, 0, 0, width, height);
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
