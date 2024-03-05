basic_drawer_width = 70;
basic_drawer_depth = 80;
basic_drawer_walls_height = 25;
basic_drawer_full_height = 30;

shelf_outer_wall_thickness = 2;
shelf_inner_wall_thickness = 1.2;
shelf_back_wall_thickness = 1;

shelf_slot_width = basic_drawer_width;
basic_shelf_width = shelf_slot_width + shelf_outer_wall_thickness * 2;
shelf_depth = basic_drawer_depth + shelf_back_wall_thickness;
shelf_height = basic_drawer_full_height * 4 + shelf_outer_wall_thickness * 2 + shelf_inner_wall_thickness * 3;

difference() {
    translate(v = [ -basic_shelf_width / 2, 0, 0 ])
        cube(size = [ basic_shelf_width, shelf_depth, shelf_height ]);
    for (i = [0:3]) {
        translate(v = [ -shelf_slot_width / 2, -10, shelf_outer_wall_thickness + i * (basic_drawer_full_height + shelf_inner_wall_thickness) ])
            cube(size = [ shelf_slot_width, basic_drawer_depth + 10, basic_drawer_full_height ]);
    }
}