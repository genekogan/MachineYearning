int NUM_QUADS = 9;

Keystone ks;
ArrayList<Surface> surfaces;

void setupSurfaces() 
{
  loadCalibration("/Users/Gene/Desktop/robotCalib.txt");
  ks = new Keystone(this);
  surfaces = new ArrayList<Surface>();

  for (int i=0; i<NUM_QUADS; i++) {
    Surface surface = new Surface(gfx);
    surfaces.add(surface);
  }  
}

void updateSurfaces() {
  if (!isRobot) {
    nextFake();
  }
  for (int i=0; i<NUM_QUADS; i++) {
    Surface surface = surfaces.get(i);
    surface.mapToRobot();      
  } 
}
