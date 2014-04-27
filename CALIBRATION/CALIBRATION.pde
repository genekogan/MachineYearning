int pWidth = 1280;
int pHeight = 800; 
int tWidth = 1680;

String CALIBRATION_FILE = "/Users/Gene/Projects/MachineYearning/RobotCalibration.txt";
import javax.swing.JFrame;
import KinectProjectorToolkit.*;

ProjectionFrame pf;
ProjectionFrameApplet ca;
ArrayList<PVector> robotPoints, projectorPoints;
PVector robotPoint, projectorPoint, mousePos;
boolean calibrated = false;
boolean testingMode = false;
boolean isRobot = true;
boolean isNewRobotPoint = false;

void setup() {
  size(1200, 768);
  textFont(createFont("Courier", 24));
  pf = new ProjectionFrame();
  
  // matching pairs
  robotPoints = new ArrayList<PVector>();
  projectorPoints = new ArrayList<PVector>();
  
  robotPoint = new PVector();
  projectorPoint = new PVector();
  mousePos = new PVector();
  setupSerial();
  
  //loadCalibration("/Users/Gene/Desktop/robotCalib.txt");
}

void draw() {
  
  
  if (isRobot) {
    robotPoint = getRobotPoint();
  }
  
  // set projector point
  if (testingMode) {
    text("testing", width-100, 20);
    projectorPoint = convertKinectToProjector(robotPoint);
  } else {
    float x = map(mousePos.x, 0, width, 0, 1);
    float y = map(mousePos.y, 0, height, 0, 1);
    projectorPoint.set(x, y);
  }
  
  background(255);
  textSize(16);
  fill(0);
  if (isNewRobotPoint) {
    pushStyle();
    fill(0, 255, 0);
    ellipse(24, 34, 12, 12);
    popStyle();
  }
  text("projector : "+projectorPoint.x+", "+projectorPoint.y, 40, 20);
  text("robot     : "+robotPoint.x+", "+robotPoint.y+", "+robotPoint.z, 40, 40);
  
  text("point pairs ("+projectorPoints.size()+")", 20, 80);
  for (int i=0; i<projectorPoints.size(); i++) {
    PVector p = projectorPoints.get(i);
    PVector r = robotPoints.get(i);
    text(i+" : p("+p.x+","+p.y+"), r("+r.x+","+r.y+","+r.z+")", 30, 100 + 20*i);
  }

  drawPf();
}

void addPointPair() {
  projectorPoints.add(new PVector(projectorPoint.x, projectorPoint.y));
  robotPoints.add(new PVector(robotPoint.x, robotPoint.y, robotPoint.z));
  println("projectorPoints.add(new PVector("+projectorPoint.x+", "+projectorPoint.y+"));");
  println("robotPoints.add(new PVector("+robotPoint.x+", "+robotPoint.y+", "+robotPoint.z+"));");
}

void getPointPairs() {
  for (int i=0; i<projectorPoints.size(); i++) {
    PVector p = projectorPoints.get(i);
    PVector r = robotPoints.get(i);
    //println(i+" : p("+p.x+","+p.y+"), r("+r.x+","+r.y+","+r.z+")");
  }
}

void drawPf() {
  float pfsize = map(sin(0.1*frameCount), -1, 1, 1, 32);
  ca.background(255);
  ca.fill(0, 255, 0);
  ca.ellipse(map(projectorPoint.x, 0, 1, 0, pWidth), map(projectorPoint.y, 0, 1, 0, pHeight), pfsize, pfsize);  
  ca.redraw();
}

void mouseMoved() {
  mousePos.set(mouseX, mouseY);
}

void keyPressed() {
  if (key==' ') {
    addPointPair();
    isNewRobotPoint = false;
  } else if (key=='c') {
    calibrate();
  } else if (key=='s') {
    saveCalibration(CALIBRATION_FILE);
  } else if (key=='t') {
    testingMode = !testingMode;
  }
  
  else if (keyCode == LEFT) {
    mousePos.x -= 1;
  }
  else if (keyCode == RIGHT) {
    mousePos.x += 1;
  }
  else if (keyCode == UP) {
    mousePos.y -= 1;
  }
  else if (keyCode == DOWN) {
    mousePos.y += 1;
  }
  
  
  else if (key=='1') {
    robotPoint = new PVector(mouseX, mouseY, random(100, 120));
  } else if (key=='2') {
    /*
    projectorPoints.add(new PVector(0.5208333, 0.075520836));
    robotPoints.add(new PVector(714.086, -650.854, 2812.31));
    projectorPoints.add(new PVector(0.3475, 0.20963542));
    robotPoints.add(new PVector(-324.214, -650.852, 2812.31));
    projectorPoints.add(new PVector(0.3025, 0.3815104));
    robotPoints.add(new PVector(-651.985, -650.844, 2263.79));
    projectorPoints.add(new PVector(0.16583334, 0.4153646));
    robotPoints.add(new PVector(-1472.11, -877.741, 2263.8));
    projectorPoints.add(new PVector(0.11333334, 0.4453125));
    robotPoints.add(new PVector(-1929.11, -891.653, 2263.8));
    projectorPoints.add(new PVector(0.104166664, 0.6770833));
    robotPoints.add(new PVector(-1929.12, -891.651, 1338.78));
    projectorPoints.add(new PVector(0.0975, 0.89973956));
    robotPoints.add(new PVector(-1929.12, -891.645, 518.196));
    projectorPoints.add(new PVector(0.025, 0.9036458));
    robotPoints.add(new PVector(-2154.54, -1141.35, 518.155));
    projectorPoints.add(new PVector(0.021666666, 0.91276044));
    robotPoints.add(new PVector(-2405.73, -1014.4, 518.236));
    projectorPoints.add(new PVector(0.015, 0.83984375));
    robotPoints.add(new PVector(-1012.31, -1811.91, 518.19));
    projectorPoints.add(new PVector(0.25583333, 0.76692706));
    robotPoints.add(new PVector(259.382, -1811.91, 518.172));
    projectorPoints.add(new PVector(0.47333333, 0.7057292));
    robotPoints.add(new PVector(1043.76, -1811.9, 518.147));
    projectorPoints.add(new PVector(0.78583336, 0.60807294));
    robotPoints.add(new PVector(1818.85, -1811.91, 518.167));
    projectorPoints.add(new PVector(0.74666667, 0.2565104));
    robotPoints.add(new PVector(1801.85, -1809.86, 1066.72));
    projectorPoints.add(new PVector(0.7083333, 0.4309896));
    robotPoints.add(new PVector(1561.01, -1129.15, 1170.34));
    projectorPoints.add(new PVector(0.925, 0.86588544));
    robotPoints.add(new PVector(2100.39, 768.253, 376.023));
    projectorPoints.add(new PVector(0.88666666, 0.55338544));
    robotPoints.add(new PVector(2076.93, 645.706, 1396.45));
    projectorPoints.add(new PVector(0.735, 0.3125));
    robotPoints.add(new PVector(1491.14, 274.101, 2278.99));
    projectorPoints.add(new PVector(0.6766667, 0.22786458));
    robotPoints.add(new PVector(1290.0, -99.5066, 2432.78));
   */
  }
}

