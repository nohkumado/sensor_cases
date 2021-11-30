use <../jsn_hr04/pcb_connector.scad>
use <../snapfitProfile.scad>
//color("red")
translate([-0,0,20]) 
rotate([0,180,0])
//translate([-75,-0,0]) 
HCSR04lid(2,2.1);
//translate([0,-12,0.0]) 
color("blue")
HCSR04case(2);
%translate([0,0,12.0]) rotate([0,180,180])HCSR04(mask = 0);


// color("black")
//         snapLid(len = 30, width = 2,offset = 1, heigth = 10, twoside = false);

function HCSR04CaseDim() = [//base mesure
    52,  //breite
    28,  //hoehe
    17,  //sbreite //cable outlet mesures
    21 ];//shoehe  
module HCSR04case(dicke = 2, heigth =16, offset = 0)    
{
  breite = HCSR04CaseDim()[0]; hoehe = HCSR04CaseDim()[1];//base mesure
  sbreite = HCSR04CaseDim()[2]; shoehe = HCSR04CaseDim()[3]; //cable outlet mesures
  mittex = breite/2; mittey= hoehe/2;
  smittex = sbreite/2;


  difference()
  {
    //translate([breite/2,0,0])
     // rotate([90,0,180])
      union()
      {
        translate([-breite/2,-hoehe/2+dicke/2,dicke/2]) 
          rotate([90,0,90])
          snapWall(len = breite, width = 2,offset = 0,heigth = heigth);//back
        translate([-breite/2,hoehe/2-dicke/2,dicke/2]) //front left
          rotate([90,0,90])
          snapWall(len = mittex-smittex, width = 2,offset = 0, heigth = heigth);
        translate([(mittex-smittex)/2,hoehe/2-dicke/2,dicke/2]) //front right 
          rotate([90,0,90])
          snapWall(len = mittex-smittex, width = 2,offset = 0, heigth = heigth);
        translate([-breite/2,hoehe/2-dicke/2,dicke/2]) //middle
          rotate([90,0,90])
          snapWall(len = breite, width = 2,offset = 0, heigth = heigth-4.5);
        translate([-breite/2+dicke/2,hoehe/2,dicke/2]) //left border
          rotate([90,0,0])
          snapWall(len = hoehe, width = 2,offset = 0, heigth = heigth);
        translate([breite/2-dicke/2,hoehe/2,dicke/2])  //right
          rotate([90,0,0])
          snapWall(len = hoehe, width = 2,offset = 0, heigth = heigth);
        translate([-sbreite/2-dicke/2,hoehe/2+shoehe,heigth-6]) //front left cr
          rotate([90,0,0])
          snapWall(len = shoehe+dicke, width = 2,offset = 0, heigth = 5+dicke);
        translate([sbreite/2+dicke/2,hoehe/2+shoehe,heigth-6]) //front left cr
          rotate([90,0,0])
          snapWall(len = shoehe+dicke, width = 2,offset = 0, heigth = 5+dicke);
        //fond
        translate([0,0,dicke/2]) cube([breite,hoehe,dicke], center = true);
        //cable relief
        translate([0,hoehe/2+shoehe/2,heigth-4.5]) cube([sbreite,shoehe,dicke], center = true);   
        translate([breite/2-1.5*dicke,hoehe/2-1.5*dicke,0]) cylinder(d = 3*dicke, h = 11, $fn = 4);
        translate([breite/2-1.5*dicke,-hoehe/2+1.5*dicke,0]) cylinder(d = 3*dicke, h = 11, $fn = 4);
        translate([-breite/2+1.5*dicke,-hoehe/2+1.5*dicke,0]) cylinder(d = 3*dicke, h = 11, $fn = 4);
        translate([-breite/2+1.5*dicke,+hoehe/2-1.5*dicke,0]) cylinder(d = 3*dicke, h = 11, $fn = 4);
       
      }
    union()
    {
        translate([-13.5,0,-12]) cylinder(d=16.5,h=15,$fn=64);
        translate([13.5,0,-12]) cylinder(d=16.5,h=15,$fn=64);
        //translate([17,2,-5]) cube([13,5,5]);
    }
  }


}

module HCSR04lid(dicke,ausweitung)
{
  breite = HCSR04CaseDim()[0]; hoehe = HCSR04CaseDim()[1];//base mesure
  sbreite = HCSR04CaseDim()[2]; shoehe = HCSR04CaseDim()[3]; //cable outlet mesures
  mittex = breite/2; mittey= hoehe/2;
  smittex = sbreite/2;

