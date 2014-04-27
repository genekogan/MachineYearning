// get 6 buffers from supercollider, visualize envelope and frequency
// to use with RobotArm.scd

import oscP5.*;
import netP5.*;  
import controlP5.*;

ControlP5 cp5;
OscP5 oscP5;
NetAddress myRemoteLocation;
float[] freq;
int[] env;

// Sc3 tracking parameters
float pitchAmpThresh = 0.02;
int pitchMedian = 7;
float decayCoeff = 0.98; 
float ampThresh = 0.3;
int oscRate = 30;

// P5 receiving parameters
float freqLerpRate = 0.1;

void setup() {
  size(1024, 400);
  oscP5 = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress("127.0.0.1", 57120);
  freq = new float[6];
  env = new int[6];
  setupGui();
}

void setupGui() {
  cp5 = new ControlP5(this);
  cp5.setFont(createFont("Courier", 13));
  cp5.addSlider("pitchAmpThresh").setPosition(10, 30).setSize(120, 20).setRange(0.0, 0.3).setValue(0.02);
  cp5.addSlider("pitchMedian").setPosition(10, 60).setSize(120, 20).setRange(3, 20).setValue(7);
  cp5.addSlider("decayCoeff").setPosition(10, 90).setSize(120, 20).setRange(0.3, 0.9999).setValue(0.98);
  cp5.addSlider("ampThresh").setPosition(10, 120).setSize(120, 20).setRange(0.1, 1.0).setValue(0.3);
  cp5.addSlider("oscRate").setPosition(10, 150).setSize(120, 20).setRange(1, 100).setValue(30);
  cp5.addSlider("freqLerpRate").setPosition(10, 210).setSize(120, 20).setRange(0, 1).setValue(0.1);
}

void draw() 
{
  background(0);    
  for (int i=0; i<6; i++) {
    float w = map(freq[i], 0, 1500, 0, 500);
    if (env[i] == 0) {
      fill(255);
    } else if (env[i] == 1) {
      fill(255, 20, 20);
    }
    int y = (int) map(i, 0, 6, 30, 180);
    text(i, 300, y+12);
    rect(330, y, w, 20);
  }
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

void controlEvent(ControlEvent theEvent) {
  if      (theEvent.name().equals("pitchAmpThresh")) {
    sendOscMessage("/pitchAmpThresh", pitchAmpThresh);
  }
  else if (theEvent.name().equals("pitchMedian")) {
    sendOscMessage("/pitchMedian", pitchMedian);
  }
  else if (theEvent.name().equals("decayCoeff")) {
    sendOscMessage("/decayCoeff", decayCoeff);
  } 
  else if (theEvent.name().equals("ampThresh")) {
    sendOscMessage("/ampThresh", ampThresh);
  }
  else if (theEvent.name().equals("oscRate")) {
    sendOscMessage("/oscRate", oscRate);
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

