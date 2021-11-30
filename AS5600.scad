use <../nohscadlib/fillet.scad>

//AS5600(center = true);
//translate([0,-40,0]) 
//AS5600_case(center = true, h = 5);
//translate([40,0,0]) 
//AS5600_lid(center = false, tol = .1, h = 8, wd = 2);
//translate([-40,0,0]) 
AS5600_stand(center = true, tol = .1, mask = 0.01,  holetol = 0.9, wd  =.5, h = 3);
//translate([0,40,0]) 
//AS5600_washer(center = false, tol = .1, mask = 0,  holetol = 0, wd  =2, h = 5);

module AS5600(center = false, tol = .1, mask = 0, noholes= false, holetol = 0)
{
  
  size = 23+2*tol;
  half = size/2;
  disp=(center)? 0:23/2;
  dispz=(center)? 0:(2+mask/2);
  hole = 2.4;
  holedt = (holetol == 0)? tol:holetol;
  holepos = (18.5-hole)/2;
  holed1 = (mask == 0)? hole-2*holedt:hole+holedt;
  holed2 = (mask == 0)? holed1:2*holed1/3;


  translate([-disp, -disp,dispz])
  {
    if(mask == 0)
    translate([0,0,1.99]) cube([5,3,2], center= true);
    difference()
    {
      union()
      {
      cube([size,size,2+mask], center= true);
    if(mask == 0)
      as5600pins(mask = 0);

      }
      union()
      {
          translate([-half,-half,-0]) rotate([0,0,-00])fillet(r= 3,h=5+mask, center = true);
          translate([-half,half,-0]) rotate([0,0,-90])fillet(r= 3,h=5+mask, center = true);
          translate([half,-half,-0]) rotate([0,0,90])fillet(r= 3,h=5+mask, center = true);
          translate([half,half,-0]) rotate([0,0,180])fillet(r= 3,h=5+mask, center = true);
          //Screwholes
          if(!noholes)
          {
          translate([-holepos,-holepos,-1]) cylinder(d1= holed1,d2= holed2,h=5+mask, center = true, $fn = 20);
          translate([-holepos,holepos,-1]) cylinder(d1= holed1,d2= holed2,h=5+mask, center = true, $fn = 20);
          translate([holepos,-holepos,-1]) cylinder(d1= holed1,d2= holed2,h=5+mask, center = true, $fn = 20);
          translate([holepos,holepos,-0]) cylinder(d1= holed1,d2= holed2,h=5+mask, center = true, $fn = 20);
          }
      }
    }
  }
}
module AS5600_case(center = false, tol = .1, h = 10, wd = 2)
{
  difference()
  {
    AS5600(center = true, mask = h+1*wd, tol=wd, noholes=true);//main body
    union()
    {
      color("red")
      translate([0,0,wd/2+.01]) AS5600(center = true, mask = h+wd, tol = 1, holetol = tol);//remove all but the stands
      translate([0,0,-wd]) cylinder(d=18, h=h+1*wd, center = true);
      color("blue")
      translate([0,0,h/2+.01]) AS5600(center = true, mask = wd, tol=-1*wd/6, noholes=true); //make place for the lid
    }
  }
}//module AS5600_case(center = false, tol = .1, h = 10)

module AS5600_lid(center = false, tol = .1, h = 10, wd = 1.2)
{
  lidh = (h-wd)/2;
  translate([0, 0,wd/2-.01])AS5600_stand(center = true, tol = .1, mask = 0.01,  holetol = 0.9, wd  =1, h = 5, base=false);
  //%translate([0, 0,2]) AS5600(center = true);
        //color("blue")
//translate([0, 0,lidh+2*wd])
  //        AS5600(center = true, mask = h+2*wd, tol=+2*tol, noholes=true);//main body placeholder
  difference()
  {
    union()
    {
      translate([0, 0,lidh]) AS5600(center = true, mask = h, tol=2*wd, noholes=true);
      translate([0, 0,0])as5600pins(mask = 2*wd, tol=2);
    }
    union()
    {
      translate([0, 0,2*wd-.01])as5600pins(mask = 5*wd, tol=.5);
translate([0, 0,lidh+wd])
      difference()
      {
        color("magenta")
          translate([0,0,wd/2+.01]) 
          AS5600(center = true, mask = h+1*wd, tol=wd+2*tol, noholes=true);//main body placeholder
   //    color("blue")
   //      translate([0,0,wd+.01]) 
   //      AS5600(center = true, mask = h+2*wd, tol=-2*tol, noholes=true);//main body placeholder
      }
    }
  }
}//module AS5600_case(center = false, tol = .1, h = 10)

module AS5600_stand(center = false, tol = .1, mask = 0,  holetol = 0, wd  =2, h = 5, base=true)
{
  
