/*trace:
sum of elements on matrix diagonal
*/
import gab.opencv.*;
import java.awt.Rectangle;



final int SCALEFACTOR = 1;
final int DISPLAYWIDTH = 600;
final int DISPLAYHEIGHT = 600;

final int STATETIMEMAX = 100;


float [][] matrixH = { {1, 0},  
  {0, -1}};
  
float [][] matrixV = { { 0, 1}, 
  { -1, 0}};
  
float [][] matrixB = { {1/9, 1/9, 1/9}, 
  { 1/9, 1/9, 1/9}, 
  { 1/9, 1/9, 1/9}};
  
float [][] matrixHSobel = { {-1, 0, 1}, 
  { -2, 0, 2}, 
  { -1, 0, 1}};
  
float [][] matrixVSobel = { {1, 2, 1}, 
  { 0, 0, 0}, 
  { -1, -2, -1}};
  
float [][] matrixBSobel = { {1/9, 1/9, 1/9}, 
  { 1/9, 1/9, 1/9}, 
  { 1/9, 1/9, 1/9}};


float sobelValue = 0.0;
float robertsValue = 0.0;
float brightnessGradient = 0.0;
int matrixsize = matrixH.length; 

PImage src, img, destination, sobelVersion, edgeFinal;
int rectX, rectY, rectWidth, rectHeight, rectXEnd, rectYEnd;

ArrayList<FacePoint> facePoints;
ArrayList<BoundingBox> boxPoints;
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
      //img = _img;
    }
    
    void draw() {
      noFill();
      stroke(0,0,255);
      strokeWeight(3);
      rect(x, y, width, height);
    }
}

  void setup(){
    img = loadImage("nikanew.jpg");
    src = loadImage("nikanew.jpg");
    src.resize(0,600);
    boxPoints = new ArrayList();
    size(600,600);
    opencv = new OpenCV(this, src);
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
    faces = opencv.detect();
    checkFaces(faces);
    
    BoundingBox boxMain = boxPoints.get(0);
    rectX = boxMain.x;
    rectY = boxMain.y;
    rectWidth = boxMain.width;
    rectHeight = boxMain.height;
    rectXEnd = rectX + rectWidth;
    rectYEnd = rectY + rectHeight;
    
    destination = createImage(img.width, img.height, RGB);
    sobelVersion = createImage(img.width, img.height, RGB);
    edgeFinal = createImage(img.width, img.height, RGB);
    
    src.loadPixels();
    destination.loadPixels();
    
    //updateSobel();
    //destination.updatePixels();
    
    updateBrightness();
    destination.updatePixels();
    updatePointsOfInterest();
    
    //updateSobel();
    //sobelVersion.updatePixels();
    
    //edgeFinal.loadPixels();
    //updateRoberts();
    //edgeFinal.updatePixels();
  }
  
  void draw(){
    background(0);
    image(src, 0, 0);
    for (BoundingBox boxPoint : boxPoints) {
      println(boxPoint.x);
      println(boxPoint.y);
      println(boxPoint.width);
      println(boxPoint.height);
      boxPoint.draw();
    }
    copy(destination, rectX, rectY, rectWidth, rectHeight, rectX, rectY, rectWidth, rectHeight);
    //copy(edgeFinal, rectX, rectY, rectWidth, rectHeight, rectX, rectY, rectWidth, rectHeight);
    stroke(0);
    noFill();
    rect(rectX, rectY, rectWidth, rectHeight);
    histogram(destination);
  }
  
  void mousePressed() {
    save("edgeDetect-####.jpg");
  }
  void checkFaces(Rectangle[] faces){
     for(int i=0; i < faces.length; i++){
      int facewidth = (faces[i].width)/SCALEFACTOR;
      int faceheight = (faces[i].height)/SCALEFACTOR;
      int faceX = (faces[i].x)/SCALEFACTOR;
      int faceY = (faces[i].y)/SCALEFACTOR;
      println(faces[i].x);
      println(faces[i].y);
      println(faces[i].width);
      println(faces[i].height);
      if ((faceheight > 100) && (facewidth > 100)) {
        boxPoints.add(new BoundingBox(faceX,faceY, facewidth,faceheight));
      }
    }
  }


