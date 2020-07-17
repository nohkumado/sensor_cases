pin(len = 8, angle = 90, mask = 0);
translate([-10,0,0])pinrow(num = 4,len = 8, angle = 90, mask = 0);

translate([12,0,0])xh2_54f(num = 4, mask = 0);
translate([0,20,0])
{
pin(len = 8, angle = 90, mask = 1);
translate([-10,0,0])pinrow(num = 4,len = 8, angle = 90, mask = 1);

translate([12,0,0])xh2_54f(num = 4, mask = 1);
}
module pin(len = 7, angle = 0, mask = 0)
{
  pins = (mask == 0)? 0.70: 2.75;
  cube([2.75,2.75,3], center = true); //plastic cube
  cube([pins,pins,6], center = true); //transverse
  translate([(angle != 0)?len/2*sin(angle):0,0,(angle != 0)?len/2*cos(angle)-0.35+3:3])
    rotate([0,angle,0])
    cube([pins,pins,len+mask], center = true); //transverse

}

module pinrow(num = 4,len = 7, angle = 0, mask = 0)
{
  for(y =  [0:num-1])
    translate([0,y*2.75,0])pin(len,angle, mask = mask);
}
module xh2_54f(num = 4, mask = 0)
{
  for(x =  [0:num-1])
    translate([x*2.75,0,0])pin(len = 3.5, mask = mask);
  translate([num*2.75/2-2.75/2,0,2+mask/2])
  {
    difference()
    {
      cube([(num+0.5)*2.75+2, 5.7+2,7+mask], center = true);
      if(mask == 0)
      union()
      {
        translate([0,0,3])
          cube([(num+0.5)*2.75, 5.7,7], center = true);
        translate([0,-2,3])
          cube([4, 5.7,7], center = true);
      }
    }
  }
}
