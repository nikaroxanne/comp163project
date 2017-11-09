import gab.opencv.*;
import java.awt.Rectangle;

final int SCALEFACTOR = 1;
final int DISPLAYWIDTH = 600;
final int DISPLAYHEIGHT = 600;

PImage src, img, destination;
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
  //void boxSizeCheck() {
  //  for (int i=0; i< boxPoints.size(); i++){
  //    if ((height < 100) || (width < 100)) {
  //      boxPoints.remove(boxPoints);
  //    } else {
  //      boxPoints.add(new BoundingBox(x,y, width,height));
  //    }
  //  }
  //}
  //void getFaces(Rectangle[] faces) {
  //  for (int i=0; i < faces.length; i++) {
  //    int boxX = faces[i].x;
  //    int boxY = faces[i].y; 
  //    int boxWidth = faces[i].width; 
  //    int boxHeight = faces[i].height;
  //    boxPoints.add(new BoundingBox(boxX, boxY, boxWidth, boxHeight));
  //    //rect(faces[i].x,faces[i].y, faces[i].width, faces[i].height);
  //    //print(faces[i].x);
  //    println(faces[i].x);
  //    println(faces[i].y);
  //    println(faces[i].width);
  //    println(faces[i].height);
  //  }
  //}

  //int getWWidth(int index){
  //  return width;
  //}
  //for(int i=0; i < faces.length; i++){
  //int facewidth = (faces[i].width)/SCALEFACTOR;
  //int faceheight = (faces[i].height)/SCALEFACTOR;
  //int faceX = (faces[i].x)/SCALEFACTOR;
  //int faceY = (faces[i].y)/SCALEFACTOR;
  ////boxPoints.add(new BoundingBox(boxX, boxY, boxWidth, boxHeight));
  ////int boxPassed = (boxPoints.boxSizeCheck(facewidth, faceheight));
  //// if (boxPassed == 1) {
  //boxPoints.add(new BoundingBox(faceX, faceY, facewidth, faceheight));

  //}
  void setup(){
    src = loadImage("nikanew.jpg");
    src.resize(0,600);
    boxPoints = new ArrayList();
    size(600,600);
    opencv = new OpenCV(this, src);
    opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
    faces = opencv.detect();
    checkFaces(faces);
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
      //boxPoints.add(new BoundingBox(boxX, boxY, boxWidth, boxHeight));
      //int boxPassed = (boxPoints.boxSizeCheck(facewidth, faceheight));
      //  boxPoints.boxSizeCheck();
      if ((faceheight > 100) && (facewidth > 100)) {
        boxPoints.add(new BoundingBox(faceX,faceY, facewidth,faceheight));
      }
    }
  }
 