void updateRoberts() {
  for (int x = rectX; x < rectXEnd; x++) {
   for (int y = rectY; y < rectYEnd; y++) {
   int pix = x + y*img.width;
   robertsValue = roberts(x, y, matrixH, matrixV, matrixsize, sobelVersion);
   edgeFinal.pixels[pix] = color(robertsValue);
   }
  }
}

void updateSobel() {
  for (int x = rectX; x < rectXEnd; x++) {
   for (int y = rectY; y < rectYEnd; y++) {
     sobelValue = sobel(x, y, matrixH, matrixV, matrixsize, destination);
     int pix = x + y*img.width;
     sobelVersion.pixels[pix] = color(sobelValue);
   }
  }
}

float roberts(int x, int y, float[][] matrixH, float[][] matrixV, int matrixsize, PImage img) {
  float robertsX = 0.0;
  float robertsY = 0.0;
  float robertsFinal = 0.0;
  int offset = matrixsize/2;
  for (int i=0; i<matrixsize; i++) {
    for (int j=0; j<matrixsize; j++) {
      int xloc = (x+i) - offset;
      int yloc = (y-j) - offset;
      int loc = xloc + img.width*yloc;
      loc = constrain(loc, 0, img.pixels.length -1);
      robertsX += (brightness(img.pixels[loc])*matrixH[i][j]);
      robertsY += (brightness(img.pixels[loc])*matrixV[i][j]);
    }
  }
  robertsFinal = sqrt(sq(robertsX) + sq(robertsY));
  robertsFinal = constrain(robertsFinal, 0, 255);
  print(robertsFinal);
  return robertsFinal;
}

float sobel(int x, int y, float[][] matrixH, float[][] matrixV, int matrixsize, PImage img) {
  float sobelX = 0.0;
  float sobelY = 0.0;
  float sobelFinal = 0.0;
  int offset = matrixsize/2;
  for (int i=0; i<matrixsize; i++) {
    for (int j=0; j<matrixsize; j++) {
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
      loc = constrain(loc, 0, img.pixels.length-1);
      brightnessavg += (brightness(img.pixels[loc]));
    }
  }
  brightnessavg /= 25.00;
  brightnessavg = constrain(brightnessavg, 0, 255);
  return brightnessavg;
}

void updateBrightness() {
  for (int x = rectX; x < rectXEnd; x++) {
   for (int y = rectY; y < rectYEnd; y++) {
     brightnessGradient = averageGradient(x,y, matrixsize, src);
     int pix = x + y*img.width;
     destination.pixels[pix] = color(brightnessGradient);
   }
  }
}

void updatePointsOfInterest() {
 if ((brightnessGradient > 90) && (brightnessGradient < 100)) {
     destination.pixels[pix] = color(255);
    facePoints.add(new FacePoint(x, y, brightnessGradient));
   } else {
     destination.pixels[pix] = color(0);
   }
   destination.updatePixels(); 
}

/*
destination.pixels[pix] = color(sobelValue);
   //brightnessGradient = averageGradient(x,y, matrixsize, destination);
   //destination.pixels[pix] = color(brightnessGradient);
   //if ((brightnessGradient > 90) && (brightnessGradient < 100)) {
   //  destination.pixels[pix] = color(255);
   //  facePoints.add(new FacePoint(x, y, brightnessGradient));
   //} else {
   //  destination.pixels[pix] = color(0);
   //}
   destination.updatePixels();
   
   */
   
void histogram(PImage img) {
  int bright = 0;
  int[] hist = new int[256];
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      bright = int(brightness(get(x, y)));
      hist[bright]++;
    }
  }
  int histMax = max(hist);
  stroke(255);
  //spacing out histogram bars displays histogram of brightness at 5 pixel intervals
  for (int i=0; i< img.width; i+=5) {
    int histX = int(map(i, 0, img.width, 0, 255));
    int histY = int(map(hist[histX], 0, histMax, img.height, 0));
    line(i, img.height, i, histY);
  }
}