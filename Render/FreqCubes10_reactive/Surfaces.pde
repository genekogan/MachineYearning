int NUM_QUADS = 24;

Keystone ks;
ArrayList<Surface> surfaces;
int idxSurfaceProject;

Integer[] sortedIndexes;

void setupSurfaces() 
{
  loadCalibration(CALIBRATION_FILE);
  ks = new Keystone(this);
  surfaces = new ArrayList<Surface>();

  for (int i=0; i<NUM_QUADS; i++) {
    surfaces.add(new Surface(gfx.get(i % gfx.size()).get()));
  }
  resetSurfaces();
  
  sortedIndexes = new Integer[NUM_QUADS];
  for (int i=0; i<NUM_QUADS; i++) {
    sortedIndexes[i] = i;
  }
}

void resetSurfaces() {
  if (gfxMode == MODE_FULL_PHASES) {
    for (int i=0; i<NUM_QUADS; i++) {
      surfaces.get(i).setGraphics(gfx.get(i % gfx.size()).get());
    }
  }
  else { 
    for (int i=1; i<6; i++) {
      surfaces.get(i).setGraphics(gfx.get(0).get());
    }
    for (int i=6; i<11; i++) {
      surfaces.get(i).setGraphics(gfx.get(1).get());
    }
    for (int i=11; i<15; i++) {
      surfaces.get(i).setGraphics(gfx.get(2).get());
    }
    for (int i=15; i<23; i++) {
      surfaces.get(i).setGraphics(gfx.get(3).get());
    }
    surfaces.get(23).setGraphics(gfx.get(0).get());
  }

}

void updateSurfaces() {
  for (int i=0; i<NUM_QUADS; i++) {
    Surface surface = surfaces.get(i);
    surface.mapToRobot();      
  } 

  // sort surfaces by distance from projector
  DistanceComparator comparator = new DistanceComparator(surfaces);
  sortedIndexes = comparator.createIndexArray();
  Arrays.sort(sortedIndexes, comparator);
}

