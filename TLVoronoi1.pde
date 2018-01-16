import toxi.geom.*;
import toxi.geom.mesh2d.*;

import toxi.util.*;
import toxi.util.datatypes.*;

import toxi.processing.*;

import gab.opencv.*;

import java.awt.Rectangle;
import java.util.Collections;
import java.util.Comparator;


final int SCALEFACTOR = 1;
final int DISPLAYWIDTH = 600;
final int DISPLAYHEIGHT = 600;
int matrixSize = 3;
float xMin, yMin, xMax, yMax;
boolean isRightTurn = false;
boolean animate = true;
boolean saveFrames = true;
int maxFrames = 10;

PImage src, img, destination, imgMask;
ArrayList<BoundingBox> boxPoints;
ArrayList<FacePoint> facePoints;
ArrayList<FacePoint> hullPoints;

//ArrayList<FacePoint> lUpperPoints;
//ArrayList<FacePoint> lLowerPoints;
ArrayList<Edge> edges;
Rectangle[] faces;
OpenCV opencv;

ToxiclibsSupport gfx;
Voronoi voronoi;

FacePoint YMIN;
float YMINY, YMINX;

//Facepoint [] facepoints = {(322, 258, 6.32),
/*334 250 27.8},
 //336 259 65.4},
 //345 257 17.72},
 //353 250 33.72},
 //351 246 15.36},
 //341 244 21.64},
 //345 251 60.12},
 //370 227 68.4},
 //402 223 71.52},
 //431 207 52.04},
 //450 197 58.04},
 //449 187 81.92},
 //426 200 67.08},
 //482 201 66.56},
 //329 228 65.72},
 //330 218 46.08},
 //311 216 71.4},
 //308 225 62.56},
 //291 240 60.68},
 //292 300 53.32},
 //318 330 50.64},
 //330 366 37.28},
 //342 382 47.48},
 //375 414 39.72},
 //416 425 25.88},
 //460 406 42.52},
 //473 396 38.4},
 //493 377 45.88},
 //510 352 59.04},
 //514 322 62.04},
 //520 279 48.04},
 //528 250 70.28},
 //515 208 25.88},
 //380 300 55.84},
 //395 304 60.04},
 {395, 304, 60.04},
 {407, 293, 68.64},
 {407, 293, 68.64},
 {379, 292, 68.12},
 {388, 283, 88.2},
 {403, 289, 77.16},
 {393, 293, 84.96},
 {377, 310, 75.88},
 {419, 304, 70.16},
 {403, 333, 76.6},
 {413, 327, 83.0},
 {394, 332, 78.24},
 {394, 332, 78.24},
 {405, 343, 48.16},
 {408, 350, 64.12},
 {396, 342, 49.88},
 {414, 341, 50.2},
 {377, 356, 65.96},
 {440, 345, 55.4},
 {386, 344, 75.6},
 {427, 339, 79.16},
 {387, 365, 59.6},
 {399, 368, 70.6},
 {410, 362, 54.52},
 {424, 360, 66.08},
 {432, 352, 64.72},
 };*/

class BoundingBox {
  int x, y, width, height;
  Rectangle [] faces;
  PImage src;

  BoundingBox(int _x, int _y, int _width, int _height) {
    x = _x; 
    y = _y; 
    width = _width; 
    height = _height;
  }

  void draw() {
    noFill();
    stroke(0, 0, 255);
    strokeWeight(3);
    rect(x, y, width, height);
  }
}


