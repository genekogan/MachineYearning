import processing.serial.*;

PrintWriter output;

Serial myPort;  // Create object from Serial class
String val;      // Data received from the serial port
int t0 = 0;
boolean hasFirstTime = false;

void setup() 
{
  size(200, 200);
  frameRate(2000);
  String portName = Serial.list()[5];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');
  
  output = createWriter("positions.txt");
}

void draw()
{
}

void serialEvent(Serial myPort) {
  if (frameCount < 30) {
     myPort.readString();
  }
  else {
    try {
    val = myPort.readString(); //Until('\n');
    String[] list = split(val, ' ');
    if (list.length > 1) {
    //if the second value is "1" then we are getting a joint angle string
    if (list[1].equals("1")) {

      int ts = millis();
      
      if (!hasFirstTime) {
        t0 = ts;
        hasFirstTime = true;
      }
      
      println("fakePointsTimed.add(new float[]{"+(ts-t0)+", "+ list[5] + ", " + list[6] + ", " + list[7] + ", " + list[8] + ", " + list[9] + ", " + split(list[10],"\n")[0] +"});");      
      //println(ts-t0);
      output.println("fakePointsTimed.add(new float[]{"+(ts-t0)+", "+ list[5] + ", " + list[6] + ", " + list[7] + ", " + list[8] + ", " + list[9] + ", " + split(list[10],"\n")[0] +"});");  
      
    }
    }
    } catch(Exception e) {
      println("error : " + val + " : "+e.toString());
    }
  }  
}

