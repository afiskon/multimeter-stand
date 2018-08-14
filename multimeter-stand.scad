/* vim: set ai et ts=4 sw=4: */
// http://www.openscad.org/cheatsheet/

width = 98; // multimeter width
depth = 47; // multimeter depth (thickness)
height = 60; // multimeter height - only part in the stand
wall_height = 10; // height of the "walls"
thickness = 2;
angle = 75;
render_walls = true; // for debugging

stand_width = width + 2*thickness;
stand_depth = height / sqrt(2);
stand_height =(height + depth + thickness) / sqrt(2);

module triangle(w, d, h) {
    delta = 2; // small value for better rendering
    difference() {
        cube([w, d, h]);

        translate([-delta, 0, 0])
            rotate([asin(h / sqrt(h*h + d*d)), 0, 0])
                cube([w+2*delta, 100*d, sqrt(h*h + d*d)]);
    }
}

union() {

// back "triangle"
triangle(width+2*thickness, height*sin(90-angle), height*sin(angle));

// front/bottom "triangle"
translate([width+2*thickness,0,0])
    rotate([0,0,180])
        triangle(width+2*thickness, depth*sin(angle), depth*sin(90-angle));

// horisontal "base"
translate([0,-depth*sin(angle),-thickness])
    cube([width+2*thickness,
          depth*sin(angle)+height*sin(90-angle),
          thickness]);

// vertical "base"
translate([0,height*sin(90-angle),-thickness])
    cube([width+2*thickness,thickness,height*sin(angle)+thickness]);

if(render_walls) {
    // left "wall"
    rotate([angle,0,0])
        cube([thickness,wall_height,depth]);

    // right "wall"
    translate([width+thickness,0,0])
        rotate([angle,0,0])
            cube([thickness,wall_height,depth]);

    // front "wall"
    translate([thickness,-depth*sin(angle),depth*sin(90-angle)])
        rotate([angle-90,0,0])
            cube([width,thickness,wall_height]);
} // if

} // union
