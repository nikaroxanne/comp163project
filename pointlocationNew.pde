float [][] matrix = { { 1/9, 1/9, 1/9},
                      { 1/9, 1/9, 1/9},
                      { 1/9, 1/9, 1/9}};


PImage img;
//PImage destination;
ArrayList<Point> points;

void setup(){
  size(270,480);
  img = loadImage("nika2.JPG");
 // destination = createImage(img.width, img.height, RGB);
  points = new ArrayList<Point>();
}
void draw(){
  background(0);
  image(img, 0, 0);
  loadPixels();
  int height = img.height;
  int width = img.width;
  float diff = 0.0;
  int matrixsize = matrix.length;
  for (int x=0; x < width; x++){
    for (int y=0; y < height; y++){
      //int pix = x + y*img.width;
      diff = convolution(x,y,matrix,matrixsize,img);
      //println(diff);
      if ((diff > 25) && (diff < 40)) {
        points.add(new Point(x,y));
      }
    }
  }
  updatePixels();
  for(Point point: points){
    point.display();
  }
}


float convolution(int x, int y, float[][] matrix, int matrixsize, PImage img){
  float brightnessavg = 0.0;
  int offset = matrixsize/2;
  for (int i=0; i<matrixsize; i++){
    for(int j=0; j<matrixsize; j++){
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
  brightnessavg = constrain(brightnessavg,0,255);
  return brightnessavg;
}

class Point {
  float x, y;
 
 Point(float _x, float _y){
   x = _x;
   y = _y;
 }
  void display() {
   noStroke();
   fill(0,0,0);
   triangle(x, y, x+5, y+5, x+5, y); 
 }
 
}