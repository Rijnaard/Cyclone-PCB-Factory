use<X_carriage_YOP.scad>
M8_nut_diameter = 1 + 14.6;
M8_nut_height_X = 1+6.3;
$fn = 64;
springLenght = 15;
totalLenghtHole = M8_nut_height_X*2+springLenght;
wallThickness = 8;


module nutHole1(){
	cylinder(r=M8_nut_diameter/2,h=M8_nut_height_X,$fn=6,center=true);
}
module rodHole(){
	cylinder(r=8/2,h=(totalLenghtHole)*2,center=true);
}
module springSpace(){
	translate([0,0,M8_nut_height_X/2 + springLenght/2])
	cylinder(r=M8_nut_diameter/2,h=springLenght,$fn=6,center=true);
}
module nutHole2(){
	translate([0,0,M8_nut_height_X + springLenght])
	nutHole1();
}
module hole(){
	nutHole1();
	%springSpace();
	nutHole2();	
}
module holeInCage(){
	translate([0,0,-totalLenghtHole/2 + M8_nut_height_X/2])
	hull(){
		hole();
		translate([M8_nut_diameter/2+20,0,0])
			hole();
	}
}

module cage(){
cubeSize = M8_nut_diameter + wallThickness;
	translate([0,0,0])
	cube([19,25,totalLenghtHole],center = true);
		*cylinder(r=M8_nut_diameter/2 + wallThickness,h=totalLenghtHole,$fn=6,center=true);
		*cube([19,cubeSize, totalLenghtHole],center=true);
		*cylinder(r=M8_nut_diameter/2 + wallThickness, h=totalLenghtHole);
	
	//tapa
	*translate([0,0,-totalLenghtHole/2 - wallThickness])
		cube([cubeSize,cubeSize, wallThickness],center=true);
}

module antiBackSlash(){
	difference(){
		cage();
		#rotate([0,0,120])	
		holeInCage();
		rodHole();
	}
}
antiBackSlash();
rotate([90,0,90])
translate([0,22.5,0])
X_nut_holder_cover_v12();

