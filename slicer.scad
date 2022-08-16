$fn = 30;
//slice ratio is the ratio between the width of the slice and the width of the open space

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

slicer(stepped = true, flatten = false, num_slices = 10, slice_ratio = 1.0, object_dimensions = [40,40,40]) translate([0,0,20])sphere(20);

/*
directory called example, directory called test

Stuff to do: 
- height determination
- object maxium dimensions
- pass array of output slices

*/

module slicer(stepped = false, flatten = false, num_slices = 10, slice_ratio = 1.0, object_dimensions = [0,0,0]){
    slice_thickness = object_dimensions.z/(num_slices +(num_slices-1)*slice_ratio);
    gap_thickness = slice_thickness*slice_ratio;
    
    if(stepped == false){
        if(flatten == false){
            slice_preview(num_slices, slice_thickness, gap_thickness)children();
        }
        else{
            slice_maker(num_slices, slice_thickness, gap_thickness, object_dimensions)children();
        }
    }
    else{
        if(flatten == false){
            stepped_slice_preview(num_slices, slice_thickness, gap_thickness)children();
        }
        else{
            stepped_slice_maker(num_slices, slice_thickness, gap_thickness, object_dimensions)children();
        }
    }
}

module deletion_cubes(slice_thickness){
    translate([0,0,-100])cube(200, center = true);
    translate([0,0,100+slice_thickness])cube(200, center = true);
}

module cut_slice(slice, slice_thickness, gap_thickness){ 
    difference(){
            translate([0,0,-slice*(slice_thickness+gap_thickness)])children();
            deletion_cubes(slice_thickness);
        }
}

module slice_preview(num_slices, slice_thickness, gap_thickness){
   for (slice = [0:num_slices -1]){
        translate([0,0,slice*(gap_thickness+slice_thickness)]){
            cut_slice(slice,slice_thickness, gap_thickness)children();
        }
    } 
}

module slice_maker(num_slices, slice_thickness, gap_thickness, object_dimensions){
    for (slice = [0:num_slices -1]){
        translate([slice*20,0,0]){
            cut_slice(slice, slice_thickness, gap_thickness)children();
        }
    }
}

module cut_stepped_slice(slice, slice_thickness, gap_thickness){
    linear_extrude(height=slice_thickness, center = true)projection(cut = true) translate([0,0,-slice*(slice_thickness+gap_thickness)-slice_thickness/2])children();
}

module stepped_slice_preview(num_slices, slice_thickness, gap_thickness){
    for (slice = [0:num_slices -1]){
        translate([0,0,slice*(slice_thickness+gap_thickness)+slice_thickness/2]){
            cut_stepped_slice(slice, slice_thickness, gap_thickness)children();
        }
    } 
}

module stepped_slice_maker(num_slices, slice_thickness, gap_thickness, object_dimensions){
    for (slice = [0:num_slices -1]){
        translate([slice*20,0,slice_thickness/2]){
            cut_stepped_slice(slice, slice_thickness, gap_thickness)children();
        }
    }
}
