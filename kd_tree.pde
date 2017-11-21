/*
https://www.eecs.tufts.edu/~aloupis/comp160/classnotes/160-selection-deterministic.pdf

https://www.ics.uci.edu/~eppstein/161/960130.html

looking for element with rank r 
in range (1...n)


select(int median, ArrayList FacePoints){
  if FacePoints.size() < 10 {
    sort(FacePoints); // some in-place swapping insertion sort prob
    return FacePoints.get(median);
  }
}

partition FacePoints into subsets of five elements
There will be a total of n/5 subsets (range of i...n/5)

//median of each group//
for (i=1 to n/5){
 select(subset[i], 3)
};

//median of medians//
x = median of medians

//compare all elements to x to find rank[x] = p

if rank[x]=p=r, we're done
else use x as privot to partition input

if p > r // search lower
  Select(r, 1...p-1)
  
else //if (p < r), search higher
Select(r-p, p+1...n);



//other notes//

partition total ArrayList into 3 groups:
L1 < M, L2 = M, l3 > M
if rank[M]
*/

/* Building kd tree can be done using a randomized pivot but the deterministic median finding algorithm runs in O(n)
The median is used for each division in a kd tree so this feels like an important module to build in

kd tree
1. find median of x values, use as first partition
2. find median of y values, use as next partition
3. recurse until all points are used as medial axes to divide the space

this can be used later to determine voronoi diagrams -- an extension of a medial axil division
also can be used for medial axis skeletonization