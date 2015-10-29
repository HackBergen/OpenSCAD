//variables (mm)
bearingOD = 6;// bearing diameter
bearingwidth = 20;
beltwidth= 1;

slopfactor = .0; // it printed a bit tight on my printer so i added this slop factor to make the hole slightly looser.. you may not need it

thickness = 2;

	idlerID = bearingOD + slopfactor; 

	idlerOD = idlerID+thickness;
	$fn=30; //faceting

//these are the lips that hold the belt on
	lipheight = 10;
	lipthickness = 2;
	topangle = 30; //the angle the top lip overhang makes. You can increase this to lower the idler profile.

//construction
	difference(){
	union(){
            //cylinder(r=lipheight+idlerOD/2, h=lipthickness);
        cylinder(r=idlerOD/2, h = lipthickness*2+beltwidth+lipheight*cos(topangle));
        translate([0,0,lipthickness+beltwidth+lipheight*cos(topangle)])cylinder(r=lipheight+idlerOD/2, h=lipthickness);
		translate([0,0,beltwidth+lipthickness])cylinder(r1=idlerOD/2, r2=lipheight+idlerOD/2, h=lipheight*cos(topangle));
        
        translate([0,0,-((lipthickness+lipheight)*cos(topangle))])cylinder(r=lipheight+idlerOD/2, h=lipthickness);
		translate([0,0,-(lipheight*cos(topangle)-.2)])cylinder(r2=idlerOD/2, r1=lipheight+idlerOD/2, h=lipheight*cos(topangle));
    }
		translate([0,0,-(bearingwidth+(lipthickness*2)+beltwidth)/2])cylinder(r=idlerID/2, h=bearingwidth+(lipthickness*2)+beltwidth+2);
            // inner lip to hold bearing
		//translate([0,0,-1])cylinder(r=idlerID/2-1, h=bearingwidth);
}