use <pcb_connector.scad>

jsnhr04controler(mask = 1);
module jsnhr04controler(mask = 0)
{
  breite = 41.5;
  hoehe = 28.5;
  holed = 2.5;
  holeOff = 2.65;
  holex = breite/2-holeOff;
  holey = hoehe/2-holeOff;

  difference()
  {
    cube([breite,hoehe,1.5], center = true);
    if(mask == 0)
      for(i = [0:3]) 
        translate([(i%2 == 0)?-holex:holex, (i>1) ? -holey:holey, -2])
          cylinder(d= holed, h = 5, $fn = 10);
  }
  if(mask != 0)
    for(i = [0:3]) 
      translate([(i%2 == 0)?-holex:holex, (i>1) ? -holey:holey, -2-(5+mask)/2])
        cylinder(d= holed, h = 5+mask, $fn = 10);
  translate([-breite/2+7.5/2+1, hoehe/2-8,9.5/2+mask/2+0.75])
  {
    difference()
    {
      cube([7.5,7.5,9.5+mask], center = true);
      union()
      {
        color("blue")
          translate([0,0,4.7]) cylinder(h=1,d= 7, $fn = 30);
        translate([0,0,4.7]) cube([5,2,5], center = true);
      }
    }

  }

  translate([-4,-hoehe/2+2,2]) rotate([0,0,-90])pinrow(num = 4,len = 8, angle = 90, mask = mask);

  //color("magenta")
  translate([-2,-0,-2]) rotate([180,0,-00]) xh2_54f(num = 2, mask = mask);
}
