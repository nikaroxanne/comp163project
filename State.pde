final int BEGIN = 0;
final int GRAY = 1;
final int GAUSSIAN = 2;
final int FACEDETECT = 3;
final int SOBEL = 4;
final int CORNER = 5;
final int LANDMARKS = 6;
final int SORT = 7;
final int CONVEXHULL = 8;
final int MONOTONETRI = 9;
final int FLIP = 10;
final int DELAUNAY = 11;
final int VORONOI = 12;

class State{
  int state;
  State() {
    state = 0;
  }
  void next(){
    state++;
  }
}