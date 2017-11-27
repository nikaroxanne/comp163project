class Gaussian {
  int x,y, matrixsize;
  PImage img;
  
  float Gaussian(int _x, int _y, int _matrixsize, PImage _img) {
    x = _x;
    y = _y;
    matrixsize = _matrixsize;
    img = _img;
    
    float gaussian = 0.0;
    float gaussianPix= 0.0;
    float gaussExponent = 0.0;
    float eulerVal = 0.0;
    float sigma = 1.0;
    int offset = matrixsize/2;
    for (int i=-2; i<=2; i++) {
      for (int j=-2; j<=2; j++) {
        int xloc = (x+i) - offset;
        int yloc = (y-j) - offset;
        int loc = xloc + img.width*yloc;
        //int mid = x + y*img.width;
        loc = constrain(loc, 0, img.pixels.length-1);
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

  float stDev(int x, int y, int matrixsize, PImage img) {
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
        stDev += (sq((brightness(img.pixels[loc])) - (averageGradient(x, y, matrixsize, img))));
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
}
