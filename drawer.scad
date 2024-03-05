basic_drawer_width = 70;
basic_drawer_depth = 80;
basic_drawer_walls_height = 25;
basic_drawer_full_height = 30;

drawer_wall_thickness = 1.2;
drawer_face_thickness = 2;
drawer_floor_thickness = 1;

drawer_back_radius = 2.2;

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

translate(v = [ -basic_drawer_width / 2, 0, 0 ]) {
    union() {
        difference() {
            box_backrounded(size = [ basic_drawer_width, basic_drawer_depth, basic_drawer_walls_height ], r = drawer_back_radius);
            translate(v = [ drawer_wall_thickness, -drawer_wall_thickness, drawer_floor_thickness ])
                box_backrounded(size = [ basic_drawer_width - drawer_wall_thickness * 2, basic_drawer_depth, basic_drawer_walls_height + 5 ], r = drawer_back_radius - drawer_wall_thickness);
        }
        cube(size = [ basic_drawer_width, drawer_face_thickness, basic_drawer_full_height ]);
    }
}