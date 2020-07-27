jsnSoundadapter(outd = 40, holes = 6);
translate([45,0,0]) jsnSoundadapter(outd = 40, holes = 6,h= 20);
translate([90,0,0]) jsnSoundadapter(outd = 40, holes = 6,h= 30);
translate([135,0,0]) jsnSoundadapter(outd = 40, holes = 6,h= 40);

translate([0,45,0]) jsnSoundTube(outd = 40, holes = 3,h= 20, tubed = 9);
translate([45,45,0]) jsnSoundTube(outd = 40, holes = 3,h= 30, tubed = 9);
translate([90,45,0]) jsnSoundTube(outd = 40, holes = 3,h= 40, tubed = 9);
translate([135,45,0]) jsnSoundTube(outd = 40, holes = 3,h= 50, tubed = 9);

translate([0,-45,0]) jsnSoundTube(outd = 40, holes = 3,h= 30, tubed = 30);
translate([45,-45,0]) jsnSoundTube(outd = 40, holes = 3,h= 40, tubed = 30);
translate([90,-45,0]) jsnSoundTube(outd = 40, holes = 3,h= 50, tubed = 30);
translate([135,-45,0]) jsnSoundTube(outd = 40, holes = 3,h= 60, tubed = 30);



module jsnSoundTube(outd = 50, holes = 3, shell = 2, h = 10, tubed = 9)
{
  jsnd = 24;
  adh =  abs(tubed-jsnd)*tan(45);
  echo("tan ",adh);
  jsnSoundadapter(outd = 40, holes = 3, h = 0);
  translate([0,0,shell])
  {
    difference()
    {
      cylinder(d1 = jsnd+2*shell, d2 = tubed+2*shell, h = adh);
      translate([0,0,-.01])
        cylinder(d1 = jsnd, d2 = tubed, h = adh+.02);
    }
    translate([0,0,adh])
    {
      difference()
      {
        cylinder(d = tubed+2*shell, h = h);
        union()
        {
          translate([0,0,-.01])
            cylinder(d = tubed, h = h+.01);
          tubey = 1.5*tubed;
          color("magenta")
            translate([0,0,h+tubey/2-tubed*sin(45)/4])
            //translate([0,0,h+tubey/2])
            rotate([45,0])
            cube([1.5*tubed,tubey,4*tubed], center = true);
        }
      }
    }
  }
}
module jsnSoundadapter(outd = 50, holes = 3, shell = 2, h = 10)
{
  jsnd = 24;
  linear_extrude(height = shell)
    difference()
    {
      circle(d = outd);
      union()
      {
        circle(d = jsnd);
        for(w = [0:360/holes:360]) rotate([0,0,w])translate([jsnd/4+outd/4,0,0])circle(d=3);
      }
    }
  translate([0,0,shell])
    linear_extrude(height = h)
    difference()
    {
      circle(d = jsnd+shell);
      union()
      {
        circle(d = jsnd);
      }
    }
}