void setup() {
  src = loadImage("nikanew.jpg");
  //imgMask = loadImage("facePointsRef.jpg");
  src.resize(0, 800);
  //imgMask.resize(150,150);
  //src.mask(imgMask);
  boxPoints = new ArrayList();
  size(800, 800);
  opencv = new OpenCV(this, src);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  faces = opencv.detect();
  checkFaces(faces);
  facePoints = new ArrayList();
  addFaces();
  hullPoints = new ArrayList();
  
  Collections.sort(facePoints, new PointYSort());
  //int facePointsLastIndex = facePoints.size()-1;
  YMIN = facePoints.get(0);
  YMINY = YMIN.y;
  YMINX = YMIN.x;
  println("YMINY is " + YMINY + "and YMINX is: " + YMINX);
  
  voronoi = new Voronoi();
  
  grahamScan = new GrahamScan(facePoints);
  //grahamScan.buildHull();
  //grahamScan.printHull();
  //hullPoints = grahamScan.convexhullpoints;
  //grahamScan.drawEdges();
  //drawHull();
  //int facesSize = facePoints.size();
  //int [] xVals = new int [facesSize];
  //int [] yVals = new int [facesSize];
  ////facePoints = java.util.Collections.sort(facePoints);

  ////really slow brute force way of sorting with a lot of overhead space storage
  //for (int i = 0; i < facePoints.size(); i++) {
  //  FacePoint facepointA = facePoints.get(i);
  //  xVals[i] = facepointA.x;
  //  yVals[i] = facepointA.y;
  //  xVals[i]++;
  //  yVals[i]++;
  //  //FacePoint facepointB = facePoints.get(i+1);
  //  //if((facepointA.VISITED == false) && (facepointB.VISITED == false)) {
  //  //  edges.add(new Edge(facepointA, facepointB));
  //  //}
  //  //facepointA.VISITED = true;
  //  //facepointB.VISITED = true;
  //}
  //xVals = sort(xVals);
  //yVals = sort(yVals);
  //xMax = max(xVals);
  //yMax = max(yVals);
  //println(xMax);
  //println(yMax);
  //xMin = min(xVals);
  //yMin = min(yVals);
  //println(xMin);
  //println(yMin);

  //for(int i=0; i < xVals.length; i++){
  //  int xvalArray = xVals[i];
  //  println("xCoord is " + xvalArray + "and id is " + i);
  //}

  //int lowestxval = facePoints.get(0).x;
  //println(lowestxval);

  Collections.sort(facePoints, new PointXSort());
  
  //testing for correct sorting of collections
  /*
  for (int i=0; i < facePoints.size(); i++) {
    float xCoord = facePoints.get(i).x;
    float yCoord = facePoints.get(i).y;

    println("xCoord is " + xCoord + "and YCoord is " + yCoord + "and id is " + i);
  }
  
  Collections.sort(facePoints, new PointYSort());
  for (int i=0; i < facePoints.size(); i++) {
    float xCoord = facePoints.get(i).x;
    float yCoord = facePoints.get(i).y;

    println("xCoord is " + xCoord + "and YCoord is " + yCoord + "and id is " + i);
  }
  
  */
  
  
  //for divide and conquer method
  /*
  FacePoint hullstart = facePoints.get(0);
  hullPoints.add(hullstart);
  FacePoint hullnext = facePoints.get(1);
  hullPoints.add(hullnext);
  makeHull();
  //printHull();
  
  */
  
  //for Graham Scan method
  

  edges = new ArrayList();
  //for (int i=0; i < facePoints.size(); i++) {
  //  FacePoint facepointYcheck = facePoints.get(i);
  //  if (facepointYcheck.y == yMin) {
  //    for (int j=0; j < facePoints.size()-1; j++) {
  //      FacePoint facepointYRadial = facePoints.get(j);
  //      if (facepointYRadial != facepointYcheck) {
  //        edges.add(new Edge(facepointYcheck, facepointYRadial));
  //      }
  //    }
  //  }
  //}
  //  int index = xIndices.get(facepointX);
  //  facePoints.get(i).id = index;
  //  println(index);
  //}



  frameRate(5);
}

