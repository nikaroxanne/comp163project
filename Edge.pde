class Edge {
 FacePoint a, b;
 
 Edge(FacePoint _a, FacePoint _b){
  a = _a;
  b = _b;
 }
 
 void draw(){
   stroke(127);
   line(a.x, a.y, b.x, b.y);
 }
  
}