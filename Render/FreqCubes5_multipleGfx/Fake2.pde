BufferedReader reader;
String line;
 
void setupReader() {
  // Open the file from the createWriter() example
  reader = createReader("positions.txt");   
  readPositionsFromFile(); 
}

float a1, a2, a3, a4, a5, a6;
 
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
