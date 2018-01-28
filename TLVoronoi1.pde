import toxi.geom.*;
import toxi.geom.mesh2d.*;

import toxi.util.*;
import toxi.util.datatypes.*;

import toxi.processing.*;

import gab.opencv.*;

import java.awt.Rectangle;
import java.util.Collections;
import java.util.Comparator;


final int SCALEFACTOR = 1;
final int DISPLAYWIDTH = 600;
final int DISPLAYHEIGHT = 600;
int matrixSize = 3;
float xMin, yMin, xMax, yMax;
boolean isRightTurn = false;
boolean animate = true;
boolean saveFrames = true;
int maxFrames = 10;

PImage src, img, destination, imgMask;
ArrayList<BoundingBox> boxPoints;
ArrayList<FacePoint> facePoints;
ArrayList<FacePoint> hullPoints;

ArrayList<Edge> edges;
Rectangle[] faces;
OpenCV opencv;

ToxiclibsSupport gfx;
Voronoi voronoi;
SutherlandHodgemanClipper rectClipper;
Rect bounds;
Vec2D voronoiCentroid;
//HashMap< > = new HashMap<>();
FloatDict VoronoiColours;

FacePoint YMIN;
float YMINY, YMINX;

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
  addFaces();

  gfx = new ToxiclibsSupport(this);
  voronoi = new Voronoi();

  BoundingBox boxMain = boxPoints.get(0);
  int rectX = boxMain.x;
  int rectY = boxMain.y;
  int rectWidth = boxMain.width;
  int rectHeight = boxMain.height;

  bounds = new Rect(rectX, rectY, rectWidth, rectHeight);
  rectClipper = new SutherlandHodgemanClipper(bounds);
  edges = new ArrayList();
  VoronoiColours = new FloatDict();
}

void draw() {
  background(0);
  image(src, 0, 0);
  //filter(GRAY);
  
  /*
  for (BoundingBox boxPoint : boxPoints) {
    boxPoint.draw();
  }
  */


  for (FacePoint facePoint : facePoints) {
    //facePoint.showPoint();
    voronoi.addPoint(new Vec2D(facePoint.getXCoord(), facePoint.getYCoord()));
  }
  
  for (Polygon2D polygon : voronoi.getRegions() ) {
    float r = 0.0;
    float g = 0.0;
    float b = 0.0;
    float bright = 0.0;
    int xLoc, yLoc, loc;
    gfx.polygon2D( rectClipper.clipPolygon(polygon));
    voronoiCentroid = polygon.getCentroid();
    float xLocInitial = voronoiCentroid.x(); 
    float yLocInitial = voronoiCentroid.y();
    xLoc = int(xLocInitial);
    yLoc = int(yLocInitial);
    //println(xLoc);
    //println(yLoc);
    loc = xLoc + (yLoc*src.width);
    r = red(src.pixels[loc]);
    g = green(src.pixels[loc]);
    b = green(src.pixels[loc]);
    bright = brightness(src.pixels[loc]);
    println(r, g, b, bright);
    //noStroke();
    stroke(255,255,255);
    fill(r,g,b,bright);
    //noFill();
    //fill(255, 0, 255, 15); 
    //strokeWeight(1);
  }
  
  
  for (Vec2D faceLandmark : voronoi.getSites() ) {
    
    //noStroke();
    stroke(255,255,255);
    //noFill();
    ellipse(faceLandmark.x, faceLandmark.y, 3, 3);
    fill(255,255,255);
    //fill(255, 0, 255, 15); 
    //strokeWeight(1);
  }


  beginShape(TRIANGLES);
  for (Triangle2D delTri : voronoi.getTriangles() ) {
    gfx.triangle(delTri);
    stroke(0);
    noFill();
    //fill(255,0,0,63);
    strokeWeight(1);
  }
  endShape();

}


void mousePressed() {
  //save("voronoi-####.jpg");
  addPoints(mouseX, mouseY);
}

