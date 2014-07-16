WhateverSCAD
============

A library of OpenSCAD stuff... Because there aren't enough of them already.
These are some [OpenSCAD](http://www.openscad.org/) routines that I have written to make designing parts for 3D printing a bit easier.

## Library contents
Below is a brief description of some of the modules that are included in the library.

### Anti-warp walls (walls.scad)
After getting discouraged by seeing my _wonderfully_ designed pieces warp from the bed to the point that they started to look like boats, I figured it was time to look into some structures that would minimize the warping of walls while printing with ABS.

There are two different types of walls included, and they both work based on the same principle. The plastic shrinks as it cools, so long strands of plastic are going to tend to cause the part to bow and lift. These walls get around the long strands by creating "relief" areas where the plastic can shrink without transferring the force to the end of the part.

All wall types support adding a "frame" of solid material around it so it can be easily joined with the rest of the design.

* WWall() - A "wave wall"
  * This creates a wall using a continuous wave of plastic. The inspiration for this comes from [this design](http://www.thingiverse.com/thing:168352) on Thingiverse.
* SWall() - A wall made from squared-off zig-zags
  * This wall also has a wave-like shape to it, but the reliefs are square-shaped, giving the wall a more squared-off look. This wall is more rigid than the WWall() design, but it is also slightly more prone to warping.

### Heat containment wall (heatContainment.scad)
This can be used to generate a "heat containment" wall around a piece in an attempt to keep the part warm during printing. I haven't gotten a chance to evaluate how well it works yet.

### Holes for screws (screwHoles.scad)
There seems to be plenty of routines to work with metric fasteners (and it's easy to remember their sizes, too), but I frequently want to include a pilot hole for a #8 screw (for example). This file provides modules to create holes (using MCAD/polyholes) of the proper size for:
* Pilot holes
* Shank (through) holes
* Head counterbores

The currently supported sizes are #4, #6, #8, #10, and #12. There is also a module to create a "keyhole" slot for those soze screws as well.

## License
<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">WhateverSCAD</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/Whatever4783/WhateverSCAD" property="cc:attributionName" rel="cc:attributionURL">John Strunk</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.