void draw() {
  background(0);
  image(src, 0, 0);
  filter(BLUR, 1);
  //imgMask.resize(faceWidth, faceHeight);
  //image(imgMask, faceX, faceY);
  for (BoundingBox boxPoint : boxPoints) {
    boxPoint.draw();
  }
  fill(0, 0, 0);
  
  //if(mousePressed == true){
  //  float brightnessGradient = averageGradient(mouseX,mouseY, matrixSize, src);
  //  facePoints.add(new FacePoint(mouseX, mouseY, brightnessGradient));
  //  //ellipse(mouseX, mouseY, 2, 2);
  //  println(mouseX, mouseY, brightnessGradient);
  //}
  //facePoints.add(new FacePoint(322, 258, 6.32));


  for (FacePoint facePoint : facePoints) {
    facePoint.showPoint();
    voronoi.addPoint(new Vec2D(facePoint.getXCoord(), facePoint.getYCoord()));
    //facePoint.VISITED = false;
  }
  
  
  for (Polygon2D polygon: voronoi.getRegions() ) {
    gfx.polygon2D( polygon ); 
  }
  
  //drawHull();
  stroke(0, 255, 0);
  noFill();
  //rect(xMin, yMin, xMax - xMin, yMax - yMin);
  
  stroke(5);
  //ellipse(YMIN.x, YMIN.y, 5, 5);
  
  
  if(animate){
    grahamScan.buildHull();
  }
  
  grahamScan.printHull();
  saveFrame("facialLandmarks1.png");
  //grahamScan.drawEdges();
  
  /*
  for (FacePoint hullPoint : hullPoints) {
    hullPoint.showPoint();
  }
  */
  //saveFrame("grahamScan/#####.png");
  //int hullsize = grahamScan.convexhullpoints.size();
  /*
  for (int i=0; i< hullsize -1 ; i++) {
        FacePoint a = grahamScan.convexhullpoints.get(i);
        FacePoint b = grahamScan.convexhullpoints.get(i+1);
        line(a.x, a.y, b.x, b.y);
   }
   */
   
   
   
  //float [] xVals = new float [69];
  //float [] yVals = new float [69];
  ////facePoints = java.util.Collections.sort(facePoints);
  //for (int i = 0; i < facePoints.size(); i++) {
  //   FacePoint facepointA = facePoints.get(i);
  //   xVals[0] = facepointA.x;
  //   yVals[0] = facepointA.y;
  //   //FacePoint facepointB = facePoints.get(i+1);
  //   //if((facepointA.VISITED == false) && (facepointB.VISITED == false)) {
  //   //  edges.add(new Edge(facepointA, facepointB));
  //   //}
  //   //facepointA.VISITED = true;
  //   //facepointB.VISITED = true;
  //}
  //xVals = sort(xVals);
  //yVals = sort(yVals);
  //float xMax = max(xVals);
  //float yMax = max(yVals);
  //println(xMax);
  //println(yMax);

  //for (Edge edge : edges) {
  //  edge.draw();
  //  println(edge.a.x, edge.b.x);
  //}
  //saveFrame("pointApproximations.jpg");
  //addPoints(mouseX, mouseY);
}

//int direction = 1;
//int currentPoint = 2;

//boolean isRightTurn(FacePoint a, FacePoint b, FacePoint c) {
//  return ((b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)) >= 0;
//}

