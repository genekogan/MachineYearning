// Sc3 tracking parameters
float pitchAmpThresh = 0.02;
int pitchMedian = 7;
float decayCoeff = 0.98; 
float ampThresh = 0.3;
int oscRate = 30;

// P5 receiving parameters
float freqLerpRate = 0.1;

void setupSc3() {
  stats = createGraphics(600, 210, P2D);
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 57120);
  
  freq = new float[6];
  env = new int[6];
}

void updateStats() 
{
  stats.beginDraw();
  stats.fill(0, 220);
  stats.rect(0, 0, stats.width, stats.height);  
  for (int i=0; i<6; i++) {
    float w = map(freq[i], 0, 1500, 0, 500);
    if (env[i] == 0) {
      stats.fill(255);
    } 
    else if (env[i] == 1) {
      stats.fill(255, 20, 20);
    }
    int y = (int) map(i, 0, 6, 20, 210);
    stats.text(i, 18, y+12);
    stats.rect(25, y, w, 24);
  }
  stats.endDraw();
}

void oscEvent(OscMessage theOscMessage) {  
  if (theOscMessage.addrPattern().equals("/robotTracker")) {
    for (int i=0; i<6; i++) {
      int newEnv = (int) theOscMessage.get(i).floatValue();
      float newFreq = theOscMessage.get(i+6).floatValue();
      env[i] = newEnv;
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

