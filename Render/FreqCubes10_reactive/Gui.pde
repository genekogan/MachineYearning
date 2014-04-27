private ControlP5 cp5;
ControlFrame cf;

ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 30);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}

public class ControlFrame extends PApplet {  
  ControlP5 cp5;
  Object parent;
  PImage guiStats;
  ArrayList<PImage> guiGfx;
  int w, h;
  
  public void setup() {
    size(w, h);
    frameRate(16);
    textSize(22);
    fill(0);
    guiGfx = new ArrayList<PImage>();
    
    cp5 = new ControlP5(this);
        
    cp5.setFont(createFont("Courier", 13));
    cp5.addSlider("ampThresh").setPosition(width-235, 35).setSize(120, 20).setRange(0, 0.3).setValue(0.12);
    cp5.addToggle("updateGfx").setPosition(width-265, 60).setSize(20, 20);
    RadioButton rb = cp5.addRadioButton("switchMode").setPosition(width-235, 60).setItemWidth(50).setItemHeight(20);       
    for (int i=0; i<modes.length; i++)  rb.addItem(modes[i], i);

    
    cp5.addSlider("resolution").setPosition(10, 20).setSize(120, 20).setRange(10, 1024).setValue(256);
    //cp5.addSlider("nw").setPosition(10, 45).setSize(120, 20).setRange(1, 15).setValue(5);
    //cp5.addSlider("nh").setPosition(10, 70).setSize(120, 20).setRange(1, 15).setValue(5);
    //cp5.addSlider("rectSizeMult").setPosition(10, 95).setSize(120, 20).setRange(0.1, 3).setValue(1.2);
    //cp5.addSlider("offset").setPosition(10, 120).setSize(120, 20).setRange(0, 100).setValue(30);
    //cp5.addSlider("strokeWt").setPosition(10, 145).setSize(120, 20).setRange(0, 8).setValue(1);
    //cp5.addSlider("alphF").setPosition(10, 170).setSize(120, 20).setRange(0, 255).setValue(20);
    //cp5.addSlider("alphS").setPosition(10, 195).setSize(120, 20).setRange(0, 255).setValue(50);
    //cp5.addSlider("fade").setPosition(10, 220).setSize(120, 20).setRange(0, 255).setValue(80);


    cp5.addSlider("bitsMx").setPosition(10, 580).setSize(120, 20).setRange(0.01, 1.0).setValue(0.5);
    cp5.addSlider("bitsMy").setPosition(10, 610).setSize(120, 20).setRange(0.01, 1.0).setValue(0.5);
    cp5.addSlider("bitsFade").setPosition(10, 640).setSize(120, 20).setRange(0.01, 1.0).setValue(0.5);
    
    
    cp5.addSlider("outlinesMult").setPosition(10, 690).setSize(120, 20).setRange(1.0, 7.0).setValue(1.0);
    cp5.addSlider("outlinesPhase").setPosition(10, 720).setSize(120, 20).setRange(0.0, 10.0).setValue(0.0);
    cp5.addSlider("outlinesRad").setPosition(10, 750).setSize(120, 20).setRange(0.01, 1.0).setValue(0.9);
    cp5.addSlider("outlinesGive").setPosition(10, 780).setSize(120, 20).setRange(0.01, 1.0).setValue(0.1);
    cp5.addSlider("outlinesR").setPosition(10, 810).setSize(120, 20).setRange(0.01, 1.0).setValue(1.0);
    cp5.addSlider("outlinesG").setPosition(10, 840).setSize(120, 20).setRange(0.01, 1.0).setValue(1.0);
    cp5.addSlider("outlinesB").setPosition(10, 870).setSize(120, 20).setRange(0.01, 1.0).setValue(0.9);
    
    cp5.addSlider("fullR").setPosition(10, 910).setSize(120, 20).setRange(0, 255).setValue(255);
    cp5.addSlider("fullG").setPosition(10, 940).setSize(120, 20).setRange(0, 255).setValue(255);
    cp5.addSlider("fullB").setPosition(10, 970).setSize(120, 20).setRange(0, 255).setValue(0);
    
  }

