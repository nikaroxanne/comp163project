float [][] matrix = { { 1/9, 1/9, 1/9},
                      { 1/9, 1/9, 1/9},
                      { 1/9, 1/9, 1/9}};


PImage img;
PImage destination;

void setup(){
 size(270,480);
 img = loadImage("nika2.JPG");
 destination = createImage(img.width, img.height, RGB);
}

void draw(){
  background(0);
  image(img, 0, 0);
  img.loadPixels();
  destination.loadPixels();
  int height = img.height;
  int width = img.width;
  float diff = 0.0;
  int matrixsize = matrix.length;
  for (int x=0; x < width; x++){
    for (int y=0; y < height; y++){
      int pix = x + y*img.width;
      diff = convolution(x,y,matrix,matrixsize,img);
      //println(diff);
      if ((diff > 25) && (diff < 50)) {
        destination.pixels[pix] = color(255);
      } else {
        destination.pixels[pix] = color(0);
      }
      destination.updatePixels();
      image(destination, 0, 0);
        //noStroke();
        //fill(0,0,0);
        //ellipse(x, y, 5, 5);
      //}
    }
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