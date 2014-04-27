void setupGui() {
  cp5 = new ControlP5(this);
  cp5.setFont(createFont("Courier", 13));
  cp5.addSlider("pitchAmpThresh").setPosition(10, 30).setSize(120, 20).setRange(0.0, 0.3).setValue(0.02);
  cp5.addSlider("pitchMedian").setPosition(10, 60).setSize(120, 20).setRange(3, 20).setValue(7);
  cp5.addSlider("decayCoeff").setPosition(10, 90).setSize(120, 20).setRange(0.3, 0.9999).setValue(0.98);
  cp5.addSlider("ampThresh").setPosition(10, 120).setSize(120, 20).setRange(0.1, 1.0).setValue(0.3);
  cp5.addSlider("oscRate").setPosition(10, 150).setSize(120, 20).setRange(1, 100).setValue(30);
  
  cp5.addSlider("freqLerpRate").setPosition(10, 210).setSize(120, 20).setRange(0, 1).setValue(0.1);
  cp5.addSlider("nw").setPosition(10, 240).setSize(120, 20).setRange(4, 60).setValue(12);
  cp5.addSlider("nh").setPosition(10, 270).setSize(120, 20).setRange(4, 60).setValue(12);
  cp5.addSlider("rectSizeMult").setPosition(10, 300).setSize(120, 20).setRange(0.1, 3).setValue(1.2);
  cp5.addSlider("offset").setPosition(10, 330).setSize(120, 20).setRange(0, 100).setValue(30);
  
  cp5.addSlider("strokeWt").setPosition(10, 360).setSize(120, 20).setRange(0, 8).setValue(1);
  cp5.addSlider("alphF").setPosition(10, 390).setSize(120, 20).setRange(0, 255).setValue(20);
  cp5.addSlider("alphS").setPosition(10, 420).setSize(120, 20).setRange(0, 255).setValue(50);
  cp5.addSlider("fade").setPosition(10, 450).setSize(120, 20).setRange(0, 255).setValue(80);
  
  DropdownList d = cp5.addDropdownList("shaderSelection")
    .setPosition(10, 500).setSize(200, 300);
  d.setItemHeight(20);
  d.setBarHeight(20);
  d.captionLabel().set("shader");
  d.captionLabel().style().marginTop = 3;
  d.captionLabel().style().marginLeft = 3;
  d.valueLabel().style().marginTop = 3;
  for (int i=0; i<shaders.length; i++) {
    d.addItem(shaders[i], i);
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
  else if (theEvent.name().equals("nw") || theEvent.name().equals("nh")) {
    resetNoisyRects();
  }
  else if (theEvent.name().equals("shaderSelection")) {
    idxShader = (int) theEvent.getValue();
    setupShader();
  }
  
}
