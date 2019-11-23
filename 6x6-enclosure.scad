$fn = 25;
body_height = 14;
body_width = 69;
board_thickness = 3.4;
holder_radius = 10;


module board() {
//    linear_extrude(1.55, center=true) square(65,center=true);
    translate([0,0,1.55]) { linear_extrude(board_thickness, center=true) square(63,center=true); }
}


module body(body_height, body_width) {
    linear_extrude(body_height, center=true) square(body_width,center=true);
}

module holder_part1() {
    difference() {
    sphere(holder_radius*1.1);
    sphere(holder_radius);
    translate([0,-16.5,0]) cube(25, center=true);
    translate([0,-7,0]) cube(size=[1,20,25], center=true);
    translate([0,-7,0]) rotate([0,90,0]) cube(size=[1,20,25], center=true);
    translate([0,-7,0]) rotate([0,45,0]) cube(size=[1,20,25], center=true);
    translate([0,-7,0]) rotate([0,135,0]) cube(size=[1,20,25], center=true);
    }
}

module holder_part2() {
    sphere(holder_radius*0.99);

// free standing edition
    translate([0,-9.5,0]) rotate([90,0,0]) cube(size=[70, 70, 1], center=true);


// "trytytka" edition
    // difference() {
    //     translate([0,-7,0]) rotate([90,0,0]) cylinder(r=5, h=20, center=true);
    //     translate([0,-12,0]) rotate([0,0,0]) cylinder(r=2.5, h=20, center=true);
    //     translate([0,-12,0]) rotate([0,90,0]) cylinder(r=2.5, h=20, center=true);
    // }
}

module body_cap() {
    difference() {
        body_cap_plate();
        body_cap_hole();
    }

}

module body_cap_plate() {
    difference() {
       body(body_height-board_thickness,65.5);
       body(body_height-board_thickness,64);
   }
    translate([0,0,(-(body_height-board_thickness)/2)]) {
       body(2,body_width);
    }
}

module body_cap_hole() {
       translate([(body_width/2)-10,(-body_width/3)-5,board_thickness-10]) cylinder(r=3, h=10, center=true);;
       translate([(body_width/2)-10,(-body_width/3)-10,board_thickness-10]) cube(size=[6, 10, 100], center=true);
}

// main part
difference() {
   body(body_height,body_width);
   translate([0,0,(body_height/2)-board_thickness/2]) board();
   translate([0,0,-board_thickness/2]) body(body_height,66);
}
// main part cap
translate([0,0,-20]) body_cap();

// holder part 1
translate([0,(-body_width/2)-10,0]) holder_part1();

// holder part 2
translate([0,(-body_width/2)-20,0]) holder_part2();



