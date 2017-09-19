float [][] matrix = { {1/9, 1/9, 1/9}, 
  { 1/9, 1/9, 1/9}, 
  { 1/9, 1/9, 1/9}};


PImage img;
PImage destination;
ArrayList<FacePoints> facePoints;

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
  destination = createImage(img.width, img.height, RGB);
  img.loadPixels();
  destination.loadPixels();
  int height = img.height;
  int width = img.width;
  float diff = 0.0;
  int matrixsize = 3;
  //int matrixsize = matrix.length;
  for (int x=0; x < width; x++) {
    for (int y=0; y < height; y++) {
      int pix = x + y*img.width;
      diff = convolution(x, y, matrix, matrixsize, img);
      //println(diff);
      destination.pixels[pix] = color(diff);
      if ((diff > 25) && (diff < 50)) {
        destination.pixels[pix] = color(255);
      } else {
        destination.pixels[pix] = color(0);
      }
      destination.updatePixels();
    }
  }
}

void draw() {
  background(0);
  image(destination, 0, 0);
  //noStroke();
  //fill(0,0,0);
  //ellipse(x, y, 5, 5);
  //}
}

float convolution(int x, int y, float[][] matrix, int matrixsize, PImage img) {
  float brightnessavg = 0.0;
  int offset = matrixsize/2;
  for (int i=0; i<matrixsize; i++) {
    for (int j=0; j<matrixsize; j++) {
      int xloc = (x+i) - offset;
      int yloc = (y-j) - offset;
      int loc = xloc + img.width*yloc;
      int mid = x + y*img.width;
      loc = constrain(loc, 0, img.pixels.length-1);
      //brightnessavg += (brightness(img.pixels[loc])*matrix[i][j]);
      //brightnessavg += (abs((brightness(img.pixels[mid]))- ((brightness(img.pixels[loc]))))*matrix[i][j]);
      brightnessavg += abs((brightness(img.pixels[mid]))- ((brightness(img.pixels[loc]))));
      print(brightnessavg);
    }
  }
  brightnessavg /= 9.00;
  brightnessavg = constrain(brightnessavg, 0, 255);
  return brightnessavg;
}