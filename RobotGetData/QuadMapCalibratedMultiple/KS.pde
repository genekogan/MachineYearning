class KS {
  CornerPinSurface surface;
  PGraphics offscreen;
  
  PVector TL, TR, BR, BL;
  PVector pTL, pTR, pBR, pBL;
  int xTL, xTR, xBR, xBL, yTL, yTR, yBR, yBL;
  
  KS() {
    
    surface = ks.createCornerPinSurface(400, 300, 20);
    
    offscreen = createGraphics(400, 300, P2D);
    
    offscreen.beginDraw();
    offscreen.background(255);
    offscreen.endDraw();
  
    TL = new PVector();
    TR = new PVector();
    BR = new PVector();
    BL = new PVector();
    pTL = new PVector();
    pTR = new PVector();
    pBR = new PVector();
    pBL = new PVector();
    
    
    xTL = 0;
    yTL = 0;
    xTR = 400;
    yTR = 0;
    xBR = 400;
    yBR = 300;
    xBL = 0;
    yBL = 300;
  
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
  
  void drawQuad() {
  
    // Draw the scene, offscreen
    offscreen.beginDraw();
    offscreen.fill(random(255), random(255), random(255));
    offscreen.ellipse(random(offscreen.width), random(offscreen.height), random(50, 100), random(50, 100));
    offscreen.endDraw();
    
    surface.render(offscreen);
  }
  
  void moveMeshTo(int xTL1, int yTL1, int xTR1, int yTR1, int xBR1, int yBR1, int xBL1, int yBL1) {
    //println(xTL1+" "+yTL1+" "+xTR1+" "+yTR1+" "+xBR1+" "+yBR1+" "+xBL1+" "+yBL1);
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


/*
CornerPinSurface surface;
PGraphics offscreen;

int xTL, xTR, xBR, xBL, yTL, yTR, yBR, yBL;

void setupKeystone() {
  ks = new Keystone(this);
  surface = ks.createCornerPinSurface(400, 300, 20);
  
  offscreen = createGraphics(400, 300, P2D);
  
  offscreen.beginDraw();
  offscreen.background(255);
  offscreen.endDraw();

  
  xTL = 0;
  yTL = 0;
  xTR = 400;
  yTR = 0;
  xBR = 400;
  yBR = 300;
  xBL = 0;
  yBL = 300;

}

void setSurface(PVector TL0, PVector TR0, PVector BR0, PVector BL0) {
  TL = TL0;
  TR = TR0;
  BR = BR0;
  BL = BL0;
  
  TL.y *= -1;
  TR.y *= -1;
  BR.y *= -1;
  BL.y *= -1;
}

void drawQuad() {

  // Draw the scene, offscreen
  offscreen.beginDraw();
  offscreen.fill(random(255), random(255), random(255));
  offscreen.ellipse(random(offscreen.width), random(offscreen.height), random(50, 100), random(50, 100));
  offscreen.endDraw();
  
  surface.render(offscreen);
}

void moveMeshTo(int xTL1, int yTL1, int xTR1, int yTR1, int xBR1, int yBR1, int xBL1, int yBL1) {
  //println(xTL1+" "+yTL1+" "+xTR1+" "+yTR1+" "+xBR1+" "+yBR1+" "+xBL1+" "+yBL1);
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
*/
