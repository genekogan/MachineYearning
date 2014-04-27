int NUM_QUADS = 9;

Keystone ks;
ArrayList<Surface> surfaces;
int idxSurfaceProject;

void setupSurfaces() 
{
  loadCalibration(CALIBRATION_FILE);
  ks = new Keystone(this);
  surfaces = new ArrayList<Surface>();

  for (int i=0; i<NUM_QUADS; i++) {
    surfaces.add(new Surface(gfx.get(i % gfx.size()).get()));
  }  
}


void updateSurfaces() {
  for (int i=0; i<NUM_QUADS; i++) {
    Surface surface = surfaces.get(i);
    surface.mapToRobot();      
  } 
}
