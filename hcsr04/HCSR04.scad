use <../jsn_hr04/pcb_connector.scad>
color("red")
//translate([-0,-2,10]) rotate([0,180,0])
translate([-75,-0,0]) 
HCSR04lid(2,2.1);
color("blue")
translate([75,-0,3.0]) HCSR04case(5);
HCSR04(mask = 0);

module HCSR04case(dicke)    
{
  difference()
  {
      //translate([80,0,1]) 
        //rotate([0,0,180]) translate([-51,-2,-1])  
       HCSR04lid(dicke,0);
      //cube([50,2,25]);

    union()
    {
      translate([-23.5,0,2.5]) 
      //rotate([90,0,0])
      {
        translate([10,12,-12]) cylinder(d=16.5,h=15,$fn=64);
        translate([37,12,-12]) cylinder(d=16.5,h=15,$fn=64);
        translate([17,2,-5]) cube([13,5,5]);
      }

    }
  }


}

module HCSR04lid(deckeldicke,ausweitung)
{
  breite = 52; hoehe = 28;
  sbreite = 17; shoehe = 21;
  mittex = breite/2; mittey= hoehe/2;
  smittex = sbreite/2;
  translate([breite/2,0,0])
  rotate([90,0,180])
  union()
  {
    translate([-ausweitung,0,0]) cube([breite+2*ausweitung,8+ausweitung,2]);
    translate([-ausweitung,0,hoehe-2+2*ausweitung]) 
      cube([mittex-smittex+2,8+ausweitung,2]);
    translate([mittex+smittex-2+ausweitung,0,hoehe-2+2*ausweitung]) cube([mittex-smittex+ausweitung/2,8+ausweitung,2]);
    translate([-ausweitung,0,0]) cube([2,8+ausweitung,hoehe+2*ausweitung]);
    translate([breite-2+ausweitung,0,0]) cube([2,8+ausweitung,hoehe+2*ausweitung]);
    translate([mittex+smittex-2+ausweitung,0,hoehe+2*ausweitung]) cube([2,8+ausweitung,shoehe+ausweitung]);
    translate([mittex-smittex-ausweitung,0,hoehe+2*ausweitung]) cube([2,8+ausweitung,shoehe+ausweitung]);
    //fond
    translate([-ausweitung,2-deckeldicke ,0]) cube([breite+2*ausweitung,deckeldicke,hoehe+2*ausweitung]);
    translate([(mittex-sbreite/2)-ausweitung,2-deckeldicke,hoehe+2*ausweitung]) cube([sbreite+2*ausweitung,deckeldicke,shoehe+ausweitung]);   
  }
}

function HCSR04dim() = [52,28,2];
module HCSR04(mask = 0)
{
  dim = HCSR04dim();
  breite = dim[0]; hoehe = dim[1];
  qw = 11; qh = 4; qt = 3.8; //quwartz
  deckeldicke  = dim[2];
  cr = 16+mask;
  union()
  {
      cube([breite+2*mask,hoehe+2*mask,deckeldicke], center = true); //backplane
    translate([mask/2,(hoehe+mask)/2-qh/2-1,1+(qh+mask)/2]) 
      cube([qw+2*mask,qh+2*mask,qt+2*mask], center = true);//quarz
    //translate([-23.5,0,2.5]) 
    //rotate([90,0,0])
    {
      translate([-breite/2+2+cr/2,0,deckeldicke/2]) cylinder(d=cr,h=12+mask,$fn=64);
      translate([breite/2-2-cr/2,0,deckeldicke/2])  cylinder(d=cr,h=12+mask,$fn=64);
    }
    translate([4,-hoehe/2+2,-2]) 
      rotate([0,180,90])
      pinrow(num = 4,len = 8, angle = 90, mask = mask);
  }
    color("magenta")
linear_extrude(1.1)
{
translate([-3,-hoehe/2+4,1.5]) rotate([0,0,90]) text("Vcc", size = 2.5);
translate([-0,-hoehe/2+4,1.5]) rotate([0,0,90]) text("Trig", size = 2.5);
translate([ 3,-hoehe/2+4,1.5]) rotate([0,0,90]) text("Echo", size = 2.5);
translate([ 6,-hoehe/2+4,1.5]) rotate([0,0,90]) text("GND", size = 2.5);
}
}
