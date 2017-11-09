import gab.opencv.*;
import java.awt.Rectangle;

//final int SCALEFACTOR = 1;
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

void setup() {
  src = loadImage("nikanew.jpg");
  src.resize(0,600);
  boxPoints = new ArrayList();
  size(600, 600);
  //int width = src.width;
  //int height = src.height;
  //float scaleVal = (DISPLAYWIDTH)/(width);
  //println(scaleVal);
  opencv = new OpenCV(this, src);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  faces = opencv.detect();
  checkFaces(faces);
  state = new State();
  //src.resize(0,600);
  facePoints = new ArrayList();
  edges = new ArrayList();

  //boxPoints = new ArrayList();
  //destination = createImage(img.width, img.height, RGB);
  //img.loadPixels();
  //destination.loadPixels();
  //int height = img.height;
  //int width = img.width;
  //float sobelValue = 0.0;
  //float gaussian = 0.0;
  //float brightnessGradient = 0.0;
  //int matrixsize = matrixH.length; 
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
  image(src, 0, 0); 
  for (BoundingBox boxPoint : boxPoints) {
    boxPoint.draw();
  }
  update();
  
  //saveFrame("offSorbelpic.jpg");
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

void update() {
  switch(state.state) {
  case BEGIN:
    text("Click here to start", 5, width);
    break;
  case GRAY:
    image(img, 0, 0);
    filter(BLUR, 50);
    break;
  case GAUSSIAN:
    //int gaussLength = 5;
    histogram(img);
    //img.loadPixels();
    //destination.loadPixels();


    //destination.updatePixels();
    //image(destination, 0, 0);
    break;
  //case FACEDETECT:
  //  PImage gaussImage = loadImage("nikanew.jpg");
  //  //size(1200,1200);
  //  opencv = new OpenCV(this, gaussImage);
  //  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  //  scale(0.25);
  //  image(destination, 0, 0); 
  //  faces = opencv.detect();
  //  image(opencv.getInput(), 0, 0);
  //  noFill();
  //  stroke(0, 255, 0);
  //  strokeWeight(3);
  //  for (BoundingBox boxPoint : boxPoints) {
  //    boxPoint.getFaces(faces);
  //    boxPoint.boxSizeCheck();
  //    boxPoint.draw();
  //  }
  //  break;
  //case SOBEL:
  //  break;
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

void mouseClicked() {
  switch(state.state) {
  case BEGIN:
    state.next();
  case GRAY:
    state.next();
  case GAUSSIAN:
    state.next();
  //case FACEDETECT:
  //  state.next();
  //case SOBEL:
  //  break;
  }
}

void histogram(PImage img) {
  int bright = 0;
  int[] hist = new int[256];
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      //float gaussian = 0.0;
      bright = int(brightness(get(x, y)));
      hist[bright]++;
      //gaussian = Gaussian(x, y, gaussLength, matrixGauss, img);
    }
  }
  int histMax = max(hist);
  stroke(255);
  for (int i=0; i< img.width; i++) {
    int histX = int(map(i, 0, img.width, 0, 255));
    int histY = int(map(hist[histX], 0, histMax, img.height, 0));
    line(i, img.height, i, histY);
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