void keyPressed() {
  switch(key) {
  case '1':
    saveFrame("steiner1.jpg");
    break;
  case '2':
    saveFrame("steiner2.jpg");
    break;
  case '3':
    saveFrame("steiner3.jpg");
    break;
  }
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

void addFaces() {
  facePoints.add(new FacePoint(293, 268, 165.0));
  facePoints.add(new FacePoint(307, 317, 223.0));
  facePoints.add(new FacePoint(321, 341, 225.0));
  facePoints.add(new FacePoint(333, 369, 130.0));
  facePoints.add(new FacePoint(357, 401, 230.0));
  facePoints.add(new FacePoint(381, 416, 125.0));
  facePoints.add(new FacePoint(416, 426, 224.0));
  facePoints.add(new FacePoint(456, 413, 104.0));
  facePoints.add(new FacePoint(490, 379, 162.0));
  facePoints.add(new FacePoint(516, 329, 36.0));
  facePoints.add(new FacePoint(518, 297, 162.0));
  facePoints.add(new FacePoint(514, 256, 34.0));
  facePoints.add(new FacePoint(517, 217, 168.0));
  facePoints.add(new FacePoint(312, 130, 151.0));
  facePoints.add(new FacePoint(365, 98, 173.0));
  facePoints.add(new FacePoint(422, 98, 230.0));
  facePoints.add(new FacePoint(307, 232, 214.0));
  facePoints.add(new FacePoint(309, 216, 164.0));
  facePoints.add(new FacePoint(318, 227, 198.0));
  facePoints.add(new FacePoint(340, 213, 244.0));
  facePoints.add(new FacePoint(342, 229, 246.0));
  facePoints.add(new FacePoint(371, 225, 192.0));
  facePoints.add(new FacePoint(406, 222, 183.0));
  facePoints.add(new FacePoint(434, 193, 210.0));
  facePoints.add(new FacePoint(450, 186, 71.0));
  facePoints.add(new FacePoint(435, 206, 133.0));
  facePoints.add(new FacePoint(455, 197, 105.0));
  facePoints.add(new FacePoint(482, 200, 226.0));
  facePoints.add(new FacePoint(388, 276, 96.0));
  facePoints.add(new FacePoint(378, 282, 186.0));
  facePoints.add(new FacePoint(405, 279, 117.0));
  facePoints.add(new FacePoint(383, 299, 223.0));
  facePoints.add(new FacePoint(382, 311, 205.0));
  facePoints.add(new FacePoint(374, 293, 149.0));
  facePoints.add(new FacePoint(394, 289, 170.0));
  facePoints.add(new FacePoint(397, 308, 196.0));
  facePoints.add(new FacePoint(410, 297, 186.0));
  facePoints.add(new FacePoint(423, 305, 199.0));
  facePoints.add(new FacePoint(422, 287, 134.0));
  facePoints.add(new FacePoint(338, 236, 226.0));
  facePoints.add(new FacePoint(341, 245, 254.0));
  facePoints.add(new FacePoint(335, 252, 207.0));
  facePoints.add(new FacePoint(345, 259, 185.0));
  facePoints.add(new FacePoint(335, 257, 111.0));
  facePoints.add(new FacePoint(351, 252, 223.0));
  facePoints.add(new FacePoint(350, 244, 251.0));
  facePoints.add(new FacePoint(365, 250, 173.0));
  facePoints.add(new FacePoint(324, 256, 68.0));
  facePoints.add(new FacePoint(424, 242, 245.0));
  facePoints.add(new FacePoint(436, 230, 208.0));
  facePoints.add(new FacePoint(445, 223, 186.0));
  facePoints.add(new FacePoint(456, 225, 232.0));
  facePoints.add(new FacePoint(437, 237, 230.0));
  facePoints.add(new FacePoint(447, 244, 252.0));
  facePoints.add(new FacePoint(455, 235, 224.0));
  facePoints.add(new FacePoint(447, 234, 255.0));
  facePoints.add(new FacePoint(469, 231, 211.0));
  facePoints.add(new FacePoint(444, 216, 188.0));
  facePoints.add(new FacePoint(401, 329, 177.0));
  facePoints.add(new FacePoint(411, 324, 246.0));
  facePoints.add(new FacePoint(394, 331, 234.0));
  facePoints.add(new FacePoint(385, 345, 161.0));
  facePoints.add(new FacePoint(370, 356, 242.0));
  facePoints.add(new FacePoint(425, 339, 37.0));
  facePoints.add(new FacePoint(447, 344, 191.0));
  facePoints.add(new FacePoint(404, 342, 84.0));
  facePoints.add(new FacePoint(406, 350, 86.0));
  facePoints.add(new FacePoint(419, 342, 99.0));
  facePoints.add(new FacePoint(421, 349, 69.0));
  facePoints.add(new FacePoint(390, 349, 68.0));
  facePoints.add(new FacePoint(392, 354, 200.0));
  facePoints.add(new FacePoint(392, 366, 121.0));
  facePoints.add(new FacePoint(411, 367, 124.0));
  facePoints.add(new FacePoint(425, 362, 233.0));
  facePoints.add(new FacePoint(438, 353, 214.0));
  facePoints.add(new FacePoint(384, 365, 118.0));
  
  /*steiner vertices*/
  facePoints.add(new FacePoint(379, 173, 30.0));
  facePoints.add(new FacePoint(384, 240, 239.0));
  facePoints.add(new FacePoint(375, 256, 119.0));
  facePoints.add(new FacePoint(401, 253, 49.0));
  facePoints.add(new FacePoint(383, 233, 217.0));
  facePoints.add(new FacePoint(392, 232, 214.0));
  facePoints.add(new FacePoint(384, 221, 180.0));
  facePoints.add(new FacePoint(319, 180, 191.0));
  facePoints.add(new FacePoint(352, 139, 192.0));
  facePoints.add(new FacePoint(413, 136, 170.0));
  facePoints.add(new FacePoint(447, 155, 230.0));
  facePoints.add(new FacePoint(480, 341, 128.0));
  facePoints.add(new FacePoint(470, 281, 246.0));
  facePoints.add(new FacePoint(342, 310, 202.0));
  facePoints.add(new FacePoint(353, 362, 161.0));
  facePoints.add(new FacePoint(463, 121, 239.0));
  facePoints.add(new FacePoint(495, 156, 233.0));
  facePoints.add(new FacePoint(297, 158, 238.0));
  facePoints.add(new FacePoint(284, 218, 170.0));
  facePoints.add(new FacePoint(385, 255, 97.0));
  facePoints.add(new FacePoint(412, 382, 171.0));
  
  /* hard-coded ArrayList of drawn FacePoints */
  /*
  facePoints.add(new FacePoint(322, 258, 6.32));
  facePoints.add(new FacePoint(421, 242, 58.4)); 
  facePoints.add(new FacePoint(435, 231, 22.16));
  facePoints.add(new FacePoint(441, 223, 28.08));
  facePoints.add(new FacePoint(440, 240, 33.64));
  facePoints.add(new FacePoint(448, 243, 49.52));
  facePoints.add(new FacePoint(454, 232, 24.88));
  facePoints.add(new FacePoint(452, 226, 3.92));
  facePoints.add(new FacePoint(444, 232, 69.76));
  facePoints.add(new FacePoint(465, 232, 13.36));
  facePoints.add(new FacePoint(364, 250, 62.84));
  facePoints.add(new FacePoint(322, 258, 6.32));
  facePoints.add(new FacePoint(334, 250, 27.8));
  facePoints.add(new FacePoint(336, 259, 65.4));
  facePoints.add(new FacePoint(345, 257, 17.72));
  facePoints.add(new FacePoint(353, 250, 33.72));
  facePoints.add(new FacePoint(351, 246, 15.36));
  facePoints.add(new FacePoint(341, 244, 21.64));
  facePoints.add(new FacePoint(345, 251, 60.12));
  facePoints.add(new FacePoint(370, 227, 68.4));
  facePoints.add(new FacePoint(402, 223, 71.52));
  facePoints.add(new FacePoint(431, 207, 52.04));
  facePoints.add(new FacePoint(450, 197, 58.04));
  facePoints.add(new FacePoint(449, 187, 81.92));
  facePoints.add(new FacePoint(426, 200, 67.08));
  facePoints.add(new FacePoint(482, 201, 66.56));
  facePoints.add(new FacePoint(329, 228, 65.72));
  facePoints.add(new FacePoint(330, 218, 46.08));
  facePoints.add(new FacePoint(311, 216, 71.4));
  facePoints.add(new FacePoint(308, 225, 62.56));
  facePoints.add(new FacePoint(291, 240, 60.68));
  facePoints.add(new FacePoint(292, 300, 53.32));
  facePoints.add(new FacePoint(318, 330, 50.64));
  facePoints.add(new FacePoint(330, 366, 37.28));
  facePoints.add(new FacePoint(342, 382, 47.48));
  facePoints.add(new FacePoint(375, 414, 39.72));
  facePoints.add(new FacePoint(416, 425, 25.88));
  facePoints.add(new FacePoint(460, 406, 42.52));
  facePoints.add(new FacePoint(473, 396, 38.4));
  facePoints.add(new FacePoint(493, 377, 45.88));
  facePoints.add(new FacePoint(510, 352, 59.04));
  facePoints.add(new FacePoint(514, 322, 62.04));
  facePoints.add(new FacePoint(520, 279, 48.04));
  facePoints.add(new FacePoint(528, 250, 70.28));
  facePoints.add(new FacePoint(515, 208, 25.88));
  facePoints.add(new FacePoint(380, 300, 55.84));
  facePoints.add(new FacePoint(395, 304, 60.04));
  facePoints.add(new FacePoint(395, 304, 60.04));
  facePoints.add(new FacePoint(407, 293, 68.64));
  facePoints.add(new FacePoint(407, 293, 68.64));
  facePoints.add(new FacePoint(379, 292, 68.12));
  facePoints.add(new FacePoint(388, 283, 88.2));
  facePoints.add(new FacePoint(403, 289, 77.16));
  facePoints.add(new FacePoint(393, 293, 84.96));
  facePoints.add(new FacePoint(377, 310, 75.88));
  facePoints.add(new FacePoint(419, 304, 70.16));
  facePoints.add(new FacePoint(403, 333, 76.6));
  facePoints.add(new FacePoint(413, 327, 83.0));
  facePoints.add(new FacePoint(394, 332, 78.24));
  facePoints.add(new FacePoint(394, 332, 78.24));
  facePoints.add(new FacePoint(405, 343, 48.16));
  facePoints.add(new FacePoint(408, 350, 64.12));
  facePoints.add(new FacePoint(396, 342, 49.88));
  facePoints.add(new FacePoint(414, 341, 50.2));
  facePoints.add(new FacePoint(377, 356, 65.96));
  facePoints.add(new FacePoint(440, 345, 55.4));
  facePoints.add(new FacePoint(386, 344, 75.6));
  facePoints.add(new FacePoint(427, 339, 79.16));
  facePoints.add(new FacePoint(387, 365, 59.6));
  facePoints.add(new FacePoint(399, 368, 70.6));
  facePoints.add(new FacePoint(410, 362, 54.52));
  facePoints.add(new FacePoint(424, 360, 66.08));
  facePoints.add(new FacePoint(432, 352, 64.72));
  */
}

void addPoints(int mouseX, int mouseY) {
  if (mousePressed == true) {
    ellipse(mouseX, mouseY, 2, 2);
    fill(0, 0, 0);
    println(mouseX, mouseY);
    int steinerVal = mouseX + (mouseY * width);
    float brightSteiner = brightness(steinerVal);
    println(brightSteiner);
    //FacePoint steiner = facePoints.add(new FacePoint(mouseX, mouseY, brightSteiner));
    voronoi.addPoint(new Vec2D(mouseX, mouseY));
  }
}