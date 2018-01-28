import java.util.Comparator;

public class FacePoint{
  float x, y; 
  float pointShade;
  ArrayList<Edge> edges;
  //boolean VISITED;
  int id;
  float angle;
  float dist;

  public FacePoint(float x, float y, float pointShade) {
    this.x = x;
    this.y = y;
    this.pointShade = pointShade;
    this.dist = dist(YMINX, YMINY, x, y);
    this.angle = atan2(YMINY -y,  YMINX - x);
    if (this.angle < 0) {
      this.angle += TAU;
    }/*
    
    if (this.angle == 0) {
      this.angle *= TAU;
    }
    */
    //id = 0;

    //distPt1 = (x-x2);
    //distPt2; (x1, y1, x2, y2);
    //angle = arccos((distPt1)/ (distPt2));
    //edges = new ArrayList();
  }

  public float getXCoord() {
    return this.x;
  }

  public float getYCoord() {
    return this.y;
  }

  public void setXCoord(float xCoord) {
    this.x = xCoord;
  }

  public void setYCoord(float yCoord) {
    this.y = yCoord;
  }

  //float polarAngle(FacePoint p1, FacePoint p2){
  //  float angle = atan2(p2.y, p2.x) - atan2(p1.y, p1.x); 
  //  return angle;
  //}

  //@ Override public int compareTo(FacePoint compareFace) {
  //  int compareQuantity = ((FacePoint) compareFace).getXCoord();
  //  //facepoints returned in ascending order of x coordinate value
  //  return this.x - compareQuantity;
  //}


/*

  @Override public int compareTo(FacePoint other) {

    //int thisX = this.getXCoord();
    //int otherXCoord = other.getXCoord();
    float compareQuantity = this.angle - other.angle;
    //facepoints returned in ascending order of x coordinate value
    //return compareQuantity;

    if (compareQuantity > 0) {
      return 1;
    } else if (compareQuantity < 0) {
      return -1;
    } else {
      /*
        if (f1.y < f2.y) {
          return 1;
        } else if (f1.y > f2.y) {
          return -1
        }/*
        
        /*
        return 0;
    }
  }
*/
//}
//*/

void showHullPoint() {
  noStroke();
  fill(0);
  triangle(x, y, x+10, y+10, x+10, y);
}

void showPoint() {
  noStroke();
  fill(255);
  triangle(x, y, x+3, y+3, x+3, y);
}
//FacePoint v1 = new FacePoint(421, 242, 58.4); 
//FacePoint v2 = new FacePoint(435, 231, 22.16);
//FacePoint v3 = new FacePoint(441, 223, 28.08);
//FacePoint v4 = new FacePoint(440, 240, 33.64);
//FacePoint v5 = new FacePoint(448, 243, 49.52);
//FacePoint v6 = new FacePoint(454, 232, 24.88);
//FacePoint v7 = new FacePoint(452, 226, 3.92);
//FacePoint v8 = new FacePoint(444, 232, 69.76);
//FacePoint v9 = new FacePoint(465, 232, 13.36);
//FacePoint v10 = new FacePoint(364, 250, 62.84);

/*void showEdges(){
 for (Edge edge : edges) {
 edge.draw();
 }
 }*/
/*void organize(){
 }*/
}