  outw = breite+2*ausweitung;

  union()
  {
    translate([-ausweitung/2+dicke/2,-hoehe/2+ausweitung-dicke/2,12.2])//back 
rotate([0,180,90])
        snapLid(len = outw, width = 2,offset = ausweitung, heigth = 8+ausweitung, twoside = false);
    translate([-(breite-sbreite)/2-ausweitung,hoehe/2-ausweitung/2,12.2])//crl 
rotate([180,000,090])
        snapLid(len = mittex-smittex, width = 2,offset = ausweitung, heigth = 8+ausweitung);
    translate([(breite-sbreite)/2+ausweitung,hoehe/2-ausweitung/2,12.2]) //crr
rotate([180,000,090])
        snapLid(len = mittex-smittex, width = 2,offset = ausweitung, heigth = 8+ausweitung);
    translate([breite/2-ausweitung/2,0,12.2]) 
rotate([180,000,000])
        snapLid(len = hoehe+3*ausweitung, width = 2,offset = ausweitung, heigth = 8+ausweitung);
      color("magenta")
    translate([-breite/2+ausweitung/2,0,0]) 
rotate([0,000,180])
        snapLid(len = hoehe+3*ausweitung, width = 2,offset = ausweitung, heigth = 8+ausweitung);
    translate([mittex+smittex-1+ausweitung,0,hoehe+2*ausweitung]) 
        snapLid(len = shoehe+ausweitung, width = 2,offset = ausweitung, heigth = 8+ausweitung);
    translate([mittex-smittex-ausweitung+1,0,hoehe+2*ausweitung]) 
        snapLid(len = shoehe+ausweitung, width = 2,offset = ausweitung, heigth = 8+ausweitung);
    //cover
    translate([0,0 ,dicke/2]) cube([breite+2*ausweitung,hoehe+2*ausweitung,dicke], center = true);
//cable relief cover
    translate([0,(hoehe+shoehe)/2+ausweitung,dicke/2]) cube([sbreite+2*ausweitung,shoehe,dicke], center = true);   
  }
}

function HCSR04dim() = [45.4,20.4,2];
module HCSR04(mask = 0)
{
  dim = HCSR04dim();
  breite = dim[0]; hoehe = dim[1];
  qw = 11; qh = 4; qt = 3.8; //quwartz
  deckeldicke  = dim[2];
  cr = 16+mask;
  holeOff = 1.5; holed = 1.4;
  holex = breite/2-holeOff;
  holey = hoehe/2-holeOff;

  union()
  {
    difference()
    {
      cube([breite+2*mask,hoehe+2*mask,deckeldicke], center = true); //backplane
        if(mask == 0)
          for(i = [0:3]) 
            translate([(i%2 == 0)?-holex:holex, (i>1) ? -holey:holey, -2])
              cylinder(d= holed, h = deckeldicke+5, $fn = 10);
    }
    translate([mask/2,(hoehe+mask)/2-qh/2-1,1+(qh+mask)/2]) 
      cube([qw+2*mask,qh+2*mask,qt+2*mask], center = true);//quarz
    //translate([-23.5,0,2.5]) 
    //rotate([90,0,0])
    {
      translate([-breite/2+1.2+cr/2,0,deckeldicke/2]) cylinder(d=cr,h=12+mask,$fn=64);
      translate([breite/2-1.2-cr/2,0,deckeldicke/2])  cylinder(d=cr,h=12+mask,$fn=64);
    }
    translate([4,-hoehe/2+2,-2]) 
      rotate([0,180,90])
      pinrow(num = 4,len = 8, angle = 90, mask = mask);
  }
    linear_extrude(1.1)
    {
      translate([-3,-hoehe/2+4,1.5]) rotate([0,0,90]) text("Vcc", size = 2.5);
      translate([-0,-hoehe/2+4,1.5]) rotate([0,0,90]) text("Trig", size = 2.5);
      translate([ 3,-hoehe/2+4,1.5]) rotate([0,0,90]) text("Echo", size = 2.5);
      translate([ 6,-hoehe/2+4,1.5]) rotate([0,0,90]) text("GND", size = 2.5);
    }
     if(mask != 0)
       for(i = [0:3]) 
         translate([(i%2 == 0)?-holex:holex, (i>1) ? -holey:holey, -2-(5+mask)/2])
           cylinder(d= holed, h = 5+mask, $fn = 10);
}
