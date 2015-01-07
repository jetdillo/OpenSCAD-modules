hole_arr=[[8,2,8],[0,2,8],[-8,2,8],[8,2,0],[0,2,0],[-8,2,0],[8,2,-8],[0,2,-8],[-8,2,-8]];
nut_socket=[[8,-5.5,8],[0,-5.5,8],[-8,-5.5,8],[8,-5.5,0],[0,-5.5,0],[-8,-5.5,0],[8,-5.5,-8],[0,-5.5,-8],[-8,-5.5,-8]];

module bioloid_holes(hole_len,has_socket) {

for (i=[0:9]) {
        
       translate(hole_arr[i]) rotate([90,0,0]) cylinder(r=1,h=hole_len,center=true,$fn=10);
        if (with_socket==true) { 
           translate(nut_socket[i]) rotate([90,0,0]) cylinder(r=2.25,h=10,center=true,$fn=6);
        }
  
   }  
}

difference() {

    rotate([-90,0,0]) cube([30,30,2],center=true);
     bioloid_holes(20,false);
}