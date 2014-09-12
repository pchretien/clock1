
motor_h = 40;
base_thickness = 3;

bearing_r = 8.5;
bearing_h = 6;
bearing_wall = 3;
bearing_heigth = (motor_h/2)+base_thickness;

body_w = 2*bearing_r+2*bearing_wall;

feet_h = 3;
feet_l = 15;


module body()
{
	cube([body_w, bearing_h, bearing_heigth + bearing_r + (body_w-(2*bearing_r))/2]);
}

module bearing()
{
	translate([body_w/2, bearing_h+1, bearing_heigth])
		rotate(a=90, v=[1,0,0])
			cylinder(r=bearing_r, h=bearing_h+2);
}

module feet()
{
	difference()
	{
		translate([0, -1*feet_l, 0])
			cube([body_w, feet_l, feet_h]);

		translate([body_w/2, -1*feet_l/2, -1])
			cylinder(r=1.5, h=feet_h+2);
	}
}


difference()
{
	union()
	{
		body();
		feet();	
	}

	bearing();
}