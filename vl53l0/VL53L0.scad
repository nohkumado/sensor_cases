// Parameters for VL53L0X dimensions
sensor = [4.5, 2.5,1]; //sensor mesurements
pcb_width = 10.6;       // Approximate width of the pcb PCB in mm
pcb_length = 15.7;      // Approximate length of the pcb PCB in mm
pcb_thickness = 1.6;  // Approximate thickness of the pcb PCB in mm
lens_radius = 2.5;       // Approximate radius of the lens in mm
pin_length = 3;          // Length of the pins extending from the PCB in mm
pin_diameter = 1;      // Diameter of the pins
pin_zinn_diameter = 2;      // Diameter of the pins
pin_spacing = 2.5;         // Spacing between pins
pin_count = 6;           // Number of pins
mounting_hole_diameter = 3; // Diameter of mounting holes
mounting_hole_outerd = 5.1; // Diameter of mounting holes
eps = .00001;
labels = ["Vin","GND","SCL","SDA","GPIO01", "XSHUT"];

// Call the module
VL53L0X_mockup();
module VL53L0X_mockup() {
  // Draw PCB
  // Body of the module
  difference() {
    color("green") 
      union()
      {
        translate([-pcb_length/2,-pcb_width/2,0])
          cube([pcb_length, pcb_width, pcb_thickness]);
        // Mounting holes on the side
        translate([pcb_length/2-mounting_hole_outerd/2, -mounting_hole_outerd/2, 0])
          cube([mounting_hole_outerd, mounting_hole_outerd,pcb_thickness]);
        translate([pcb_length/2+mounting_hole_outerd/2, 0, 0])
          cylinder(d = mounting_hole_outerd, h = pcb_thickness, $fn = 100);
        //left
        translate([-pcb_length/2-mounting_hole_outerd/2, -mounting_hole_outerd/2, 0])
          cube([mounting_hole_outerd, mounting_hole_outerd,pcb_thickness]);
        translate([-pcb_length/2-mounting_hole_outerd/2, 0, 0])
          cylinder(d = mounting_hole_outerd, h = pcb_thickness, $fn = 100);
      }

    union()
    {
      // Mounting holes on the side
      color("red") 
        translate([pcb_length/2+mounting_hole_outerd/2, 0, 0])
        cylinder(d = mounting_hole_diameter, h = 3*pcb_width, $fn = 100, center = true);
      color("red") 
        translate([-pcb_length/2-mounting_hole_outerd/2, 0, 0])
        cylinder(d = mounting_hole_diameter, h = 3*pcb_width, $fn = 100, center = true);
    }
  }

  // Draw pcb lens
  translate([-sensor[0]/2, 1.0, pcb_thickness-eps])
    color("black") 
    cube(sensor);
  //calibration block for the exact sensor height
  //translate([-2.5, -pcb_width/2, pcb_thickness-eps]) %cube([5,8.8,5], center = false);

  // Pins
  translate([(pin_spacing+pin_zinn_diameter)/4, 0,0])
    for (i = [0 : pin_count - 1]) {
      translate([ - pin_count * pin_spacing / 2 + i * pin_spacing, - pcb_width/2 + 2, 0])
      {
        translate([0, 0, -5.9])
          cylinder(d = pin_diameter, h = pcb_thickness + 6);

        color("yellow")
          translate([0, 0, pcb_thickness/2])
          {
          cylinder(d = pin_zinn_diameter, h = pcb_thickness + eps, center = true,  $fn = 90);
          translate([-pin_zinn_diameter/4, - pin_zinn_diameter, -pcb_thickness/2-eps])
          rotate([0,0,-90])
          %linear_extrude(height= pcb_thickness+2*eps)
          text(labels[i], size= 1);
          }
      }
    }
}



