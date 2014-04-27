Jama.Matrix A, x, y;
  
PVector convertKinectToProjector(PVector kp) {
  PVector out = new PVector();
  float denom = (float)x.get(8,0)*kp.x + (float)x.get(9,0)*kp.y + (float)x.get(10,0)*kp.z + 1;
  out.x = ((float)x.get(0,0)*kp.x + (float)x.get(1,0)*kp.y + (float)x.get(2,0)*kp.z + (float)x.get(3,0)) / denom;
  out.y = ((float)x.get(4,0)*kp.x + (float)x.get(5,0)*kp.y + (float)x.get(6,0)*kp.z + (float)x.get(7,0)) / denom;
  return out;
}

String[] getCalibrationString() {
  String[] coeffs = new String[11];
  for (int i=0; i<11; i++)
    coeffs[i] = ""+x.get(i,0);
  return coeffs;
}

void loadCalibration(String filename) {
  String[] s = loadStrings(dataPath(filename));
  x = new Jama.Matrix(11, 1);
  for (int i=0; i<s.length; i++)
    x.set(i, 0, Float.parseFloat(s[i]));
  calibrated = true;
  println("done loading");
}
