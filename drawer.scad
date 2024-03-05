basic_drawer_width = 70;
basic_drawer_depth = 80;
basic_drawer_walls_height = 25;
basic_drawer_full_height = 30;

drawer_wall_thickness = 1.2;
drawer_face_thickness = 2;
drawer_floor_thickness = 1;

drawer_back_radius = 2.2;

lip_height = 3;

debug = true;

$fs = $preview ? 1 : 0.1;
$fa = $preview ? 3 : 0.1;

module box_backrounded(size, r) {
    rr = min(r, size.x / 2, size.y / 2);
    linear_extrude(height = size.z)
        hull() {
        square(size = [ size.x, rr ]);
        translate(v = [ rr, size.y - rr ])
            circle(r = rr);
        translate(v = [ size.x - rr, size.y - rr ])
            circle(r = rr);
    }
}

module cut_bottom(size, cut_offset = 0) {
    rsize = size.x + cut_offset * sqrt(2);
    rwidth = size.y;
    cut_length = rsize * sqrt(2);

    difference() {
        children();
        translate(v = [ 0, rsize, 0 ])
            rotate([ 45, 0, 0 ])
                translate(v = [ -5, -rsize, 0 - cut_length / 2 ])
                    cube(size = [ rwidth + 10, rsize, cut_length * 2 ]);
    }
}

module top_cutter(size, cut_offset = 0) {
    rsize = size.x + cut_offset * sqrt(2);
    rwidth = size.y;
    cut_length = rsize * sqrt(2);
    translate(v = [ 0, 0, -rsize ])
        rotate([ 45, 0, 0 ])
            translate(v = [ -5, 0, 0 - cut_length / 2 ])
                cube(size = [ rwidth + 10, rsize, cut_length * 2 ]);
}

module drawer() {
    translate(v = [ -basic_drawer_width / 2, 0, 0 ]) {
        cut_bottom(size = [ lip_height, basic_drawer_width ]) union() {
            difference() {
                box_backrounded(size = [ basic_drawer_width, basic_drawer_depth, basic_drawer_walls_height ], r = drawer_back_radius);
                cut_bottom(size = [ lip_height, basic_drawer_width ], cut_offset = drawer_face_thickness / sqrt(2))
                    translate(v = [ drawer_wall_thickness, -drawer_wall_thickness, drawer_floor_thickness ])
                        box_backrounded(size = [ basic_drawer_width - drawer_wall_thickness * 2, basic_drawer_depth, basic_drawer_walls_height + 5 ], r = drawer_back_radius - drawer_wall_thickness);
            }
            difference() {
                cube(size = [ basic_drawer_width, drawer_face_thickness, basic_drawer_full_height ]);
                translate(v = [ 0, drawer_face_thickness, basic_drawer_full_height ])
                    top_cutter(size = [ drawer_face_thickness, basic_drawer_width ], cut_offset = 0);
            }
        }
    }
}

difference() {
    drawer();
    if (debug) {
        translate(v = [ 100, 0, 0 ])
            cube(size = 200, center = true);
    }
}