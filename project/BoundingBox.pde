import gab.opencv.*;
import java.awt.Rectangle;

class BoundingBox {
  int x, y, width, height;
  Rectangle [] faces;

 
  BoundingBox(int _x, int _y, int _width, int _height) {
    x = _x; 
    y = _y; 
    width = _width; 
    height = _height;
  }
  void draw() {
    noFill();
    stroke(0,255,0);
    strokeWeight(3);
    rect(x, y, width, height);
    
  }
}
