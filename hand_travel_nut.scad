nut_radius = 5.5;
nut_length = 22;
nut_small_dia = 9.5;
nut_center_radius = 4.25;

end_padding = 5;
bottom_padding = 1;

base_width = 20;
base_length = nut_length + (2*end_padding);
base_thickness = bottom_padding + (2*nut_radius);

motor_h = 40;
top_clearance = motor_h/2;

patin_r = (motor_h/2)-(nut_radius);
patin_h = 3;

magnet_r = 6.1;
magnet_h = 3;
magnet_wall = 4;
magnet_top_clearance = 1;

// Used to stabilize the piece
module patin()
{
	difference()
	{
		cylinder(r=patin_r, h=patin_h);

		translate([0,-1*patin_r,0])
			cube([patin_r,2*patin_r,patin_h]);
	}
}


// Magnet holder
module magnet()
{
	difference()
	{
		cylinder(r=magnet_r+magnet_wall, h=patin_r-magnet_top_clearance, $fn=36);

		translate([0, 0, patin_r-magnet_h-magnet_top_clearance])
			cylinder(r=magnet_r, h=magnet_h, $fn=36);
	}
}

// Base assembly with no holes
module base()
{
	union()
	{
		cube([base_width, base_length, base_thickness]);

		translate([base_width/2,base_length/2,base_thickness ])
			magnet();

		/*
		translate([0, base_length/2, base_thickness])
			rotate(a=90, v=[0,1,0])
				patin();

		translate([base_width-patin_h, base_length/2, base_thickness])
			rotate(a=90, v=[0,1,0])
				patin();
		*/
	}
}

// Hex nut hole and cylindrical hole for the threaded rod
module linear_nut()
{
	difference()
	{
		base();

		for(i=[1:5])
		{
			// The following 3 cylinters are the housing of the hex nut
			translate([base_width/2,end_padding,i*nut_radius+bottom_padding])
				rotate(a=-90, v=[1,0,0])
					rotate(a=30, v=[0,0,1])
						cylinder(r=nut_radius, h=nut_length, $fn=6);
		}

		// Hole for the 1/4 filted rod
		translate([base_width/2,-1*end_padding/2,nut_radius+bottom_padding])
			rotate(a=-90, v=[1,0,0])
				rotate(a=30, v=[0,0,1])
					cylinder(r=nut_center_radius, h=base_length+end_padding, $fn=18);
	}
}

linear_nut();
