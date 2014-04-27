BufferedReader reader;
String line;
PrintWriter output;
ArrayList<float[]> fakePoints;
int idxFake;
int nextTime, nextIdx;
float a1, a2, a3, a4, a5, a6;

void setupRobotTimed(String filename) {
  reader = createReader(filename);   
  readPositionsFromFile(); 
  nextIdx = 0;  
  nextTime = 0;
  if (!isSerial) {
    t0 = millis();
    hasFirstTime = true;
  }
}

void setupRecording() {
  output = createWriter("positions.txt"); 
}

void nextRobotTimed() {
  int t = millis() - t0 + delay;
  if (t >= nextTime) {
    //println("got point at "+ t + " " + nextIdx);
    angleAxis1 = a1;
    angleAxis2 = a2;
    angleAxis3 = a3;
    angleAxis4 = a4;
    angleAxis5 = a5;
    angleAxis6 = a6;
    nextIdx += 1;
    readPositionsFromFile();    
  }
}

void readPositionsFromFile() {
  try {
    line = reader.readLine();
    line = split(line, "fakePointsTimed.add(new float[]{")[1];
    line = split(line, "});")[0];
    String[] s = split(line, ",");
    int t = (int) (Float.parseFloat(s[0]));
    a1 = radians(Float.parseFloat(s[1]));
    a2 = radians(Float.parseFloat(s[2]));
    a3 = radians(Float.parseFloat(s[3]));
    a4 = radians(Float.parseFloat(s[4]));
    a5 = radians(Float.parseFloat(s[5]));
    a6 = radians(Float.parseFloat(s[6]));
    nextTime = t;
    
    //println(line);
  } catch (IOException e) {
    e.printStackTrace();
    line = null;
  }
  
} 
