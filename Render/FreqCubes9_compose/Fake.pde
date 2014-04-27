BufferedReader reader;
String line;
PrintWriter output;
ArrayList<float[]> fakePoints;
int idxFake;
int currTime, nextTime, nextIdx;

float a11, a21, a31, a41, a51, a61;
float a12, a22, a32, a42, a52, a62;

int t;

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
  output = createWriter("positions3.txt"); 
}

void nextRobotTimed() {
  
  t = millis() - t0 + lookAhead;
  
  
  float rat = 0;
  if (nextTime > currTime) {
    rat = (t-currTime) / (nextTime - currTime);
  }
  angleAxis1 = lerp(a11, a12, rat);
  angleAxis2 = lerp(a21, a22, rat);
  angleAxis3 = lerp(a31, a32, rat);
  angleAxis4 = lerp(a41, a42, rat);
  angleAxis5 = lerp(a51, a52, rat);
  angleAxis6 = lerp(a61, a62, rat);
  
  if (t >= nextTime) {
    //println("got point at "+ t + " " + nextIdx);
    currTime = nextTime;
    a11 = a12;
    a21 = a22;
    a31 = a32;
    a41 = a42;
    a51 = a52;
    a61 = a62;
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
    a12 = radians(Float.parseFloat(s[1]));
    a22 = radians(Float.parseFloat(s[2]));
    a32 = radians(Float.parseFloat(s[3]));
    a42 = radians(Float.parseFloat(s[4]));
    a52 = radians(Float.parseFloat(s[5]));
    a62 = radians(Float.parseFloat(s[6]));
    nextTime = t;
    //println(line);
  } catch (IOException e) {
    println("error reading from file : "+e.toString());
    e.printStackTrace();
    line = null;
  }
}

/*
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
*/
/*
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
*/
