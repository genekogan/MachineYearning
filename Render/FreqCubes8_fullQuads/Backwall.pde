Keystone ks2;
CornerPinSurface swall1, swall2;
PGraphics wall1, wall2;

int w1xTL, w1xTR, w1xBR, w1xBL, w1yTL, w1yTR, w1yBR, w1yBL;
int w2xTL, w2xTR, w2xBR, w2xBL, w2yTL, w2yTR, w2yBR, w2yBL;


void setupBackwall() {
  ks2 = new Keystone(this);
  swall1 = ks2.createCornerPinSurface(500, 800, 20);
  swall2 = ks2.createCornerPinSurface(1024, 800, 20);
  
  wall1 = createGraphics(500, 800, P3D);
  wall2 = createGraphics(1024, 800, P3D);
  
  wall1.beginDraw();
  wall1.background(0);
  for (int i=0; i<100; i++) {
    float alph = map(noise(0.01*frameCount), 0, 1, 50, 150);
    float x = map(noise(0.01*frameCount,i*5), 0, 1, 0, wall1.width);
    float w = map(noise(0.01*frameCount+10,i*5+20), 0, 1, 1, 30);
    wall1.fill(255, alph);
    wall1.rect(x, 0, w, wall1.height);
  }
  wall1.endDraw();
  
  wall2.beginDraw();
  wall2.background(0);
  for (int i=0; i<100; i++) {
    float alph = map(noise(0.01*frameCount), 0, 1, 50, 150);
    float x = map(noise(0.01*frameCount,i*5), 0, 1, 0, wall2.width);
    float w = map(noise(0.01*frameCount+10,i*5+20), 0, 1, 1, 30);
    wall2.fill(255, alph);
    wall2.rect(x, 0, w, wall2.height);
  }
  wall2.endDraw();
  
  w1xTL = 0;
  w1yTL = 0;
  w1xTR = wall1.width;
  w1yTR = 0;
  w1xBR = wall1.width;
  w1yBR = wall1.height;
  w1xBL = 0;
  w1yBL = wall1.height;
  
  w2xTL = 0;
  w2yTL = 0;
  w2xTR = wall2.width;
  w2yTR = 0;
  w2xBR = wall2.width;
  w2yBR = wall2.height;
  w2xBL = 0;
  w2yBL = wall2.height;
  
  /*
  PVector TL1 = new PVector();
  PVector TR1 = new PVector();
  PVector BR1 = new PVector();
  PVector BL1 = new PVector();
  PVector TL2 = new PVector();
  PVector TR2 = new PVector();
  PVector BR2 = new PVector();
  PVector BL2 = new PVector();
  
  moveBackwall1((int) TL1.x, (int) TL1.y, (int) TR1.x, (int) TR1.y, (int) BR1.x, (int) BR1.y, (int) BL1.x, (int) BL1.y);
  moveBackwall2((int) TL2.x, (int) TL2.y, (int) TR2.x, (int) TR2.y, (int) BR2.x, (int) BR2.y, (int) BL2.x, (int) BL2.y);
*/

}

void drawBackwall() {
  swall1.render(wall1);
  swall2.render(wall2);
}


void moveBackwall1(int w1xTL1, int w1yTL1, int w1xTR1, int w1yTR1, int w1xBR1, int w1yBR1, int w1xBL1, int w1yBL1) {
  println("hello");
  println("1");
  swall1.moveMeshPointBy(CornerPinSurface.TL, 5, 5); //w1xTL1-w1xTL, w1yTL1-w1yTL);
  println("2");
  swall1.moveMeshPointBy(CornerPinSurface.TR, w1xTR1-w1xTR, w1yTR1-w1yTR);
  println("3");
  swall1.moveMeshPointBy(CornerPinSurface.BR, w1xBR1-w1xBR, w1yBR1-w1yBR);
  println("4");
  swall1.moveMeshPointBy(CornerPinSurface.BL, w1xBL1-w1xBL, w1yBL1-w1yBL);
  println("5");
  w1xTL = w1xTL1;
  w1xTR = w1xTR1;
  w1xBR = w1xBR1;
  w1xBL = w1xBL1;
  w1yTL = w1yTL1;
  w1yTR = w1yTR1;
  w1yBR = w1yBR1;
  w1yBL = w1yBL1;  
  println("goodbye");
}


void moveBackwall2(int w2xTL1, int w2yTL1, int w2xTR1, int w2yTR1, int w2xBR1, int w2yBR1, int w2xBL1, int w2yBL1) {
  swall2.moveMeshPointBy(CornerPinSurface.TL, w2xTL1-w2xTL, w2yTL1-w2yTL);
  swall2.moveMeshPointBy(CornerPinSurface.TR, w2xTR1-w2xTR, w2yTR1-w2yTR);
  swall2.moveMeshPointBy(CornerPinSurface.BR, w2xBR1-w2xBR, w2yBR1-w2yBR);
  swall2.moveMeshPointBy(CornerPinSurface.BL, w2xBL1-w2xBL, w2yBL1-w2yBL);
  w2xTL = w2xTL1;
  w2xTR = w2xTR1;
  w2xBR = w2xBR1;
  w2xBL = w2xBL1;
  w2yTL = w2yTL1;
  w2yTR = w2yTR1;
  w2yBR = w2yBR1;
  w2yBL = w2yBL1;  
}
