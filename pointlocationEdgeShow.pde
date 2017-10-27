import gab.opencv.*;
import java.awt.Rectangle;

final int SCALEFACTOR = 2;
final int DISPLAYWIDTH = 600;
final int DISPLAYHEIGHT = 600;
State state;

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
//PImage destination;
ArrayList<FacePoint> facePoints;
ArrayList<Edge> edges;
ArrayList<BoundingBox> boxPoints;
Rectangle[] faces;
OpenCV opencv;

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

void setup(){
  //src = loadImage("nikanew.jpg");
  size(600,600);
  
  //opencv = new OpenCV(this, src);
  //opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  //faces = opencv.detect();
  //scale(0.25);
  //image(destination, 0, 0); 
  //image(opencv.getInput(),0,0);
  //int boxX, boxY, boxWidth, boxHeight;
  //for (BoundingBox boxPoint: boxPoints){
  //  boxPoint.showPoints();
  //}
  //for(int i=0; i < faces.length; i++){
  //  int facewidth = (faces[i].width)/SCALEFACTOR;
  //  int faceheight = (faces[i].height)/SCALEFACTOR;
  //  int faceX = (faces[i].x)/SCALEFACTOR;
  //  int faceY = (faces[i].y)/SCALEFACTOR;
  //  //boxPoints.add(new BoundingBox(boxX, boxY, boxWidth, boxHeight));
  //  //int boxPassed = (boxPoints.boxSizeCheck(facewidth, faceheight));
  //  // if (boxPassed == 1) {
  //  boxPoints.add(new BoundingBox(faceX, faceY, facewidth, faceheight));
  //  println(faces[i].x);
  //  println(faces[i].y);
  //  println(faces[i].width);
  //  println(faces[i].height);
  //}
  
  state = new State();
  img = loadImage("nikanew.jpg");
  facePoints = new ArrayList();
  edges = new ArrayList();
  boxPoints = new ArrayList();
  boxPoints = new ArrayList();
  destination = createImage(img.width, img.height, RGB);
  //img.loadPixels();
  //destination.loadPixels();
  //int height = img.height;
  //int width = img.width;
  //float sobelValue = 0.0;
  //float gaussian = 0.0;
  //float brightnessGradient = 0.0;
  //int matrixsize = matrixH.length; 
  /*
  BoundingBox boundingBox = boxPoints.get(1);
  int boxWidth = boundingBox.width; 
  int boxHeight = boundingBox.height;
  int boxXStart = boundingBox.x;
  int boxYStart = boundingBox.y;
  //int boxXStart = constrain(faces[0].x, 0, img.width);
  //int boxYStart = constrain(faces[0].y, 0, img.height); 
  int boxXEnd = boxXStart + boxWidth;
  int boxYEnd = boxYStart + boxHeight;
  //constrain(boxXEnd, boxXStart + boxWidth, img.width);
  //constrain(boxYEnd, boxYStart + boxHeight, img.height);
  println(boxWidth);
  println(boxHeight);
  println(boxXStart);
  println(boxYStart);
  println(boxXEnd);
  println(boxYEnd);
  */
  /*
  int gaussLength = 5;
  for (int x = 0; x <= img.width; x++) {
    for (int y = 0; y < img.height ; y++) {
      int pix = x + y*img.width;
      gaussian = Gaussian(x,y, gaussLength, img);
      destination.pixels[pix] = color(gaussian);
      //color initial = img.pixels[pix];
      //color postGauss = gaussian * initial;
      //sobelValue = sobel(x, y, matrixH, matrixV, matrixsize, img);
      //destination.pixels[pix] = color(sobelValue);
      //brightnessGradient = averageGradient(x,y, matrixsize, destination);
      //destination.pixels[pix] = color(brightnessGradient);
      //if ((brightnessGradient > 90) && (brightnessGradient < 100)) {
      //  destination.pixels[pix] = color(255);
      //  facePoints.add(new FacePoint(x, y, brightnessGradient));
      //} else {
      //  destination.pixels[pix] = color(0);
      //}
      destination.updatePixels();
      //makeEdges();
      
    }
  }*/
}

void makeEdges(){
    for (int i = facePoints.size() -1; i >= 0; i--){
      FacePoint facePoint1 = facePoints.get(i);
      for (int j= facePoints.size() -2; j>=1; j--){
        FacePoint facePoint2 = facePoints.get(j);
        Edge edge = new Edge(facePoint1, facePoint2);
        edges.add(edge);
      }  
    }
 }

void draw() {
  background(0);
  scale(0.25);
  image(img, 0, 0); 
  update();
  //image(opencv.getInput(),0,0);
  
  
  //noFill();
  //stroke(0,255,0);
  //strokeWeight(3);
  //for (BoundingBox boundingBox: boxPoints){
  //    boundingBox.draw();
  //}
  //saveFrame("offSorbelpic.jpg");
  //int boxX, boxY, boxWidth, boxHeight = 0;
  //for(int i=0; i < faces.length; i++){
  //  boxX = faces[i].x;
  //  boxY = faces[i].y; 
  //  boxWidth = faces[i].width; 
  //  boxHeight = faces[i].height;
  //  boxPoints.add(new BoundingBox(boxX, boxY, boxWidth, boxHeight));
  //  //rect(faces[i].x,faces[i].y, faces[i].width, faces[i].height);
  //  //print(faces[i].x);
  //}
  //makeEdges();
  //for (FacePoint facePoint: facePoints){
  //  facePoint.showPoints();
  //}
  /*for (Edge edge: edges){
    edge.draw();
  }*/
  //noStroke();
  //fill(0,0,0);
  //ellipse(x, y, 5, 5);
  //}
}

