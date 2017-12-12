/*trace:
sum of elements on matrix diagonal
*/

import gab.opencv.*;
import java.awt.Rectangle;

final int DISPLAYWIDTH = 600;
final int DISPLAYHEIGHT = 600;
final int STATETIMEMAX = 100;


float [][] matrixH = { {-1, 0, 1}, 
  { -2, 0, 2}, 
  { -1, 0, 1}};
float [][] matrixV = { {1, 2, 1}, 
  { 0, 0, 0}, 
  { -1, -2, -1}};
float [][] matrixB = { {1/9, 1/9, 1/9}, 
  { 1/9, 1/9, 1/9}, 
  { 1/9, 1/9, 1/9}};

float [][] matrixGauss = { {1/25, 1/25, 1/25, 1/25, 1/25}, 
  {1/25, 1/25, 1/25, 1/25, 1/25}, 
  {1/25, 1/25, 1/25, 1/25, 1/25}, 
  {1/25, 1/25, 1/25, 1/25, 1/25}, 
  {1/25, 1/25, 1/25, 1/25, 1/25}};



PImage src, img, destination;
ArrayList<FacePoint> facePoints;
ArrayList<Edge> edges;
ArrayList<BoundingBox> boxPoints;
Rectangle[] faces;
OpenCV opencv;

float sobelValue = 0.0;
float brightnessGradient = 0.0;
int matrixsize = matrixH.length; 

/*************Function declarations****************/
/*Bitmap loadImage(FILE *img); equivalent to setup */
/*void writeImage(FILE *image, Bitmap bitmap); equivalent to draw */
/*void skeleton(int col, int row, Bitmap bitmap, int pixel);
 void writePixels(int col, int row, Bitmap bitmap, int pixel);
 void push_point_neighbors();
 void push_borders();
 void check_pixel_push_final(); */


/**************************************************/
//int scale = 4;

void setup() {
  img = loadImage("nikanew.jpg");
  src = loadImage("nikanew.jpg");
  src.resize(0,600);
  boxPoints = new ArrayList();
  size(600, 600);
  opencv = new OpenCV(this, src);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  faces = opencv.detect();
  checkFaces(faces);
  //src.resize(0,600);
  facePoints = new ArrayList();
  edges = new ArrayList();
  destination = createImage(img.width, img.height, RGB);
}

void makeEdges() {
  for (int i = facePoints.size() -1; i >= 0; i--) {
    FacePoint facePoint1 = facePoints.get(i);
    for (int j= facePoints.size() -2; j>=1; j--) {
      FacePoint facePoint2 = facePoints.get(j);
      Edge edge = new Edge(facePoint1, facePoint2);
      edges.add(edge);
    }
  }
}

void draw() {
  background(0);
  image(src, 0,0); 
  for (BoundingBox boxPoint : boxPoints) {
    boxPoint.draw();
  }
  img.loadPixels();
  destination.loadPixels();
  update();
  image(destination, 0, 0);
  
}

void update() {
  for (int x = 0; x < DISPLAYWIDTH; x++) {
   for (int y = 0; y < DISPLAYHEIGHT; y++) {
   int pix = x + y*img.width;
   sobelValue = sobel(x, y, matrixH, matrixV, matrixsize, src);
   destination.pixels[pix] = color(sobelValue);
   destination.updatePixels();
   }
  }
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

void mousePressed() {
    save("sobelCheck####.jpg");
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

void checkFaces(Rectangle[] faces){
 for(int i=0; i < faces.length; i++){
    int facewidth = (faces[i].width);
    int faceheight = (faces[i].height);
    int faceX = (faces[i].x);
    int faceY = (faces[i].y);
    if ((faceheight > 100) && (facewidth > 100)) {
      boxPoints.add(new BoundingBox(faceX,faceY, facewidth,faceheight));
    }
  }
}
