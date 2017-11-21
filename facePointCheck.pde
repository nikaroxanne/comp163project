import gab.opencv.*;
import java.awt.Rectangle;
import java.util.Collections;


final int SCALEFACTOR = 1;
final int DISPLAYWIDTH = 600;
final int DISPLAYHEIGHT = 600;
int matrixSize = 3;
float xMin, yMin, xMax, yMax;

PImage src, img, destination, imgMask;
ArrayList<BoundingBox> boxPoints;
ArrayList<FacePoint> facePoints;
ArrayList<Edge> edges;
Rectangle[] faces;
OpenCV opencv;

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
  int facesSize = facePoints.size();
  float [] xVals = new float [facesSize];
  float [] yVals = new float [facesSize];
  //facePoints = java.util.Collections.sort(facePoints);
  for (int i = 0; i < facePoints.size(); i++) {
     FacePoint facepointA = facePoints.get(i);
     xVals[i] = facepointA.x;
     yVals[i] = facepointA.y;
     xVals[i]++;
     yVals[i]++;
     //FacePoint facepointB = facePoints.get(i+1);
     //if((facepointA.VISITED == false) && (facepointB.VISITED == false)) {
     //  edges.add(new Edge(facepointA, facepointB));
     //}
     //facepointA.VISITED = true;
     //facepointB.VISITED = true;
  }
  xVals = sort(xVals);
  yVals = sort(yVals);
  xMax = max(xVals);
  yMax = max(yVals);
  println(xMax);
  println(yMax);
  xMin = min(xVals);
  yMin = min(yVals);
  println(xMin);
  println(yMin);
  
  edges = new ArrayList();
  frameRate(5);
}

void draw() {
  background(0);
  image(src, 0, 0);
  //tint(255,127);
  filter(BLUR, 1);
  //int faceX = boxPoints.get(0).x;
  //int faceY = boxPoints.get(0).y;
  //int faceWidth = boxPoints.get(0).width;
  //int faceHeight = boxPoints.get(0).height;
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
    facePoint.VISITED = false;
  }
  
  stroke(0,255,0);
  noFill();
  rect(xMin, yMin, xMax - xMin, yMax - yMin);
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
  //  //edge.draw();
  //  println(edge.a.x, edge.b.x);
  //}
  //saveFrame("pointApproximations.jpg");
  //addPoints(mouseX, mouseY);
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

float sobel(int x, int y, float[][] matrixH, float[][] matrixV, int matrixsize, PImage img) {
  float sobelX = 0.0;
  float sobelY = 0.0;
  float sobelFinal = 0.0;
  int offset = matrixsize/2;
  for (int i=1; i<matrixsize; i++) {
    for (int j=1; j<matrixsize; j++) {
      int xloc = (x+i) - offset;
      int yloc = (y-j) - offset;
      int loc = xloc + img.width*yloc;
      loc = constrain(loc, 0, img.pixels.length-1);
      sobelX += (brightness(img.pixels[loc])*matrixH[i][j]);
      sobelY += (brightness(img.pixels[loc])*matrixV[i][j]);
    }
  }
  sobelFinal = sqrt(sq(sobelX) + sq(sobelY));
  sobelFinal = constrain(sobelFinal, 0, 255);
  print(sobelFinal);
  return sobelFinal;
}

float averageGradient(int x, int y, int matrixsize, PImage img) {
  float brightnessavg = 0.0;
  int offset = matrixsize/2;
  for (int i=0; i<matrixsize; i++) {
    for (int j=0; j<matrixsize; j++) {
      int xloc = (x+i) - offset;
      int yloc = (y-j) - offset;
      int loc = xloc + img.width*yloc;
      //int mid = x + y*img.width;
      loc = constrain(loc, 0, img.pixels.length-1);
      //mid = constrain(mid, 0, img.pixels.length-1);
      brightnessavg += (brightness(img.pixels[loc]));
      //brightnessavg += abs((brightness(img.pixels[mid]))- ((brightness(img.pixels[loc]))));
      //print(brightnessavg);
    }
  }
  brightnessavg /= 25.00;
  brightnessavg = constrain(brightnessavg, 0, 255);
  return brightnessavg;
}
//void addPoints(int mouseX, int mouseY){
//  if(mousePressed == true){
//    ellipse(mouseX, mouseY, 2, 2);
//    fill(0,0,0);
//    println(mouseX, mouseY);
//  }
//}