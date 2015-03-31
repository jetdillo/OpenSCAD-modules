/*
Housing for an IOIO OTG board. 
The side mounting brackets are modeled for a Samsung Galaxy S4, based on a difference operation from the S4 model STL. It is suggested that this approach be followed if you want the mounting brackets to fit another phone. 
(Mostly) parameterized to allow for attaching to other phones.


*/ 

USE_BACK_BRACKET=0;
USE_SIDE_BRACKET=1;
USE_CARRIER=0;
USE_SHELL=1;
USE_BOARD=0;
USE_S4=1;

CASE_X=45;
CASE_Y=70;
CASE_Z=10.0;



include <case_lid.scad>

module s4(){
import("/Users/dillo/Documents/models/Galaxy_S4_Mockup.stl");
}

module ioio_board() {
    import("/Users/dillo/Documents/models/ioio_board_block_headers.stl");
}



module carrier() {
 $fn=100;  
 difference() {  
  difference() {   
   minkowski(){
      sphere(r=3,h=3.0);
      cube([45,70,10.0]);
   }
   scale([0.98,0.98,0.98]) minkowski(){
      sphere(r=3,h=3.0);
      cube([CASE_X,CASE_Y,CASE_Z]);
   }
  }
 }
}

module carrier_shell() {
    
    difference() {
        carrier();
        translate([-10,-15,-20]) cube([CASE_X+15,CASE_Y+20,CASE_Z*2]);
    }
}  

module s4_bottom_shell() {
  difference() {
   difference() {
    s4();
   translate([-40,-80,5]) cube([100,150,10]);
   }
   translate([0.0,0.0,0.5]) scale([0.95,0.95,0.95]) s4();
  }
}

module s4_side_bracket() {
    difference() {
	    s4_bottom_shell();
        translate([-50,20,-5]) cube([100,80,15]);
        translate([-50,-70,-5]) cube([100,80,15]);
    }
}

module s4_back_bracket() {
    $fn=100;
    difference() {
	intersection() {
	   s4_bottom_shell();
       translate([-15,-70,-3]) cube([30,150,10]);
    }
   translate([0,-59.4,2.5]) scale([8,1.5,1.5]) cylinder(r=5,h=5);
   translate([0,59.4,2.5]) scale([8,1.5,1.5]) cylinder(r=5,h=5);
   }
    
}

module carrier_lid() {
      
    case_lid(CASE_X,CASE_Y,CASE_Z,9,true);
   
}


if (USE_S4 == 1) { 
    s4();
}

difference() {
    if  (USE_CARRIER==1) {
       translate([-22.0,-55.0,-15.0]) carrier();
    } 
    if (USE_SHELL == 1) { 
        translate([-21.0,-55.0,-15.0]) carrier_shell();
        //translate([10,-38,-10]) rotate([0,180,0]) ioio_board();
    }
}

//translate([10,-38,-10]) rotate([0,180,0]) ioio_board();


//rotate([180,0,0])
if (USE_SIDE_BRACKET == 1) { 
    scale([1.05,2.0,2.0]) translate([0,-15,-0.5]) s4_side_bracket();
    scale([1.05,2.0,2.0]) translate([0,-35,-0.5]) s4_side_bracket();
}

if (USE_BACK_BRACKET == 1) { 
difference() {
             s4_back_bracket();
             scale([0.85,0.85,1.0]) translate([-5.25,56.25,0]);    
             minkowski(){
                 sphere(r=3,h=3.0);
                 cube([10,10,5.0]);
             }
         }
    }
   
$fn=100;   
difference() { 
translate([2,-20,-11]) rotate([0,180,0]) case_lid(CASE_X,CASE_Y,CASE_Z,9,true);
    rotate([0,180,0]) translate([-10,-40,12]) ioio_board();
}
    
    
    
   