final int BEGIN = 0;
final int GAUSSIAN = 1;
final int FACEDETECT = 2;
final int SOBEL = 3;
final int CORNER = 4;
final int LANDMARKS = 5;
final int SORT = 6;
final int CONVEXHULL = 7;
final int MONOTONETRI = 8;
final int FLIP = 9;
final int DELAUNAY = 10;
final int VORONOI = 11;

class State{
  int state;
  State() {
    state = 0;
  }
  void next(){
    state++;
  }
}