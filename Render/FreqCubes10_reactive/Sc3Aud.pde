// P5 receiving parameters
float rmaxEnv = 0.15;
float[] env;
float ampThresh;
PGraphics stats;
ArrayList<ArrayList<Float>> jointSpeeds;

void setupMachineStats() {
  stats = createGraphics(900, 210, P2D);
  
  jointSpeeds = new ArrayList<ArrayList<Float>>();
  env = new float[6];
  for (int i=0; i<6; i++) {
    jointSpeeds.add(new ArrayList<Float>());
  }
}


void updateMachineStats() 
{
  float[] newSpeed = new float[6];
  newSpeed[0] = abs(a12-a11);
  newSpeed[1] = abs(a22-a21);
  newSpeed[2] = abs(a32-a31);
  newSpeed[3] = abs(a42-a41);
  newSpeed[4] = abs(a52-a51);
  newSpeed[5] = abs(a62-a61);
  
  for (int i=0; i<6; i++) {
    jointSpeeds.get(i).add(newSpeed[i]);
    env[i] += newSpeed[i];
    if (jointSpeeds.get(i).size() > 5) {
      float oldSpeed = jointSpeeds.get(i).get(0);
      jointSpeeds.get(i).remove(0);
      env[i] -= oldSpeed;
    }
  }
  
  stats.beginDraw();
  stats.background(0);
  stats.stroke(255);
  stats.fill(255);
  stats.text("amplitude", 35, 20);
  
  for (int i=0; i<6; i++) {
    int y = (int) map(i, 0, 6, 30, 210);
    stats.fill(255);
    stats.text(i, 16, y+12);
    
    float ax = map(ampThresh, 0, rmaxEnv, 0, 800);
    float ew = map(env[i], 0, rmaxEnv, 0, 800);
    if (env[i] < ampThresh)  stats.fill(255);
    else                     stats.fill(255, 0, 0);
    stats.rect(30, y, ew, 24);
    stats.line(ax+30, y, ax+30, y+24);
    
  }
  stats.endDraw();
  cf.updateStats(stats);
}


