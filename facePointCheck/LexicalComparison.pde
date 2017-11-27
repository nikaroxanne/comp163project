/* 
using Greg Borenstein's Convex Hull/Lexical Comparison implementations for Processing
github.com/atduskgreg/processing-convex-hull

*/

/*

Convex Hull Algorithm from "Computational Geometry by Deberg et al"
Algorithm: ConvexHull(P)
Input: a set of P points in the plane
Output: a list containing the vertices of the CH(P) -- convex hull of P -- in clockwise order

1. Sortpoints by x-coordinate resulting in sequence p1, p2... pn
2. put points p1 and p2 in a list called listUpper. Make p1 the first point in this list
3. For (int i=3; i< n; i++){
4.  do append Pi to lUpper
5.  while LUpper contains > 3 points && the last three points do not make a right turn {
6.    do delete middle of last three points from lUpper
    }
7. put points in pn and pn-1 in a list, listLower, with Pn as the first point in the list
8. for (int i = n-2; i >= 1; i--){
9.    do append Pi to lLower  
10.    while lLower contains > 3 points && the last three points do not make a right turn,
11.      do delete the middle of last three points from lLower
}
12. remove first and last points from lLower to avoid duplication where upper and lower hulls meet
13. Append lLower to lUpper and call resulting list L
14. return L

L is Convex Hull, represented as a list of CH points in clockwise order
requires lexicographic comparison, so that if two points share the same x value, then they are sorted by y value


*/
 public class PointXSort implements Comparator<FacePoint> {
   public PointXSort(){
   }
   
    public int compare(FacePoint f1, FacePoint f2) {
       //float pointXfirst = f1.getXCoord();
       //float pointXsecond = f2.getXCoord();
       int comparison = 0;
       if (f1.x > f2.x){
         comparison = 1;
       } else if (f1.x < f2.x) {
         comparison = -1;
       } else {
         //if 2 points have same x value, sort by y value
         if (f1.y > f2.y) {
           comparison = 1;
           
         } else if (f1.y < f2.y) {
           comparison= -1;
         }
       }
       //return pointXfirst - pointXsecond;
       return comparison;
     }
   };
   
   /****************************************************************/
   /*YSort sorts FacePoint objects in ascending order */
   /* y values in pixel location are visually shown in the opposite position */
   /* thus, YMIN is at the final index in the ArrayList<FacePoint> and not at index 0 */
   /*****************************************/
   public class PointYSort implements Comparator<FacePoint> {
     public PointYSort(){
     }
   
     public int compare(FacePoint f1, FacePoint f2) {
       //float pointYfirst = f1.getYCoord();
       //float pointYsecond = f2.getYCoord();
       //if 2 points have same y value, sort by x value
       int comparison = 0;
       if (f1.y < f2.y){
         comparison = 1;
       } else if (f1.y > f2.y) {
         comparison = -1;
       } else {
         //if 2 points have same x value, sort by y value
         if (f1.x > f2.x) {
           comparison = 1;
           
         } else if (f1.x < f2.x) {
           comparison= -1;
         }
       }
       //return pointXfirst - pointXsecond;
       return comparison;
     }
       //return pointYfirst - pointYsecond;
   };
   
   public class PointAngleSort implements Comparator<FacePoint> {
     public PointAngleSort(){
     }
   
     public int compare(FacePoint f1, FacePoint f2) {
       //float pointYfirst = f1.getYCoord();
       //float pointYsecond = f2.getYCoord();
       //if 2 points have same y value, sort by x value
       int comparison = 0;
       float polarAngleVal = f2.angle - f1.angle;
       if (polarAngleVal < 0){
         comparison = 1;
       } else if (polarAngleVal > 0) {
         comparison = -1;
       } else {
         
         //if 2 points have same anglevalue, sort by distance
         if (f1.dist > f2.dist) {
           comparison = 1;
           
         } else if (f1.dist < f2.dist) {
           comparison= -1;
         }
         
         //comparison = 0;
         
       }
       //return pointXfirst - pointXsecond;
       return comparison;
     }
       //return pointYfirst - pointYsecond;
   };