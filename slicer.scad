$fn = 30;

/*shape_height = 20;
slice_number = 10;
stepped = false;
flatten = false;*/


slice_ratio = 3.0;
//slice ratio is the ratio between the width of the slice and the width of the open space

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



slicer(stepped = true, flatten = false, slice_number = 10, shape_height = 20) sphere(20);



/*

Needed: item dimensions(x,y,z), fill percentage, steppped(boolean), flatten(boolean)


Stuff to do: 
- height determination
- object maxium dimensions
- pass array of output slices

*/

module slicer(stepped, flatten, slice_number, shape_height){
    slice_thickness = shape_height/(slice_number +(slice_number-1)*slice_ratio);
    gap_thickness = slice_thickness*slice_ratio;
    
    if(stepped == false){
        if(flatten == false){
            slice_preview(slice_number, slice_thickness, gap_thickness)children();
        }
        else{
            slice_maker(slice_number, slice_thickness, gap_thickness)children();
        }
    }
    else{
        if(flatten == false){
            stepped_slice_preview(slice_number, slice_thickness, gap_thickness)children();
        }
        else{
            stepped_slice_maker(slice_number, slice_thickness, gap_thickness)children();
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
module slice_maker(slice_number, slice_thickness, gap_thickness){
    for (slice = [0:slice_number -1]){
        translate([slice*20,0,0]){
            cut_slice(slice, slice_thickness, gap_thickness)children();
        }
    }
}
module slice_preview(slice_number, slice_thickness, gap_thickness){
   for (slice = [0:slice_number -1]){
        translate([0,0,slice*(gap_thickness+slice_thickness)]){
            cut_slice(slice,slice_thickness, gap_thickness)children();
        }
    } 
}
module cut_stepped_slice(slice, slice_thickness, gap_thickness){
    linear_extrude(height=slice_thickness, center = true)projection(cut = true) translate([0,0,-slice*(slice_thickness+gap_thickness)-slice_thickness/2])children();
}
module stepped_slice_preview(slice_number, slice_thickness, gap_thickness){
    for (slice = [0:slice_number -1]){
        translate([0,0,slice*(slice_thickness+gap_thickness)+slice_thickness/2]){
            cut_stepped_slice(slice, slice_thickness, gap_thickness)children();
        }
    } 
}
module stepped_slice_maker(slice_number, slice_thickness, gap_thickness){
    for (slice = [0:slice_number -1]){
        translate([slice*20,0,slice_thickness/2]){
            cut_stepped_slice(slice, slice_thickness, gap_thickness)children();
        }
    }
}