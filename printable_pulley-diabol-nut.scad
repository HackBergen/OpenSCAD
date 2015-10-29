//variables (mm)
bearingOD = 6;// bearing diameter
bearingwidth = 20;
beltwidth= 1;

skrufestetykkelse = 12;

m3_dia = 3.2;		// 3mm hole diameter
m3_nut_hex = 1;		// 1 for hex, 0 for square nut
m3_nut_flats = 5.7;	// normal M3 hex nut exact width = 5.5
m3_nut_depth = 2.7;	// normal M3 hex nut exact depth = 2.4, nyloc = 4
no_of_nuts = 2;		// number of captive nuts required, standard = 1
nut_angle = 90;		// angle between nuts, standard = 90
nut_shaft_distance = 1.2;	// distance between inner face of nut and shaft, can be negative.
pulley_b_dia = 20;	// pulley base diameter, standard = 20
motor_shaft = 5.2;	// NEMA17 motor shaft exact diameter = 5
pulley_b_ht = 8;		// pulley base height, standard = 8. Set to same as idler_ht if you want an idler but no pulley.

nut_elevation = pulley_b_ht/2;
m3_nut_points = 2*((m3_nut_flats/2)/cos(30)); // This is needed for the nut trap



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
        
        // base for skrufeste
translate([0,0,skrufestetykkelse+1])
difference() {

    rotate_extrude($fn=pulley_b_dia*2)
        {
            square([pulley_b_dia/2-1,pulley_b_ht]);
            square([pulley_b_dia/2,pulley_b_ht-1]);
            translate([pulley_b_dia/2-1,pulley_b_ht-1]) circle(1);
        }
        for(j=[1:no_of_nuts]) rotate([0,0,j*nut_angle])
            translate([0,0,nut_elevation])rotate([90,0,0])

            union()
            {
                //entrance
                translate([0,(-pulley_b_ht/4-0.5)+5,motor_shaft/2+m3_nut_depth/2+nut_shaft_distance])           cube([m3_nut_flats,pulley_b_ht/2+1,m3_nut_depth],center=true);

                //nut
                if ( m3_nut_hex > 0 )
                {
                    // hex nut
                    translate([0,0.25,motor_shaft/2+m3_nut_depth/2+nut_shaft_distance]) rotate([0,0,30]) cylinder(r=m3_nut_points/2,h=m3_nut_depth,center=true,$fn=6);
                } else {
                    // square nut
                    translate([0,0.25,motor_shaft/2+m3_nut_depth/2+nut_shaft_distance]) cube([m3_nut_flats,m3_nut_flats,m3_nut_depth],center=true);
                }
	
                //grub screw hole
                rotate([0,0,22.5])cylinder(r=m3_dia/2,h=pulley_b_dia/2+1,$fn=12);
            }
        }
        
        
            //cylinder(r=lipheight+idlerOD/2, h=lipthickness);
        cylinder(r=idlerOD/2, h = lipthickness*2+beltwidth+lipheight*cos(topangle));
        translate([0,0,lipthickness+beltwidth+lipheight*cos(topangle)])cylinder(r=lipheight+idlerOD/2, h=lipthickness);
		translate([0,0,beltwidth+lipthickness])cylinder(r1=idlerOD/2, r2=lipheight+idlerOD/2, h=lipheight*cos(topangle));
        
        translate([0,0,-(lipthickness+lipheight*cos(topangle))])cylinder(r=lipheight+idlerOD/2, h=lipthickness);
		translate([0,0,-(lipheight*cos(topangle))])cylinder(r2=idlerOD/2, r1=lipheight+idlerOD/2, h=lipheight*cos(topangle));
    }
    //Senterhull
        translate([0,0,-(bearingwidth+(lipthickness*2)+beltwidth)/2])cylinder(r=idlerID/2, h=bearingwidth+(lipthickness*2)+beltwidth+10);
            // inner lip to hold bearing
		//translate([0,0,-1])cylinder(r=idlerID/2-1, h=bearingwidth);
}