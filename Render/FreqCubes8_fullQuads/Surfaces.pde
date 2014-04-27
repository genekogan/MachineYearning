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
  
  sortedIndexes = new Integer[NUM_QUADS];
  for (int i=0; i<NUM_QUADS; i++) {
    sortedIndexes[i] = i;
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

