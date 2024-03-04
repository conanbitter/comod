basic_drawer_width = 70;
basic_drawer_depth = 80;
basic_drawer_walls_height = 25;
basic_drawer_full_height = 30;

drawer_wall_thickness = 1.2;
drawer_face_thickness = 2;
drawer_floor_thickness = 1;

translate(v = [ -basic_drawer_width / 2, 0, 0 ]) {
    union() {
        difference() {
            cube(size = [ basic_drawer_width, basic_drawer_depth, basic_drawer_walls_height ]);
            translate(v = [ drawer_wall_thickness, -drawer_wall_thickness, drawer_floor_thickness ])
                cube(size = [ basic_drawer_width - drawer_wall_thickness * 2, basic_drawer_depth, basic_drawer_walls_height + 5 ]);
        }
        cube(size = [ basic_drawer_width, drawer_face_thickness, basic_drawer_full_height ]);
    }
}