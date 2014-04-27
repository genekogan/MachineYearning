// Sc3 tracking parameters
float pitchAmpThresh = 0.02;
int pitchMedian = 7;
float decayCoeff = 0.98; 
float ampThresh = 0.3;
int oscRate = 30;

// P5 receiving parameters
float freqLerpRate = 0.2;
float ampLerpRate = 0.2;
int maxFreq = 1000;
float maxEnv = 0.3;

float[] freq;
float[] env;
PGraphics stats;
OscP5 oscP5;
NetAddress myRemoteLocation;


void setupSc3() {
  stats = createGraphics(900, 210, P2D);
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 57120);
  
  freq = new float[6];
  env = new float[6];
}

void updateSc3Stats() 
{
  stats.beginDraw();
  stats.background(0);
  stats.stroke(255);
  stats.fill(255);
  stats.text("amplitude", 35, 20);
  stats.text("pitch", 465, 20);
  
  for (int i=0; i<6; i++) {
    int y = (int) map(i, 0, 6, 30, 210);
    stats.fill(255);
    stats.text(i, 16, y+12);
    stats.text(i, 446, y+12);
    
    float ax = map(ampThresh, 0, maxEnv, 0, 420);
    float ew = map(env[i], 0, maxEnv, 0, 420);
    float ef = map(freq[i], 0, maxFreq, 0, 420);
    if (env[i] < ampThresh)  stats.fill(255);
    else                     stats.fill(255, 0, 0);
    stats.rect(30, y, ew, 24);
    stats.line(ax+30, y, ax+30, y+24);
    
    stats.fill(0, 0, 255);
    stats.rect(460, y, ef, 24);
    
  }
  stats.endDraw();
  cf.updateStats(stats);
}

void oscEvent(OscMessage theOscMessage) {  
  if (theOscMessage.addrPattern().equals("/robotTracker")) {
    for (int i=0; i<6; i++) {
      float newEnv = theOscMessage.get(i).floatValue();
      float newFreq = theOscMessage.get(i+6).floatValue();
      env[i] = lerp(env[i], newEnv, ampLerpRate);
      freq[i] = lerp(freq[i], newFreq, freqLerpRate);
    }
  }
}

void sendOscMessage(String address, float value) {
  OscMessage msg = new OscMessage(address);  
  msg.add(value);
  oscP5.send(msg, myRemoteLocation);
}

void stop() {
  oscP5.stop();
}

