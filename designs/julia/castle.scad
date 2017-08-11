/*
 * This work by John Strunk & Julia Strunk is licensed under the Creative Commons
 * Attribution-ShareAlike 4.0 International License. To view a copy of
 * this license, visit http://creativecommons.org/licenses/by-sa/4.0/
 * or send a letter to Creative Commons, 444 Castro Street, Suite 900,
 * Mountain View, California, 94041, USA.
 */

$fa = 1;
$fs = 1;

module house() {
    cube([14, 14, 7]);
    translate([0, 14, 7])
        rotate([90, 0, 0])
            linear_extrude(height=14)
                polygon(points=[[0, 0], [14, 0], [7, 9]], convexity=2);
}


module cRow() {
    for (i = [0: 3]) {
        translate([i*4, 0, 0]) cube([2, 2, 2]);
    }
}

module cFence() {
    cRow();
    translate([2, 0, 0]) rotate([0, 0, 90]) cRow();
    translate([0, 12, 0]) cRow();
    translate([14, 0, 0]) rotate([0, 0, 90]) cRow();
}

module tower() {
    cube([14, 14, 20]);
    translate([0, 0, 20]) cFence();
}

module castle() {
    tower();
    translate([30, 0, 0]) tower();
    translate([15, 0, 0]) house();
}


module bridge() {
    translate([7, 14, 0]) difference() {
        cylinder(r = 7, h = 2);
        translate([-10, -20, -5]) cube([20, 20, 20]);
    }
    cube([14, 14, 2]);
}

castle();
translate([29, 0, 0]) rotate([0, 0, 180]) bridge();