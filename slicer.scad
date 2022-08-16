$fn = 30;

shape_height = 20;
slice_number = 10;
slice_ratio = 1.0;
//slice ratio is the ratio between the width of the slice and the width of the open space

stepped = false;
flatten = false;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

slice_thickness = shape_height/(slice_number +(slice_number-1)*slice_ratio);
gap_thickness = slice_thickness*slice_ratio;

/*
Stuff to do: 
- height determination
- object maxium dimensions
- pass array of output slices

*/

module slicer(stepped, flatten){
    if(stepped == false){
        if(flatten == false){
            slice_preview()children();
        }
        else{
            slice_maker()children();
        }
    }
    else{
        if(flatten == false){
            stepped_slice_preview()children();
        }
        else{
            stepped_slice_maker()children();
        }
    }
}
module deletion_cubes(){
    translate([0,0,-100])cube(200, center = true);
    translate([0,0,100+slice_thickness])cube(200, center = true);
}
module cut_slice(slice){ 
    difference(){
            translate([0,0,-slice*(slice_thickness+gap_thickness)])children();
            deletion_cubes();
        }
}
module slice_maker(){
    for (slice = [0:slice_number -1]){
        translate([slice*20,0,0]){
            cut_slice(slice)children();
        }
    }
}
module slice_preview(){
   for (slice = [0:slice_number -1]){
        translate([0,0,slice*(gap_thickness+slice_thickness)]){
            cut_slice(slice)children();
        }
    } 
}
module cut_stepped_slice(slice){
    linear_extrude(height=slice_thickness, center = true)projection(cut = true) translate([0,0,-slice*(slice_thickness+gap_thickness)-slice_thickness/2])children();
}
module stepped_slice_preview(){
    for (slice = [0:slice_number -1]){
        translate([0,0,slice*(slice_thickness+gap_thickness)+slice_thickness/2]){
            cut_stepped_slice(slice)children();
        }
    } 
}
module stepped_slice_maker(){
    for (slice = [0:slice_number -1]){
        translate([slice*20,0,slice_thickness/2]){
            cut_stepped_slice(slice)children();
        }
    }
}