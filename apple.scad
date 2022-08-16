module import_apple(height) {
    resize([0,height,0], auto=[true,true,false])
        import("apple.svg", center = true);
}

module apple_delete_shape(height) {
    translate([0, -height/2])
        square([height, height]);
}

module half_apple(height) {
    difference() {
        import_apple(height);
        apple_delete_shape(height);
    
    }
}

module apple(height) {
    translate([0, 0, height/9]) {
        rotate_extrude() {
            half_apple(height);
        }
    }
}

module build_apple() {
    difference() {
        apple(100);
        apple(70);
        //translate([0, -100, -100]) cube(200);
    }
}

build_apple();

