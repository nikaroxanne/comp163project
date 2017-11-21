/* references:
http://www.bowdoin.edu/~ltoma/teaching/cs3250-CompGeom/spring14/hw-kdtree.html
https://www.cs.umd.edu/class/spring2002/cmsc420-0401/pbasic.pdf
https://www.cs.princeton.edu/~rs/AlgsDS07/08BinarySearchTrees.pdf
*/

class kd_tree {
  kdNode root;
  int numberofNodes;
  int depth;
}
/*the same split (i.e. horizontal or vertical) is used for all nodes at the same dimension
the next enumerated type for the split is chosen for the successive level of tree */
/*
enum:
0 = none
1 = horizontal
2 = vertical
*/

class kdNode extends FacePoint{
  FacePoint p;
  enum direction;
  kdNode left, right;
  
  kdNode(Facepoint p){
    left = null;
    right = null;
    direction = 0;
    this.p.x = p.x;
    this.p.y = p.y;
  };
  
  
  kdNode insertNode(kdNode root, FacePoint p){
    if (root == null){
      new kdNode(p);
    }
    int cmp = p.x.compareTo(root.x);
    if (cmp == 0){
      root.x = p.x;
    }
    else if (cmp < 0) {
      root.left = put(p.left, p.x, p.y);
    } else {
      root.right = put(p.right, p.x, p.y);
    }
    return root;
}