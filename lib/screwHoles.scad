/*
 * WhateverSCAD by John Strunk is licensed under the Creative Commons
 * Attribution-ShareAlike 4.0 International License. To view a copy of
 * this license, visit http://creativecommons.org/licenses/by-sa/4.0/
 * or send a letter to Creative Commons, 444 Castro Street, Suite 900,
 * Mountain View, California, 94041, USA.
 */

/*****************************
 * PilotHole4(h, center)
 * Cylinders that can be differenced to create pilot holes,
 * through holes, or head counterbores for SAE screws.
 * See: http://www.wlfuller.com/html/wood_screw_chart.html
 * Current support for #4, #6, #8, #10, and #12 pilot, shank, and head
 * holes.
 * h: The depth (height) of the hole
 * center: True if the depth should be centered at z=0 (default=false)
 ****************************/

/*****************************
 * Keyhole6(h)
 * Create a "keyhole" slot for a #6 screw. Supports sizes #4, #6, #8,
 * #10, and #12.
 * h: The depth (height) of the slot to create
 ****************************/

use <MCAD/polyholes.scad>

/**
 * Convert inches to mm.
 * in: The measurement in inches
 * returns: The measurement in mm
 */
function inch(in) = 25.4 * in;

_ep = 0.0001;

/**
 * Correction factor in case the stock hole sizes are the wrong size. This
 * serves as a multiplier on the hole diameter, so 1.1 would be 110% of
 * nominal.
 */
screwCorrection = 1.0;

module HeadHole4(h, center=false) { _screwHole(h, center, inch(1/4)); }
module PilotHole4(h, center=false) { _screwHole(h, center, inch(5/64)); }
module ShankHole4(h, center=false) { _screwHole(h, center, inch(7/64)); }
module HeadHole6(h, center=false) { _screwHole(h, center, inch(3/8)); }
module PilotHole6(h, center=false) { _screwHole(h, center, inch(7/64)); }
module ShankHole6(h, center=false) { _screwHole(h, center, inch(9/64)); }
module HeadHole8(h, center=false) { _screwHole(h, center, inch(3/8)); }
module PilotHole8(h, center=false) { _screwHole(h, center, inch(1/8)); }
module ShankHole8(h, center=false) { _screwHole(h, center, inch(11/64)); }
module HeadHole10(h, center=false) { _screwHole(h, center, inch(1/2)); }
module PilotHole10(h, center=false) { _screwHole(h, center, inch(9/64)); }
module ShankHole10(h, center=false) { _screwHole(h, center, inch(13/64)); }
module HeadHole12(h, center=false) { _screwHole(h, center, inch(1/2)); }
module PilotHole12(h, center=false) { _screwHole(h, center, inch(5/32)); }
module ShankHole12(h, center=false) { _screwHole(h, center, inch(7/32)); }

module _screwHole(h, center, d) {
	if (center) {
		translate([0, 0, -h/2])	polyhole(h=h, d=screwCorrection * d);
	} else {
		polyhole(h=h, d=screwCorrection * d);
	}
}

module Keyhole4(h) { _keyHole(inch(1/4)) { HeadHole4(h); ShankHole4(h); }}
module Keyhole6(h) { _keyHole(inch(3/8)) { HeadHole6(h); ShankHole6(h); }}
module Keyhole8(h) { _keyHole(inch(3/8)) { HeadHole8(h); ShankHole8(h); }}
module Keyhole10(h) { _keyHole(inch(1/2)) { HeadHole10(h); ShankHole10(h); }}
module Keyhole12(h) { _keyHole(inch(1/2)) { HeadHole12(h); ShankHole12(h); }}

module _keyHole(offset) {
	union() {
		hull() { // make a slot
			children(1);
			translate([0, offset, 0]) children(1);
		}
		children(0); // punch hole for the head
	}
}

module _testScrewHoles() {
	thickness = inch(0.25);
	difference() {
		cube([55, 40, thickness]);
		translate([5, 10, -0.1]) PilotHole4(thickness+1);
		translate([5, 20, -0.1]) ShankHole4(thickness+1);
		translate([5, 30, -0.1]) HeadHole4(thickness+1);
		translate([15, 30, -0.1]) PilotHole6(thickness+1);
		translate([15, 20, -0.1]) ShankHole6(thickness+1);
		translate([15, 10, -0.1]) HeadHole6(thickness+1);
		translate([25, 10, -0.1]) PilotHole8(thickness+1);
		translate([25, 20, -0.1]) ShankHole8(thickness+1);
		translate([25, 30, -0.1]) HeadHole8(thickness+1);
		translate([35, 30, -0.1]) PilotHole10(thickness+1);
		translate([35, 20, -0.1]) ShankHole10(thickness+1);
		translate([35, 10, -0.1]) HeadHole10(thickness+1);
		translate([45, 10, -0.1]) PilotHole12(thickness+1);
		translate([45, 20, -0.1]) ShankHole12(thickness+1);
		translate([45, 30, -0.1]) HeadHole12(thickness+1);
	}
}

module _testKeyholes() {
	thickness = inch(1/8);
	difference() {
		cube([inch(2.75), inch(1.25), thickness]);
		translate([inch(1/4), inch(3/8), -0.1]) Keyhole4(thickness+1);
		translate([inch(5/8), inch(3/8), -0.1]) Keyhole6(thickness+1);
		translate([inch(1.125), inch(3/8), -0.1]) Keyhole8(thickness+1);
		translate([inch(1.625), inch(3/8), -0.1]) Keyhole10(thickness+1);
		translate([inch(2.25), inch(3/8), -0.1]) Keyhole12(thickness+1);
	}
}
_testScrewHoles();
translate([0, inch(2), 0]) _testKeyholes();
