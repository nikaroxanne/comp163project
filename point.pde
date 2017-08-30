class Point {
  float x, y;
 
 Point(float _x, float _y){
   x = _x;
   y = _y;
 }
 
 void display() {
   noStroke();
   fill(0,0,0);
   triangle(x, y, x+5, y+5, x+5, y); 
 }
}