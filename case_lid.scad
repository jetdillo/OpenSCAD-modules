HOLLOW_X=0.95;
HOLLOW_Y=0.95;
HOLLOW_Z=0.95;

module rounder(x,y,z,rad,hgt) {
    
    minkowski() {
    cube([x,y,z],center=true);
    sphere(r=rad,h=hgt,center=true);
    }
}

module rim(x,y,z,rad,hgt) {
   difference() { 
      difference() { 
          difference() { 
           rounder(x,y,z,rad,hgt);
           scale([HOLLOW_X,HOLLOW_Y,HOLLOW_Z]) rounder(x,y,z,rad,hgt);
          }
          translate([0,0,11]) cube([x+15,y+20,z*2],center=true);
       }
        translate([0,0,-11]) cube([x+15,y+20,z*2],center=true);
    }

}

module case_lip(casex,casey,casez,lipscale_x,lipscale_y,lipscale_z,is_rounded) {
    
    if (is_rounded==true) { 
        rim(casex*0.95,casey*0.95,casez*0.95,3,3);
    } else { 
    
            scale([lipscale_x,lipscale_y,lipscale_z])
            difference() {
                cube([casex,casey,casez],center=true);
                translate([0,0,2.0]) scale([HOLLOW_X,HOLLOW_Y,HOLLOW_Z]) cube([casex,casey,2*casez],center=true);
            }
    }
}
module case_lid(casex,casey,casez,cutz,is_rounded) {
  union() {   
    difference() {  
    union() {
        
     if(is_rounded==true) {    
         difference() { 
           rounder(casex,casey,casez,3,3);
           translate([0,0,casez*cutz]) cube([casex*2,casey*2,casez],       center=true);
         }
           rim(casex,casey,casez,3,3);
     } else {     
            difference() { 
               difference() { 
                  cube([casex,casey,casez],center=true);
                  scale([HOLLOW_X,HOLLOW_Y,HOLLOW_Z]) cube([casex,casey,casez],center=true);
               } 
              translate([0,0,-7]) cube([50,80,20],center=true);
            }
     translate([0,0,2]) case_lip(casex,casey,casez,HOLLOW_X,HOLLOW_Y,0.25);
     }
    }
    translate([0,0,-6]) cube([70,80,20],center=true);
  }  
   translate([0,0,3]) case_lip(casex,casey,casez,HOLLOW_X,HOLLOW_Y,0.25,true);
  }
}

//case_lid(45,70,10.00,9,true);





