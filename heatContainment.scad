/*
 * WhateverSCAD by John Strunk is licensed under the Creative Commons
 * Attribution-ShareAlike 4.0 International License. To view a copy of
 * this license, visit http://creativecommons.org/licenses/by-sa/4.0/
 * or send a letter to Creative Commons, 444 Castro Street, Suite 900,
 * Mountain View, California, 94041, USA.
 */

/*****************************
 * containment(t, dist)
 * Produces a heat containment wall around the child object(s)
 * t: The thickness of the wall (e.g., the extrusion width)
 * dist: The distance from the object (default=2)
 ****************************/
module containment(t, dist = 2) {
	union() {
		intersection() {
			difference() {
				minkowski() { // create a tall tower
					cylinder(d=2+t, h=1);
					hull() {
						translate([0, 0, 1e6]) children();
						translate([0, 0, -1e6]) children();
					}
				}
				minkowski() { // cut out the inside
					cylinder(d=2, h=1);
					hull() {
						translate([0, 0, 1e6]) children();
						translate([0, 0, -1e6]) children();
					}
				}
			}
			hull() { // cut the wall to the final height
				translate([1e6, 1e6, 0]) children();
				translate([1e6, -1e6, 0]) children();
				translate([-1e6, 1e6, 0]) children();
				translate([-1e6, -1e6, 0]) children();
			}
		}
		children();
	}
}

module _testContainment() {
	containment(0.5) {
		cylinder(h=20, r1=10, r2=5);
		translate([20, 0, 5]) sphere(r=5);
	}
}

_testContainment();