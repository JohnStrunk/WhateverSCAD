/*
 * WhateverSCAD by John Strunk is licensed under the Creative Commons
 * Attribution-ShareAlike 4.0 International License. To view a copy of
 * this license, visit http://creativecommons.org/licenses/by-sa/4.0/
 * or send a letter to Creative Commons, 444 Castro Street, Suite 900,
 * Mountain View, California, 94041, USA.
 */

/*****************************
 * Walls that are designed to minimize warping. They all take the same set
 * of parameters
 * t: The total thickness of the wall (x)
 * l: The length of the wall (y)
 * h: The height of the wall (z)
 * top, bottom, front, back: Whether to include a "frame" on that side of
 *   the wall. top & bottom will cause some warping! (default: true for f&r)
 *
 * Available wall types:
 * WWall: A wall made from a "wave" of material. The actual material
 *   thickness is t/3.
 * SWall: A wall made with square cutouts. The actual material thickness
 *   is t/2.
 ****************************/

_ep = 0.0001;

// Wall made from a "wave" shape
// t is the total thickness of the wall. The actual material thickness is t/3
module WWall(t, l, h,
             top = false, bottom = false, front = true, rear = true) {
	// create a 1/2 circle (r=t/2)
	module arc() {
		$fn = 8; // must be divisible by 4 so the arcs meet!
		difference() {
			cylinder(h=h, r=t/2);
			translate([0, 0, -_ep]) cylinder(h=h+2*_ep, r=t/6);
			translate([-t/2-_ep, -t/2-_ep, -_ep]) cube([t/2, t+2*_ep, h+2*_ep]);
		}
	}
	// create a full cycle of the wave (y=5t/3)
	module cycle() {
		translate([0, t/2, 0]) union() {
			arc();
			translate([0, 2*t/3, 0]) rotate([0, 0, 180]) arc();
		}
	}
	cycles = ceil(l/(4*t/3));
	union() {
		translate([t/2, 0, 0]) difference() {
			union() {
				for(c = [0 : cycles-1]) {
					translate([0, c * 4*t/3, 0]) cycle();
				}
			}
			translate([-t, l, -h/2]) cube([2*t, 2*t, 2*h]);
		}
		_WallFrame(t, l, h, top=top, bottom=bottom, front=front, rear=rear);
	}
}


// Wall with square relief cuts
// t is the total thickness of the wall. The actual material thickness is t/2
module SWall(t, l, h,
             top = false, bottom = false, front = true, rear = true) {
	cycles = ceil(l/(2*t));

	union() {
		difference() {
			cube([t, l, h]); // start w/ solid wall
			for(y = [0:cycles-1]) {
				// cut out left-side reliefs
				translate([-_ep, 2*t*y + 3*t/2, -_ep])
					cube([t/2+_ep, t/2, h+2*_ep]);
				// cut out right-side reliefs
				translate([t/2, 2*t*y + 1*t/2, -_ep])
					cube([t/2+_ep, t/2, h+2*_ep]);
			}
		}
		_WallFrame(t, l, h, top=top, bottom=bottom, front=front, rear=rear);
	}
}

// Produce a square "frame" for a wall
module _WallFrame(t, l, h, top, bottom, front, rear) {
	union() {
		if (front) { cube([t, t, h]); }
		if (rear) { translate([0, l-t, 0]) cube([t, t, h]); }
		if (bottom) { cube([t, l, t]); }
		if (top) { translate([0, 0, h-t]) cube([t, l, t]); }
	}
}

module _testWalls() {
	union() {
		translate([-7.5, 0, 0]) cube([15, 150, 1]);
		translate([-1.5, 0, 0]) SWall(3, 150, 30);
	}
	translate([20, 0, 0]) union() {
		translate([-7.5, 0, 0]) cube([15, 150, 1]);
		translate([-1.5, 0, 0]) WWall(3, 150, 30);
	}
}
_testWalls();