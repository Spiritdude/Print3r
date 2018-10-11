/*
 * XYZ Hollow Calibration Cube
 *
 * Rene K. Mueller <spiritdude@gmail.com>
 * 
 * Description:
 *    Printable with 0% infill: "Z" at the bottom
 *
 * History:
 * 2018/09/29: 0.0.1: first version
 */

difference() {
   cube(20);
   translate([3,2,3]) rotate([90,0,0]) scale(1.5) linear_extrude(height=2) text("X");
   translate([20-2,3,3]) rotate([90,0,90]) scale(1.5) linear_extrude(height=2) text("Y");
   translate([3.5,14+3,0]) rotate([0,0,0]) scale([1.5,-1.5,1]) linear_extrude(height=2) text("Z");
}

