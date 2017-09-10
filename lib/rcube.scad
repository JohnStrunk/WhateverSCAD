/*
 * This work by John Strunk is licensed under the Creative Commons
 * Attribution-ShareAlike 4.0 International License. To view a copy of
 * this license, visit http://creativecommons.org/licenses/by-sa/4.0/
 * or send a letter to Creative Commons, 444 Castro Street, Suite 900,
 * Mountain View, California, 94041, USA.
 */

/*
 * Create a cube with rounded edges.
 * size: Vector containing the overall external size of the cube
 * center: Whether the rcube should be centered on the origin
 * r: Radius of the edges
 */
module rcube(size = [1, 1, 1],
             center = false,
             r = 1e-6) {

    // Amount each point should be shifted to "center" the object
    dx = center ? size[0]/2 : 0;
    dy = center ? size[1]/2 : 0;
    dz = center ? size[2]/2 : 0;
    
    /*
     * The rcube is formed by generating the hull around 8 spheres
     * that are positioned at the corners of the cube. Sphere centers
     * are placed inside the finished dimensions by r to ensure the
     * resulting hull is the correct size.
     */
    hull() {
        translate([r-dx, r-dy, r-dz]) sphere(r=r);
        translate([size[0]-r-dx, r-dy, r-dz]) sphere(r=r);
        translate([r-dx, size[1]-r-dy, r-dz]) sphere(r=r);
        translate([size[0]-r-dx, size[1]-r-dy, r-dz]) sphere(r=r);
        translate([r-dx, r-dy, size[2]-r-dz]) sphere(r=r);
        translate([size[0]-r-dx, r-dy, size[2]-r-dz]) sphere(r=r);
        translate([r-dx, size[1]-r-dy, size[2]-r-dz]) sphere(r=r);
        translate([size[0]-r-dx, size[1]-r-dy, size[2]-r-dz]) sphere(r=r);
    };
}

$fa = 1;
$fs = 0.5;
rcube([5, 10, 15], true, 2);
translate([15, 0, 0]) rcube([10, 5, 5], false, 1);