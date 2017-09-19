class FacePoint {
  float x, y, pointShade;
  ArrayList<Edge> edges;
 
 FacePoint(float _x, float _y, float _pointShade){
   x = _x;
   y = _y;
   pointShade = _pointShade;
 }
 void makeEdge(){
    for (int i = facePoints.size() -1; i >= 0; i--){
      FacePoint facePoint1 = facePoints.get(i);
      
      FacePoint facePoint2 = facePoints.get(i-1);
      Edge edge = new Edge(facePoint1, facePoint2);
    }
 }
 void showPoints() {
   noStroke();
   fill(255);
   triangle(x, y, x+5, y+5, x+5, y); 
 }
 void showEdges(){
   for (Edge edge : edges) {
     edge.draw();
   }
 }
}