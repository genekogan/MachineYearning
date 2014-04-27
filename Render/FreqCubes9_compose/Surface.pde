import java.util.Comparator;
import java.util.Arrays;

color[] debugColors = new color[]{
  color(255, 0, 0), color(0, 0, 255), color(0, 255, 0), 
  color(255, 255, 0), color(255, 0, 255), color(0, 255, 255), 
  color(127, 0, 255), color(0, 255, 127), color(255, 127, 0) };

int idxDebugColor = 0;

class Surface 
{  
  CornerPinSurface surface;
  PGraphics offscreen;
  PGraphics surfaceGfx;
  color debugColor;
  
  PVector TL, TR, BR, BL, MID;
  PVector pTL, pTR, pBR, pBL;
  int xTL, xTR, xBR, xBL, yTL, yTR, yBR, yBL;
  
  PVector norm;
  float project;
  float distanceToProjector;
  boolean show;
  
  Surface(PGraphics surfaceGfx) {
    this.surfaceGfx = surfaceGfx;
    surface = ks.createCornerPinSurface(surfaceGfx.width, surfaceGfx.height, 24);  
    offscreen = createGraphics(surfaceGfx.width, surfaceGfx.height, P2D);  
    debugColor = debugColors[idxDebugColor++ % debugColors.length ];
    offscreen.beginDraw();
    offscreen.background(debugColor);
    offscreen.endDraw();
    
    xTL = 0;
    yTL = 0;
    xTR = surfaceGfx.width;
    yTR = 0;
    xBR = surfaceGfx.width;
    yBR = surfaceGfx.height;
    xBL = 0;
    yBL = surfaceGfx.height;
    
    // matching pairs
    TL = new PVector();
    TR = new PVector();
    BR = new PVector();
    BL = new PVector();
    pTL = new PVector();
    pTR = new PVector();
    pBR = new PVector();
    pBL = new PVector();
  }
  
  void setRobotCoordinates(PVector TL0, PVector TR0, PVector BR0, PVector BL0) {
    TL = TL0;
    TR = TR0;
    BR = BR0;
    BL = BL0;    
    TL.y *= -1;
    TR.y *= -1;
    BR.y *= -1;
    BL.y *= -1;
    
    MID = new PVector(0.25 * (TL.x + TR.x + BR.x + BL.x),
                      0.25 * (TL.y + TR.y + BR.y + BL.y),
                      0.25 * (TL.z + TR.z + BR.z + BL.z) );
    getNormalVector();
    getDistance();
  }
  
  void getNormalVector() {
    PVector v1 = PVector.sub(TL, BL);
    PVector v2 = PVector.sub(BR, BL);
    norm = v1.cross(v2);
    
    //project = norm.x * projector.x + norm.y * projector.y + norm.z * projector.z;
    
    PVector proj = new PVector(MID.x - projector.x, MID.y - projector.y, MID.z - projector.z);
    
    norm.normalize();
    proj.normalize();
    
    project = norm.x * proj.x + norm.y * proj.y + norm.z * proj.z;
    
    if (project > 0) show = true;
    else show = false;
  }
  
  void getDistance() {
    distanceToProjector = dist(MID.x, MID.y, MID.z, projector.x, projector.y, projector.z);
  }
  
  void mapToRobot() {
    pTL = convertRobotToProjector(TL);
    pTR = convertRobotToProjector(TR);
    pBR = convertRobotToProjector(BR);
    pBL = convertRobotToProjector(BL);
    moveMeshTo((int) map(pTL.x, 0, 1, 0, width), (int) map(pTL.y, 0, 1, 0, height), 
               (int) map(pTR.x, 0, 1, 0, width), (int) map(pTR.y, 0, 1, 0, height), 
               (int) map(pBR.x, 0, 1, 0, width), (int) map(pBR.y, 0, 1, 0, height),
               (int) map(pBL.x, 0, 1, 0, width), (int) map(pBL.y, 0, 1, 0, height));   
  }
  
  void draw() 
  {
    if (occlude) {
      if (show) {
        drawSurface();
      }
    } else {
      drawSurface();
    }
  }
  
  void drawSurface() {
    if (debugGfx) {
      updateDebugGfx();
      surface.render(offscreen);
    } else {
      surface.render(surfaceGfx);
    } 
  }
  
  void moveMeshTo(int xTL1, int yTL1, int xTR1, int yTR1, int xBR1, int yBR1, int xBL1, int yBL1) {
    surface.moveMeshPointBy(CornerPinSurface.TL, xTL1-xTL, yTL1-yTL);
    surface.moveMeshPointBy(CornerPinSurface.TR, xTR1-xTR, yTR1-yTR);
    surface.moveMeshPointBy(CornerPinSurface.BR, xBR1-xBR, yBR1-yBR);
    surface.moveMeshPointBy(CornerPinSurface.BL, xBL1-xBL, yBL1-yBL);
    xTL = xTL1;
    xTR = xTR1;
    xBR = xBR1;
    xBL = xBL1;
    yTL = yTL1;
    yTR = yTR1;
    yBR = yBR1;
    yBL = yBL1;  
  }
  
  void updateDebugGfx() {
    offscreen.beginDraw();
    offscreen.resetShader();    
    offscreen.fill(red(debugColor)+random(-20, 20), green(debugColor)+random(-20, 20), blue(debugColor)+random(-20, 20), random(220, 255));
    offscreen.rect(random(offscreen.width),random(offscreen.height),random(100, 200), random(100, 200));
    offscreen.fill(0);
    offscreen.textSize(50);
    offscreen.text(project, offscreen.width/6, offscreen.height/2); 
    offscreen.endDraw();
  }
}




// COMPARATOR FOR SORTING BY DISTANCE FROM PROJECTOR
public class DistanceComparator implements Comparator<Integer>
{
    private final ArrayList<Surface> surfaces;

    public DistanceComparator(ArrayList<Surface> surfaces)
    {
        this.surfaces = surfaces;
    }

    public Integer[] createIndexArray()
    {
        Integer[] indexes = new Integer[surfaces.size()];
        for (int i = 0; i < surfaces.size(); i++)
        {
            indexes[i] = i;
        }
        return indexes;
    }

    public int compare(Integer index1, Integer index2)
    {
        if (surfaces.get(index1).distanceToProjector == surfaces.get(index2).distanceToProjector) return 0;
        else {   
          return surfaces.get(index1).distanceToProjector > surfaces.get(index2).distanceToProjector ? -1 : 1;
        }
    }
}


