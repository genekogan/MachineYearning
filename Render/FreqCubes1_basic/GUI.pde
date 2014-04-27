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
