Keystone ks;
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

