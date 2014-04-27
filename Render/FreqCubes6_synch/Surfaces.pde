int NUM_QUADS = 9;

Keystone ks;
ArrayList<Surface> surfaces;
int idxSurfaceProject;

void setupSurfaces() 
{
  loadCalibration("/Users/Gene/Desktop/robotCalib.txt");
  ks = new Keystone(this);
  surfaces = new ArrayList<Surface>();

  for (int i=0; i<NUM_QUADS; i++) {
    if (random(1) < 0.5) {
      surfaces.add(new Surface(gfxRects));
    }
    else {
      surfaces.add(new Surface(gfxBits));
    }      
  }  
}


void updateSurfaces() {
  for (int i=0; i<NUM_QUADS; i++) {
    Surface surface = surfaces.get(i);
    surface.mapToRobot();      
  } 
}
