Keystone ks;
ArrayList<Surface> surfaces;
int NUM_QUADS = 9;

void setupSurfaces() 
{
  loadCalibration("/Users/Gene/Desktop/robotCalib.txt");
  ks = new Keystone(this);
  surfaces = new ArrayList<Surface>();

  for (int i=0; i<NUM_QUADS; i++) {
    //Surface surface = new Surface(gfx);
    Surface surface = new Surface();
    surfaces.add(surface);
  }  
}

void updateSurfaces() {
  for (int i=0; i<NUM_QUADS; i++) {
    Surface surface = surfaces.get(i);
    if (isRobot) {
      nextFake();
      surface.mapToRobot();
    } else {
      int sOffset = 80;
      surface.moveMeshTo(mouseX+sOffset*i, mouseY+sOffset*i, 
             mouseX+400+sOffset*i, mouseY+10+sOffset*i,
             mouseX+450+sOffset*i, mouseY+300+sOffset*i,
             mouseX+25+sOffset*i, mouseY+360+sOffset*i);
    }
  } 
}


