
class FacePoint {
  float x, y, pointShade;
  ArrayList<Edge> edges;

  FacePoint(float _x, float _y, float _pointShade) {
    x = _x;
    y = _y;
    pointShade = _pointShade;
    //edges = new ArrayList();
  }

  void showPoint() {
    noStroke();
    fill(255);
    triangle(x, y, x+3, y+3, x+3, y);
  }
  
  
  /*void showEdges(){
   for (Edge edge : edges) {
   edge.draw();
   }
   }*/
  /*void organize(){
   }*/
}