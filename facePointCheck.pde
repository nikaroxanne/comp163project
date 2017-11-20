import gab.opencv.*;
import java.awt.Rectangle;

final int SCALEFACTOR = 1;
final int DISPLAYWIDTH = 600;
final int DISPLAYHEIGHT = 600;
int matrixSize = 3;

PImage src, img, destination, imgMask;
ArrayList<BoundingBox> boxPoints;
ArrayList<FacePoint> facePoints;
Rectangle[] faces;
OpenCV opencv;

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
  fill(0,0,0);
  if(mousePressed == true){
    float brightnessGradient = averageGradient(mouseX,mouseY, matrixSize, src);
    facePoints.add(new FacePoint(mouseX, mouseY, brightnessGradient));
    //ellipse(mouseX, mouseY, 2, 2);
    println(mouseX, mouseY, brightnessGradient);
  }
   for (FacePoint facePoint : facePoints) {
    facePoint.showPoint();
  }
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