void update(){
 switch(state.state){
  case BEGIN:
    text("Click here to start", 5 , width);
    break;
  case GRAY:
    image(img, 0,0);
    filter(GRAY);
    break;
  case GAUSSIAN:
    //int gaussLength = 3;
    img.loadPixels();
    destination.loadPixels();
    for (int y = 1; y < img.height -1; y++) {
      for (int x = 1; x < img.width -1 ; x++) {
        float gaussian = 0.0;
        gaussian = Gaussian(y, x, img);
        int pix = x + y*img.width;
        destination.pixels[pix] = color(gaussian);
        //color initial = img.pixels[pix];
        //color postGauss = gaussian * initial;
        //destination.pixels[pix] = color(brightnessGradient);
        //destination.updatePixels();
      }
    }
    destination.updatePixels();
    image(destination, 0, 0);
    break;
  case FACEDETECT:
    PImage gaussImage = loadImage("nikanew.jpg");
    //size(1200,1200);
    opencv = new OpenCV(this, gaussImage);
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
    scale(0.25);
    image(destination, 0, 0); 
    faces = opencv.detect();
    image(opencv.getInput(),0,0);
    noFill();
    stroke(0,255,0);
    strokeWeight(3);
    for(BoundingBox boxPoint: boxPoints){
      boxPoint.getFaces(faces);
      boxPoint.boxSizeCheck();
      boxPoint.draw();
    }
    break;
  case SOBEL:
    break;
  /*case CORNER:
  case LANDMARKS:
  case SORT: 
  case CONVEXHULL:
  case MONOTONETRI:
  case FLIP:
  case DELAUNAY:
  case VORONOI:*/
 }
}

void mouseClicked(){
  switch(state.state){
    case BEGIN:
      state.next();
    case GRAY:
      state.next();
    case GAUSSIAN:
      state.next();
    case FACEDETECT:
      state.next();
    case SOBEL:
      break;
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

float Gaussian(int y, int x, PImage img){
  float gaussian = 0.0;
 //float gaussianPix= 0.0;
 //float gaussExponent = 0.0;
 //float eulerVal = 0.0;
 //float sigma = 1.0;
  //int offset = matrixsize/2;
  for (int ky=-1; ky<=1; ky++) {
    for (int kx=-1; kx<=1; kx++) {
      int pos = (y+ky)*img.width + (x +kx);
      float val = red(img.pixels[pos]);
      gaussian += matrixB[ky+1][kx +1] * val;
    }
  }
  return gaussian;
}
  /*
      //int xloc = (x+i) - offset;
      //int yloc = (y-j) - offset;
      //int loc = xloc + img.width*yloc;
      //int mid = x + y*img.width;
      //loc = constrain(loc, 0, img.pixels.length-1);
      //brightnessavg += abs((brightness(img.pixels[mid]))- ((brightness(img.pixels[loc]))));
      //print(brightnessavg);
      gaussExponent = (-((sq(brightness(img.pixels[loc]))) / ((2*sq(sigma)))));
      //gaussExponent = (-((sq(brightness(img.pixels[loc]))) / ((2*sq(stDev(x,y,matrixsize,img))))));
      //println(gaussExponent);
      eulerVal = exp(gaussExponent);
      //println(eulerVal);
      gaussian = (1 / (2* PI * sq(sigma))) * eulerVal;
      //gaussian = (1 / (2* PI * sq(stDev(x,y,matrixsize,img)))) * eulerVal;
      //println(gaussian);
      matrixGauss[i][j] = gaussian;
      gaussianPix += img.pixels[loc]*matrixGauss[i][j];
      //println(gaussianPix);
    }
  }
  gaussianPix = constrain(gaussian, 0, 255);
  println(gaussianPix);
  return gaussianPix; 
}
*/

float stDev(int x, int y, int matrixsize, PImage img){
 float stDev = 0.0;
  int offset = matrixsize/2;
  for (int i=0; i<matrixsize; i++) {
    for (int j=0; j<matrixsize; j++) {
      int xloc = (x+i) - offset;
      int yloc = (y-j) - offset;
      int loc = xloc + img.width*yloc;
      //int mid = x + y*img.width;
      loc = constrain(loc, 0, img.pixels.length-1);
      //brightnessavg += abs((brightness(img.pixels[mid]))- ((brightness(img.pixels[loc]))));
      //print(brightnessavg);
      stDev += (sq((brightness(img.pixels[loc])) - (averageGradient(x,y,matrixsize,img))));
    }
  }
  stDev /= 24.00;
  stDev = sqrt(stDev);
  //println(stDev);
  stDev = constrain(stDev, 0, 255);
  return stDev; 
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