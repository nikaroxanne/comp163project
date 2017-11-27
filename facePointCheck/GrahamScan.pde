/* This implementation is based on the work by Nikolai Janakiev
 github.com/njanakiev/graham-scan
 
 I adapted his implementation of Graham Scan in Processing
 */

import java.util.Collections;

class GrahamScan {
  ArrayList<FacePoint> facepoints;
  ArrayList<FacePoint> convexhullpoints;
  //FacePoint YMIN;

  //number of items in initial point set of facial landmarks
  int numFacePoints, indexFacePoints;

  GrahamScan(ArrayList<FacePoint> facepoints) {
    this.facepoints = facepoints;
    this.convexhullpoints = new ArrayList<FacePoint>();
    this.numFacePoints = facepoints.size();

    //Collections.sort(facepoints, new PointYSort());
    FacePoint start = facepoints.get(0);

    convexhullpoints.add(start);
    //facePoints radially sorted with respect to point with min Y value
    Collections.sort(facepoints, new PointAngleSort());
    
    /* printing to ensure all values of facepoints are sorted*/
    for (int i=0; i < facePoints.size(); i++) {
      float xCoord = facePoints.get(i).x;
      float yCoord = facePoints.get(i).y;
      println("xCoord is " + xCoord + "and YCoord is " + yCoord + "and id is " + i);
    }
  
    
    FacePoint firstTest = facepoints.get(1);
    FacePoint secondTest = facepoints.get(2);
    convexhullpoints.add(firstTest);
    convexhullpoints.add(secondTest);
    println("convexhull point at index 0" + convexhullpoints.get(0));
    println("convexhull point at index 1" + convexhullpoints.get(1));
    println("convexhull point at index 2" + convexhullpoints.get(2));
    this.indexFacePoints = 2;
  }

  void buildHull() {
    if (indexFacePoints <= numFacePoints) {

      int hullSize = convexhullpoints.size();
      //hullPoints.add(facePoints.get(i));
      FacePoint h1 = convexhullpoints.get(convexhullpoints.size() - 3);
      FacePoint h2 = convexhullpoints.get(convexhullpoints.size() - 2);
      FacePoint h3 = convexhullpoints.get(convexhullpoints.size() - 1);
      float direction = orientation(h1, h2, h3);

      //if direction is counterclockwise, if LEFT TURN
      if (direction < 0) {

        if (hullSize > 2) {
          while (direction < 0 && hullSize > 3) {
            convexhullpoints.remove(h2);
            h1 = convexhullpoints.get(convexhullpoints.size() - 3);
            h2 = convexhullpoints.get(convexhullpoints.size() - 2);
            h3 = convexhullpoints.get(convexhullpoints.size() - 1);
          }
        } else {
          convexhullpoints.remove(h2);
          if (indexFacePoints < numFacePoints) {
            int entrypoint = ((indexFacePoints + 1) % numFacePoints);
            convexhullpoints.add(facepoints.get(entrypoint));
          } 
          indexFacePoints++;
        }
        //else if direction is clockwise, then RIGHT TURN
      } else if ((direction >=0) && indexFacePoints <= numFacePoints) {
        //go to next point
        int entrypoint = ((indexFacePoints + 1) % numFacePoints);
        convexhullpoints.add(facepoints.get(entrypoint));
        indexFacePoints++;
      }
    }
  }
  //get y min
  //add y min to convex hull points
  // compare all points to y min using polar angle
  //sort all points by angle in counterclockwise order around y min

  float orientation(FacePoint p1, FacePoint p2, FacePoint p3) {
    //expression is negative when orientation is counterclockwise, 
    float orientation = (p2.y - p1.y)*(p3.x - p2.x) - (p3.y- p2.y)*(p2.x-p1.x);
    //expression is positive when orientation is clockwise
    return orientation;
    //expression is 0 when points are collinear
  }

  void drawEdges() {
    stroke(5);
    if (convexhullpoints.size() > 1) {
      int hullSize = convexhullpoints.size();
      for (int i=0; i< hullSize -1; i++) {
        FacePoint a = convexhullpoints.get(i);
        FacePoint b = convexhullpoints.get(i+1);
        line(a.x, a.y, b.x, b.y);
      }
    }
  }

  void printHull() {
    for (FacePoint point : convexhullpoints) {
      float xVal = point.getXCoord();
      float yVal = point.getYCoord();
      println("HullPoint located at: " + xVal + "and" + yVal);
    }
  }
}
/*
  boolean isRightTurn(FacePoint a, FacePoint b, FacePoint c) {
 return ((b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)) >= 0;
 }
 */