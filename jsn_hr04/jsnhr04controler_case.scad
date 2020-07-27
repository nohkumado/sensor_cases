use <controler_mockup.scad>
width = 47; //case width
heigth  = 35; //case height
z = 18;       //case volu8me
shell  = 2; //thickness of wall



//color("red")
jsnhr04_case();
translate([0,1.5*heigth,0])jsnhr04_lid();



module jsnhr04_lid(d = shell,offset = .5)
{
  dicke = d+offset;
      translate([0,0,1.5*shell])
  difference()
  {
    cube([width+shell,heigth+shell,3*shell], center = true);
    union()
    {
      translate([0,0,shell])
        cube([width-3*shell,heigth-3*shell,3*shell], center = true);
        translate([width/2-shell/2,0,1.5*shell+.1])
        rotate([-90,00,0])
        insert(len = heigth, d = shell,offset = offset);
        translate([-width/2+shell/2,0,1.5*shell+.1])
        rotate([-90,00,0])
        insert(len = heigth, d = shell,offset = offset);
        translate([0,heigth/2-shell/2,1.5*shell+.1])
         rotate([0,00,90])
         rotate([-90,00,0])
         insert(len = width+2, d = shell,offset = offset);
        translate([0,-heigth/2+shell/2,1.5*shell+.1])
        rotate([0,00,90])
        rotate([-90,00,0])
        insert(len = width, d = shell,offset = offset);
    }
  }
}

module lasche(d = z, hole = 3, h = shell)
{
linear_extrude(height = h)
   difference()
   {
     circle(d= d, $fn = 30);
     union()
     {
       translate([-d/2,0,0]) square(d);
       translate([0,-d/4,0]) circle(d = hole);
     }
   }
}




module insert(len = 10,d = 10,offset = .2)
{
  dicke = d+offset;
  poly = [
    [0,0],
    [dicke/2,0],
    [shell/2,shell/2],
    [dicke/2,2*shell],
    [0,2*shell],
  ];
    translate([0,0,-(len+offset)/2])
    linear_extrude(height = len+offset)
    {
      polygon(poly);
      mirror([1,0,0])
        polygon(poly);
    }
}
module jsnhr04_case()
{
  difference()
  {
    translate([0,0,z/2])
      difference()
      {
        cube([width,heigth,z], center = true);

        translate([0,0,2])
          cube([width-2*shell,heigth-2*shell,z], center = true);
      }
    union()
    {
      translate([0,0,shell+3.5])
        jsnhr04controler(mask = 1);
      translate([0,-heigth/2,z/2+1.15])cube([12,15,3], center = true);
    }
  }
  translate([0,0,shell+1.5])
    difference()
    {
      jsnhr04controlerpads(mask = 3, h = 2);
      translate([0,0,.1])
        jsnhr04controlerpads(mask = -1, h = 2);
    }
  translate([width/2,heigth/2-shell,z/2])rotate([0,90,90])lasche();
  translate([-width/2,heigth/2,z/2])rotate([0,90,-90])lasche();
  //color("blue")
}
