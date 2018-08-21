// An Array of Bubble objects
Bubble[] bubbles;
// An XML object
XML xml;

void setup() {
  size(480, 360);
  loadData();
}

void loadData() {
  // Load XML file
  xml = loadXML("data.xml");
  // Get all the child nodes named "bubble"
  XML[] children = xml.getChildren("bubble");

  bubbles = new Bubble[children.length];
  // The size of the Bubble array is determined by the total XML elements named “bubble.”

  for (int i = 0; i < bubbles.length; i++) {
    
    XML positionElement = children[i].getChild("position");
  // The position element has two attributes: “x” and “y”.
  // Attributes can be accessed as an integer or float via getInt() and getFloat().
    float x = positionElement.getInt("x");
    float y = positionElement.getInt("y");
  
    // The diameter is the content of the child named "diameter"
    XML diameterElement = children[i].getChild("diameter");
    float diameter = diameterElement.getFloatContent();
    // Notice, however, with the content of an XML node, 
  // I retrieve via getIntContent() and getFloatContent().

    // The label is the content of the child named "label"
    XML labelElement = children[i].getChild("label");
    String label = labelElement.getContent();

    // Make a Bubble object out of the data read
    bubbles[i] = new Bubble(x, y, diameter, label);
  }  
}

void draw() {
  background(255);
  // Display all bubbles
  for (int i = 0; i < bubbles.length; i++) {
    bubbles[i].display();
    bubbles[i].rollover(mouseX, mouseY);
  }
}

// This simple Bubble class draws a circle to the window 
// and displays a text label when the mouse hovers.
class Bubble {
  float x, y;
  float diameter;
  String name;
  
  boolean over = false;
  
  // Create the Bubble
  Bubble(float tempX, float tempY, float tempD, String s) {
    x = tempX;
    y = tempY;
    diameter = tempD;
    name = s;
  }
  
  // Checking if mouse is over the bubble
  void rollover(float px, float py) {
    float d = dist(px, py, x, y);
    if (d<diameter/2) {
      over = true; 
    } else {
      over = false;
    }
  }
  
  // Display the Bubble
  void display() {
    stroke(0);
    strokeWeight(2);
    noFill();
    ellipse(x, y, diameter, diameter);
    if (over) {
      fill(0);
      textAlign(CENTER);
      text(name, x, y+diameter/2+20);
    }
  }
}
