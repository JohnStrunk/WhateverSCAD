/*
 * This work by John Strunk is licensed under the Creative Commons
 * Attribution-ShareAlike 4.0 International License. To view a copy of
 * this license, visit http://creativecommons.org/licenses/by-sa/4.0/
 * or send a letter to Creative Commons, 444 Castro Street, Suite 900,
 * Mountain View, California, 94041, USA.
 *
 * This object is used to make a child's periscope toy.
 * Print two out these and place them on the ends of a paper towel roll. You will also
 * need to affix mirrors to the inside of teh slanted portion of these end caps.
 *
 * Bugs:
 *   - tube_ins should be able to be decreased toward 0, but it causes bad clipping
 *     on the clyinder.
 */
 
wall_t   = 2;   // Thickness of the periscope tube walls
tube_d   = 30;  // Outside diameter of the paper towel roll
tube_ins = 50;  // How far the towel roll should insert into the periscope end

_ep = 1e-6;
$fa = 1;
$fs = 1;
 

mask_size = 4*(tube_d + 2*wall_t);

module outerCyl() {
    cylinder(h = tube_ins + tube_d + 2*wall_t, r = tube_d/2 + wall_t);
}

module innerCyl() {
    cylinder(h = tube_ins + tube_d + 2*wall_t + 2*_ep, r = tube_d/2);
}

module viewCutter() {
    translate([0, -tube_d/2-wall_t-tube_ins/2, tube_ins + tube_d/2])
        rotate([-90, 0, 0])
            innerCyl();
}

module mainTube() {
    difference() {
        outerCyl();
        translate([0, 0, -_ep]) innerCyl();
        viewCutter();
    }
}

module topCap() {
    intersection() {
        translate([0, 0, -2*(tube_d+wall_t)]) outerCyl();
        rotate([45, 0, 0]) {
            cube([mask_size, mask_size, wall_t], center=true);
        }
    }
}

module topMask() {
    scale(1+_ep) {
        hull() {
            topCap();
            translate([0, 0, mask_size]) topCap();
        }
    }
}

difference() {
    union() {
        mainTube();
        translate([0, 0, tube_ins + tube_d/2 + wall_t/2]) topCap();
    }
    translate([0, 0, tube_ins + tube_d/2 + wall_t]) topMask();
}