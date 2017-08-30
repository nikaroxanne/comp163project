class Edge {
 Point a, b;
 
 Edge(Point _a, Point _b){
  a = _a;
  b = _b;
 }
 
 void draw(){
   line(a.x, a.y, b.x, b.y);
 }
  
}