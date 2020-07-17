cylinder(h=18.5, d1=21.4, d2=21.6);
translate([0,0,18.5])cylinder(h=1.5, d=24);
CubePoints = [
  [  0,  0, 0 ],  //0
  [  4,  0, 0 ],  //1
  [  4,  0, 12 ],  //2
  [  0,  0, 12 ],  //3
  [  0,  1.5, 12 ],  //4
  [  4,  1.5, 12 ],  //5
  ]; //7
  
CubeFaces = [
  [0,3,2,1],  // back
  [0,1,5,4],  // front
  [1,2,5,1],  // left side
  [0,4,3,0],  // right
  [2,3,4,5],  // top
  ];
  
translate([-10.5,-2,6])
rotate([0,0,90])
polyhedron( CubePoints, CubeFaces );
translate([10.5,2,6])
rotate([0,0,-90])
polyhedron( CubePoints, CubeFaces );
translate([-2,10.5,6])
rotate([0,0,00])
polyhedron( CubePoints, CubeFaces );
translate([2,-10.5,6])
rotate([0,0,180])
polyhedron( CubePoints, CubeFaces );

