basic_drawer_width = 70;
basic_drawer_depth = 80;
basic_drawer_walls_height = 25;
basic_drawer_full_height = 30;

drawer_wall_thickness = 1.2;
drawer_face_thickness = 2;
drawer_floor_thickness = 1;

drawer_back_radius = 2.2;

lip_height = 3;

label_height = 15;

handle_width = 35;
handle_depth = 10;
handle_vert_offset = 3;
handle_height = min(8, basic_drawer_full_height + lip_height - label_height - lip_height - handle_vert_offset);
handle_thickness = 1.2;

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

module hollow(thickness) {
    difference() {
        children();
        offset(-thickness)
            children();
    }
}

module handle(size, thickness, cutoff = 0) {
    linear_extrude(size.z, convexity = 2)
        difference() {
        hollow(thickness)
            scale([ 1, size.y * 2 / size.x ])
                circle(d = size.x);
        translate([ -size.x / 2 - 5, cutoff ])
            square(size.x + 10);
    }
}

module drawer() {
    translate(v = [ 0, 0, lip_height + handle_vert_offset ])
        handle(size = [ handle_width, handle_depth, handle_height ], thickness = handle_thickness);
    translate(v = [ -basic_drawer_width / 2, 0, 0 ]) {
        cut_bottom(size = [ lip_height, basic_drawer_width ]) union() {
            difference() {
                box_backrounded(size = [ basic_drawer_width, basic_drawer_depth, basic_drawer_walls_height ], r = drawer_back_radius);
                cut_bottom(size = [ lip_height, basic_drawer_width ], cut_offset = drawer_face_thickness / sqrt(2))
                    translate(v = [ drawer_wall_thickness, -drawer_wall_thickness, drawer_floor_thickness ])
                        box_backrounded(size = [ basic_drawer_width - drawer_wall_thickness * 2, basic_drawer_depth, basic_drawer_walls_height + 5 ], r = drawer_back_radius - drawer_wall_thickness);
            }
            // Face
            difference() {
                cube(size = [ basic_drawer_width, drawer_face_thickness, basic_drawer_full_height + lip_height ]);
                translate(v = [ 0, drawer_face_thickness, basic_drawer_full_height + lip_height ])
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