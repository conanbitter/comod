basic_drawer_width = 70;
basic_drawer_depth = 80;
basic_drawer_walls_height = 25;
basic_drawer_full_height = 30;

module_outer_wall_thickness = 2;
module_inner_wall_thickness = 1.2;
module_back_wall_thickness = 1;

module_slot_width = basic_drawer_width;
basic_module_width = module_slot_width + module_outer_wall_thickness * 2;
module_depth = basic_drawer_depth + module_back_wall_thickness;
module_height = basic_drawer_full_height * 4 + module_outer_wall_thickness * 2 + module_inner_wall_thickness * 3;

difference() {
    translate(v = [ -basic_module_width / 2, 0, 0 ])
        cube(size = [ basic_module_width, module_depth, module_height ]);
    for (i = [0:3]) {
        translate(v = [ -module_slot_width / 2, -10, module_outer_wall_thickness + i * (basic_drawer_full_height + module_inner_wall_thickness) ])
            cube(size = [ module_slot_width, basic_drawer_depth + 10, basic_drawer_full_height ]);
    }
}