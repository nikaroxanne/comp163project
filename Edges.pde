class Edge {
 FacePoint a, b;
 
 Edge(FacePoint _a, FacePoint _b){
  a = _a;
  b = _b;
 }
 
 void draw(){
   line(a.x, a.y, b.x, b.y);
 }
  
}