float [][] matrixH = { {-1, 0, 1}, 
  { -2, 0, 2}, 
  { -1, 0, 1}};
float [][] matrixV = { {1, 2, 1}, 
  { 0, 0, 0}, 
  { -1, -2, -1}};


PImage img;
PImage destination;
ArrayList<FacePoint> facePoints;
ArrayList<Edge> edges;

/*************Function declarations****************/
/*Bitmap loadImage(FILE *img); equivalent to setup */
/*void writeImage(FILE *image, Bitmap bitmap); equivalent to draw */
/*void skeleton(int col, int row, Bitmap bitmap, int pixel);
 void writePixels(int col, int row, Bitmap bitmap, int pixel);
 void push_point_neighbors();
 void push_borders();
 void check_pixel_push_final(); */


/**************************************************/



void setup() {
  size(270, 480);
  img = loadImage("nika2.JPG");
  facePoints = new ArrayList();
  edges = new ArrayList();
  destination = createImage(img.width, img.height, RGB);
  img.loadPixels();
  destination.loadPixels();
  int height = img.height;
  int width = img.width;
  float sobelValue = 0.0;
  float brightnessGradient = 0.0;
  int matrixsize = matrixH.length;
  for (int x=0; x < width; x++) {
    for (int y=0; y < height; y++) {
      int pix = x + y*img.width;
      sobelValue = convolution1(x, y, matrixH, matrixV, matrixsize, img);
      destination.pixels[pix] = color(sobelValue);
      brightnessGradient = averageGradient(x,y, matrixsize, destination);
      destination.pixels[pix] = color(brightnessGradient);
      if ((brightnessGradient > 110) && (brightnessGradient < 130)) {
        destination.pixels[pix] = color(255);
        facePoints.add(new FacePoint(x, y, brightnessGradient));
      } else {
        destination.pixels[pix] = color(0);
      }
      destination.updatePixels();
      //makeEdges();
    }
  }
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
  image(destination, 0, 0); 
  //makeEdges();
  for (FacePoint facePoint: facePoints){
    facePoint.showPoints();
  }
  /*for (Edge edge: edges){
    edge.draw();
  }*/
  //noStroke();
  //fill(0,0,0);
  //ellipse(x, y, 5, 5);
  //}
}

float convolution1(int x, int y, float[][] matrixH, float[][] matrixV, int matrixsize, PImage img) {
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
      int mid = x + y*img.width;
      loc = constrain(loc, 0, img.pixels.length-1);
      brightnessavg += abs((brightness(img.pixels[mid]))- ((brightness(img.pixels[loc]))));
      //print(brightnessavg);
    }
  }
  brightnessavg /= 9.00;
  brightnessavg = constrain(brightnessavg, 0, 255);
  return brightnessavg;
}