//divide and conquer algo
/*
void makeHull() {
  //lUpperPoints = new ArrayList();
  //lLowerPoints = new ArrayList();
  //FacePoint h1 = hullstart;
  //FacePoint h2 = hullnext;
  //lUpperPoints.add(h1);
  //lUpperPoints.add(h2);
  for (int i=2; i < facePoints.size(); i++) {
    hullPoints.add(facePoints.get(i));
    FacePoint h1 = hullPoints.get(hullPoints.size() - 3);
    FacePoint h2 = hullPoints.get(hullPoints.size() - 2);
    FacePoint h3 = hullPoints.get(hullPoints.size() - 1);
    //int faceBounds = facePoints.size();
    //FacePoint h3 = facePoints.get(2);
    //for (int i=3; i < faceBounds; i++){
    //  FacePoint h3 = facePoints.get(i);
    //lUpperPoints.add(h3);
    while ((hullPoints.size() > 3) && (!isRightTurn(h1, h2, h3))) {
      //lUpperPoints.remove(h2);
      hullPoints.remove(hullPoints.size() -2);

      if (hullPoints.size() >= 3) {
        h1 = hullPoints.get(hullPoints.size() - 3);
        h2 = hullPoints.get(hullPoints.size() - 2);
        h3 = hullPoints.get(hullPoints.size() - 1);
      }
    }
    if (i == (facePoints.size() -1) || currentPoint == 0) {
      direction = direction *= -1;
    }
    currentPoint+=direction;
  }
  //for (int j =(faceBounds-2); j >=1; j--){
  //  FacePoint hlow3 = facePoints.get(j);
  //  FacePoint hlow2 = facePoints.get(j-1);
  //  FacePoint hlow1 = facePoints.get(j-2);
  //  lLowerPoints.add(hlow3);
  //  while ((lLowerPoints.size() > 2) && (!isRightTurn(hlow1,hlow2,hlow3))){
  //    lLowerPoints.remove(hlow2);
  //  }
  //}
  //lLowerPoints.remove(0);
  //int lowerHullLast = lLowerPoints.size()-1;
  //lLowerPoints.remove(lowerHullLast);
  //for (FacePoint point : lUpperPoints) {
  //  hullPoints.add(point);
  //}
  //for (FacePoint point : lLowerPoints) {
  //  hullPoints.add(point);
  //}
}
*/

/*
void printHull() {
  for (FacePoint point : hullPoints) {
    float xVal = point.getXCoord();
    float yVal = point.getYCoord();
    println("HullPoint located at: " + xVal + "and" + yVal);
  }
}

void drawHull(){
  for (int i=0; i< hullPoints.size()-1; i++){
    FacePoint p1 = hullPoints.get(i);
    FacePoint p2 = hullPoints.get(i+1);
    line(p1.x, p1.y, p2.x, p2.y);
  }
}

*/
void mousePressed() {
    save("facePoints.jpg");
  }
  
void checkFaces(Rectangle[] faces) {
  for (int i=0; i < faces.length; i++) {
    int facewidth = (faces[i].width)/SCALEFACTOR;
    int faceheight = (faces[i].height)/SCALEFACTOR;
    int faceX = (faces[i].x)/SCALEFACTOR;
    int faceY = (faces[i].y)/SCALEFACTOR;
    if ((faceheight > 100) && (facewidth > 100)) {
      boxPoints.add(new BoundingBox(faceX, faceY, facewidth, faceheight));
    }
  }
}

