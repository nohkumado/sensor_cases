color("red")
//translate([-0,-2,10]) rotate([0,180,0])
translate([-55,-0,0]) 
HCSR04lid(2,2.1);
translate([0,-0,3.0]) 
HCSR04case(5);

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