  size = 23+2*tol;
  half = size/2;
  disp=(center)? 0:23/2;
  dispz=(center)? 0:(2+mask/2);
  hole = 2.4;
  holedt = (holetol == 0)? tol:holetol;
  holepos = (18.5-hole)/2;
  holed1 = (mask == 0)? hole-2*holedt:hole+holedt;
  holed2 = (mask == 0)? holed1:2*holed1/3;

  translate([-disp, -disp,dispz])
  {

    difference()
    {
      union()
      {
      if(base)
      {
      difference()
      {
      cube([size,size,wd], center= true);
          translate([0,0,-0]) cylinder(d= 8,h=2*wd, center = true, $fn = 20);//magnetsensor hole

      }
      }
          translate([-holepos,-holepos,-0]) cylinder(d1= holed1,d2= holed2,h=h+mask, center = false, $fn = 20);
          translate([-holepos,holepos,-0]) cylinder(d1= holed1,d2= holed2,h=h+mask, center = false, $fn = 20);
          translate([holepos,-holepos,-0]) cylinder(d1= holed1,d2= holed2,h=h+mask, center = false, $fn = 20);
          translate([holepos,holepos,-0]) cylinder(d1= holed1,d2= holed2,h=h+mask, center = false, $fn = 20);
          }
      union()
      {
          translate([-half,-half,-0]) rotate([0,0,-00])fillet(r= 3,h=wd+1+mask, center = true);
          translate([-half,half,-0]) rotate([0,0,-90])fillet(r= 3,h=wd+1+mask, center = true);
          translate([half,-half,-0]) rotate([0,0,90])fillet(r= 3,h=wd+1+mask, center = true);
          translate([half,half,-0]) rotate([0,0,180])fillet(r= 3,h=wd+1+mask, center = true);
      }
    }
  }
}

module AS5600_washer(center = false, tol = .1, mask = 0,  holetol = 0, wd  =2, h = 5)
{
  
  size = 23+2*tol;
  half = size/2;
  disp=(center)? 0:23/2;
  dispz=(center)? 0:(2+mask/2);
  hole = 2.4;
  holedt = (holetol == 0)? tol:holetol;
  holepos = (18.5-hole)/2;
  holed1 = (mask == 0)? hole-2*holedt:hole+holedt;
  holed2 = (mask == 0)? holed1:2*holed1/3;

  %translate([0, 0,2]) AS5600();
  translate([-disp, -disp,dispz])
  {

    difference()
    {
      union()
      {
      cube([size-tol,size-tol,wd], center= true);
          }
      union()
      {
      translate([0,0,-wd]) cylinder(d=18, h=h+1*wd, center = true);
          translate([-half,-half,-0]) rotate([0,0,-00])fillet(r= 3,h=wd+1+mask, center = true);
          translate([-half,half,-0]) rotate([0,0,-90])fillet(r= 3,h=wd+1+mask, center = true);
          translate([half,-half,-0]) rotate([0,0,90])fillet(r= 3,h=wd+1+mask, center = true);
          translate([half,half,-0]) rotate([0,0,180])fillet(r= 3,h=wd+1+mask, center = true);
          translate([-holepos,-holepos,-wd-.1]) cylinder(d1= holed1,d2= holed2,h=h+mask, center = false, $fn = 20);
          translate([-holepos,holepos,-wd-.1]) cylinder(d1= holed1,d2= holed2,h=h+mask, center = false, $fn = 20);
          translate([holepos,-holepos,-wd-.1]) cylinder(d1= holed1,d2= holed2,h=h+mask, center = false, $fn = 20);
          translate([holepos,holepos,-wd-.1]) cylinder(d1= holed1,d2= holed2,h=h+mask, center = false, $fn = 20);
      }
    }
  }
}
module as5600pins(mask = 0, tol = .1)
{
  d= 2+mask;
  translate([0,6.6,-0.99-d/2]) 
  {
    color("red") cube([10.1+2*tol,2.4+2*tol,d], center= true);//pinbase
    if(mask == 0)
    color("black")
    {
      translate([-1.2,0,-4.0]) cube([0.5,0.5,8.2], center= true);//pin
      translate([-3.6,0,-4.0]) cube([0.5,0.5,8.2], center= true);//pin
      translate([1.2,0,-4.0]) cube([0.5,0.5,8.2], center= true);//pin
      translate([3.6,0,-4.0]) cube([0.5,0.5,8.2], center= true);//pin
    }
  }
  translate([0,-6.6,-0.99-d/2]) 
  {
    color("red") cube([7.3+2*tol,2.4+2*tol,d], center= true);//pinbase
    if(mask == 0)
    color("black")
    {
    translate([0,0,-4.0]) cube([0.5,0.5,8.2], center= true);//pin
    translate([-2.4,0,-4.0]) cube([0.5,0.5,8.2], center= true);//pin
    translate([2.4,0,-4.0]) cube([0.5,0.5,8.2], center= true);//pin
    }
  }
}