void addFaces() {
  /* hard-coded ArrayList of drawn FacePoints */
  facePoints.add(new FacePoint(322, 258, 6.32));
  facePoints.add(new FacePoint(421, 242, 58.4)); 
  facePoints.add(new FacePoint(435, 231, 22.16));
  facePoints.add(new FacePoint(441, 223, 28.08));
  facePoints.add(new FacePoint(440, 240, 33.64));
  facePoints.add(new FacePoint(448, 243, 49.52));
  facePoints.add(new FacePoint(454, 232, 24.88));
  facePoints.add(new FacePoint(452, 226, 3.92));
  facePoints.add(new FacePoint(444, 232, 69.76));
  facePoints.add(new FacePoint(465, 232, 13.36));
  facePoints.add(new FacePoint(364, 250, 62.84));
  facePoints.add(new FacePoint(322, 258, 6.32));
  facePoints.add(new FacePoint(334, 250, 27.8));
  facePoints.add(new FacePoint(336, 259, 65.4));
  facePoints.add(new FacePoint(345, 257, 17.72));
  facePoints.add(new FacePoint(353, 250, 33.72));
  facePoints.add(new FacePoint(351, 246, 15.36));
  facePoints.add(new FacePoint(341, 244, 21.64));
  facePoints.add(new FacePoint(345, 251, 60.12));
  facePoints.add(new FacePoint(370, 227, 68.4));
  facePoints.add(new FacePoint(402, 223, 71.52));
  facePoints.add(new FacePoint(431, 207, 52.04));
  facePoints.add(new FacePoint(450, 197, 58.04));
  facePoints.add(new FacePoint(449, 187, 81.92));
  facePoints.add(new FacePoint(426, 200, 67.08));
  facePoints.add(new FacePoint(482, 201, 66.56));
  facePoints.add(new FacePoint(329, 228, 65.72));
  facePoints.add(new FacePoint(330, 218, 46.08));
  facePoints.add(new FacePoint(311, 216, 71.4));
  facePoints.add(new FacePoint(308, 225, 62.56));
  facePoints.add(new FacePoint(291, 240, 60.68));
  facePoints.add(new FacePoint(292, 300, 53.32));
  facePoints.add(new FacePoint(318, 330, 50.64));
  facePoints.add(new FacePoint(330, 366, 37.28));
  facePoints.add(new FacePoint(342, 382, 47.48));
  facePoints.add(new FacePoint(375, 414, 39.72));
  facePoints.add(new FacePoint(416, 425, 25.88));
  facePoints.add(new FacePoint(460, 406, 42.52));
  facePoints.add(new FacePoint(473, 396, 38.4));
  facePoints.add(new FacePoint(493, 377, 45.88));
  facePoints.add(new FacePoint(510, 352, 59.04));
  facePoints.add(new FacePoint(514, 322, 62.04));
  facePoints.add(new FacePoint(520, 279, 48.04));
  facePoints.add(new FacePoint(528, 250, 70.28));
  facePoints.add(new FacePoint(515, 208, 25.88));
  facePoints.add(new FacePoint(380, 300, 55.84));
  facePoints.add(new FacePoint(395, 304, 60.04));
  facePoints.add(new FacePoint(395, 304, 60.04));
  facePoints.add(new FacePoint(407, 293, 68.64));
  facePoints.add(new FacePoint(407, 293, 68.64));
  facePoints.add(new FacePoint(379, 292, 68.12));
  facePoints.add(new FacePoint(388, 283, 88.2));
  facePoints.add(new FacePoint(403, 289, 77.16));
  facePoints.add(new FacePoint(393, 293, 84.96));
  facePoints.add(new FacePoint(377, 310, 75.88));
  facePoints.add(new FacePoint(419, 304, 70.16));
  facePoints.add(new FacePoint(403, 333, 76.6));
  facePoints.add(new FacePoint(413, 327, 83.0));
  facePoints.add(new FacePoint(394, 332, 78.24));
  facePoints.add(new FacePoint(394, 332, 78.24));
  facePoints.add(new FacePoint(405, 343, 48.16));
  facePoints.add(new FacePoint(408, 350, 64.12));
  facePoints.add(new FacePoint(396, 342, 49.88));
  facePoints.add(new FacePoint(414, 341, 50.2));
  facePoints.add(new FacePoint(377, 356, 65.96));
  facePoints.add(new FacePoint(440, 345, 55.4));
  facePoints.add(new FacePoint(386, 344, 75.6));
  facePoints.add(new FacePoint(427, 339, 79.16));
  facePoints.add(new FacePoint(387, 365, 59.6));
  facePoints.add(new FacePoint(399, 368, 70.6));
  facePoints.add(new FacePoint(410, 362, 54.52));
  facePoints.add(new FacePoint(424, 360, 66.08));
  facePoints.add(new FacePoint(432, 352, 64.72));
}

//void addPoints(int mouseX, int mouseY){
//  if(mousePressed == true){
//    ellipse(mouseX, mouseY, 2, 2);
//    fill(0,0,0);
//    println(mouseX, mouseY);
//  }
//}