use <apple.scad>
use <slicer.scad>

$fn=30;
slicer(stepped = false, flatten = false, num_slices = 10, slice_ratio = 0.7, object_dimensions = [50,50,76]) translate([0,0,39])build_apple();
