//FacePoint v1 = new FacePoint(421, 242, 58.4); 
//FacePoint v2 = new FacePoint(435, 231, 22.16);
//FacePoint v3 = new FacePoint(441, 223, 28.08);
//FacePoint v4 = new FacePoint(440, 240, 33.64);
//FacePoint v5 = new FacePoint(448, 243, 49.52);
//FacePoint v6 = new FacePoint(454, 232, 24.88);
//FacePoint v7 = new FacePoint(452, 226, 3.92);
//FacePoint v8 = new FacePoint(444, 232, 69.76);
//FacePoint v9 = new FacePoint(465, 232, 13.36);
//FacePoint v10 = new FacePoint(364, 250, 62.84);
//322 258 6.32
//334 250 27.8
//336 259 65.4
//345 257 17.72
//353 250 33.72
//351 246 15.36
//341 244 21.64
//345 251 60.12
//370 227 68.4
//402 223 71.52
//431 207 52.04
//450 197 58.04
//449 187 81.92
//426 200 67.08
//482 201 66.56
//329 228 65.72
//330 218 46.08
//311 216 71.4
//308 225 62.56
//291 240 60.68
//292 300 53.32
//318 330 50.64
//330 366 37.28
//342 382 47.48
//375 414 39.72
//416 425 25.88
//460 406 42.52
//473 396 38.4
//493 377 45.88
//510 352 59.04
//514 322 62.04
//520 279 48.04
//528 250 70.28
//515 208 25.88
//380 300 55.84
//395 304 60.04
//395 304 60.04
//407 293 68.64
//407 293 68.64
//379 292 68.12
//388 283 88.2
//403 289 77.16
//393 293 84.96
//377 310 75.88
//419 304 70.16
//403 333 76.6
//413 327 83.0
//394 332 78.24
//394 332 78.24
//405 343 48.16
//408 350 64.12
//396 342 49.88
//414 341 50.2
//377 356 65.96
//440 345 55.4
//386 344 75.6
//427 339 79.16
//387 365 59.6
//399 368 70.6
//410 362 54.52
//424 360 66.08
//432 352 64.72 
import java.util.Comparator;

public class FacePoint{
  float x, y; 
  float pointShade;
  ArrayList<Edge> edges;
  //boolean VISITED;
  int id;
  float angle;
  float dist;

 public FacePoint(float x, float y, float pointShade) {
    this.x = x;
    this.y = y;
    this.pointShade = pointShade;
    this.angle = atan2(YMINY - y, YMINX - x);
    //id = 0;
    
    //distPt1 = (x-x2);
    //distPt2; (x1, y1, x2, y2);
    //angle = arccos((distPt1)/ (distPt2));
    //edges = new ArrayList();
  }
  
  public float getXCoord(){
    return this.x;
  }
  
  public float getYCoord(){
    return this.y;
  }
  
  public void setXCoord(float xCoord){
    this.x = xCoord;
  }
  
   public void setYCoord(float yCoord){
    this.y = yCoord;
  }
  
  float polarAngle(FacePoint p1, FacePoint p2){
    float angle = atan2(p2.y, p2.x) - atan2(p1.y, p1.x); 
    return angle;
  }
  
  //@ Override public int compareTo(FacePoint compareFace) {
  //  int compareQuantity = ((FacePoint) compareFace).getXCoord();
  //  //facepoints returned in ascending order of x coordinate value
  //  return this.x - compareQuantity;
  //}
  
   
   
   /*
   public int compareTo(FacePoint other) {
     
    int thisX = this.getXCoord();
    int otherXCoord = other.getXCoord();
    int compareQuantity = thisX - otherXCoord;
    //facepoints returned in ascending order of x coordinate value
    return compareQuantity;
    
    /* if(f1.x > f2.x) {
       return 1;
       else if (f1.x < f2.x) {
         return -1;
         else {
           if (f1.y < f2.y) {
             return 1;
           } else if (f1.y > f2.y) {
             return -1
           }
         }
      */
  //}
  
  
  void showHullPoint() {
    noStroke();
    fill(0);
    triangle(x, y, x+10, y+10, x+10, y);
  }

  void showPoint() {
    noStroke();
    fill(255);
    triangle(x, y, x+3, y+3, x+3, y);
  }
  //FacePoint v1 = new FacePoint(421, 242, 58.4); 
  //FacePoint v2 = new FacePoint(435, 231, 22.16);
  //FacePoint v3 = new FacePoint(441, 223, 28.08);
  //FacePoint v4 = new FacePoint(440, 240, 33.64);
  //FacePoint v5 = new FacePoint(448, 243, 49.52);
  //FacePoint v6 = new FacePoint(454, 232, 24.88);
  //FacePoint v7 = new FacePoint(452, 226, 3.92);
  //FacePoint v8 = new FacePoint(444, 232, 69.76);
  //FacePoint v9 = new FacePoint(465, 232, 13.36);
  //FacePoint v10 = new FacePoint(364, 250, 62.84);

  /*void showEdges(){
   for (Edge edge : edges) {
   edge.draw();
   }
   }*/
  /*void organize(){
   }*/
}