  public void updateStats(PGraphics pgStats) {
    guiStats = pgStats.get();
  }
  
  public void updateGfx(ArrayList<Gfx> gfx) {
    guiGfx = new ArrayList<PImage>();
    for (int i=0; i<gfx.size(); i++) {
      guiGfx.add(gfx.get(i).getImage());
    }
  }
  
  public void draw() {
    background(36);
    try {
      image(guiStats, 300, 20);
      for (int i=0; i<guiGfx.size(); i++) {
        int x = 300 + (i % 4) * 260;
        int y = 300 + 300 * (int) (i/4);
        image(guiGfx.get(i), x, y);
      }
    } catch(Exception e) {
    }
    if (cp5.isVisible()) {
      pushStyle();
      fill(0, 200);
      rect(2, 6, 250, cf.height-12);
      popStyle();
      fill(255);
      text("fps: "+nf(applet.frameRate,2,1)+" ("+nf(this.frameRate,2,1)+")", cf.width-150, 22);
    }
  }
  
  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }

  public ControlP5 control() {
    return cp5;
  }
  
  void controlEvent(ControlEvent theEvent) 
  {
    if (theEvent.name().equals("ampThresh")) {
      ampThresh = theEvent.value();
    }
    else if (theEvent.name().equals("switchMode")) {
      resetGraphics((int) theEvent.value());
    }
    else if (theEvent.name().equals("resolution")) {
      gfxResolution = (int) theEvent.value();
      if (frameCount > 1) {
        resetGfx = true;        
      }
    }
    else if (theEvent.name().equals("updateGfx")) {
      updateGui = !updateGui;
    }
   
    
    /*
    else if (theEvent.name().equals("nw")) {
      rects.nw = (int) theEvent.value();
      rects.resetNoisyRects();
    }
    else if (theEvent.name().equals("nh")) {
      rects.nh = (int) theEvent.value();
      rects.resetNoisyRects();
    }
    else if (theEvent.name().equals("rectSizeMult")) {
      rects.rectSizeMult = theEvent.value();
    }
    else if (theEvent.name().equals("offset")) {
      rects.offset = (int) theEvent.value();
    }
    else if (theEvent.name().equals("strokeWt")) {
      rects.strokeWt = (int) theEvent.value();
    }
    else if (theEvent.name().equals("alphF")) {
      rects.alphF = (int) theEvent.value();
    }
    else if (theEvent.name().equals("alphS")) {
      rects.alphS = (int) theEvent.value();
    }
    else if (theEvent.name().equals("fade")) {
      rects.fade = (int) theEvent.value();
    }
    
    else if (theEvent.name().equals("bitsMx")) {
      bits.bitsMx = theEvent.value();
    }
    else if (theEvent.name().equals("bitsMy")) {
      bits.bitsMy = theEvent.value();
    }
    else if (theEvent.name().equals("bitsFade")) {
      bits.bitsFade = theEvent.value();
    }

    else if (theEvent.name().equals("outlinesMult")) {
      outlines.outlinesMult = theEvent.value();
    }
    else if (theEvent.name().equals("outlinesPhase")) {
      outlines.outlinesPhase = theEvent.value();
    }
    else if (theEvent.name().equals("outlinesRad")) {
      outlines.outlinesRad = theEvent.value();
    }
    else if (theEvent.name().equals("outlinesGive")) {
      outlines.outlinesGive = theEvent.value();
    }
    else if (theEvent.name().equals("outlinesR")) {
      outlines.outlinesR = theEvent.value();
    }
    else if (theEvent.name().equals("outlinesG")) {
      outlines.outlinesG = theEvent.value();
    }
    else if (theEvent.name().equals("outlinesB")) {
      outlines.outlinesB = theEvent.value();
    }
    
    else if (theEvent.name().equals("fullR")) {
      full.fullR = theEvent.value();
    }
    else if (theEvent.name().equals("fullG")) {
      full.fullG = theEvent.value();
    }
    else if (theEvent.name().equals("fullB")) {
      full.fullB = theEvent.value();
    }
    */
  }
}


