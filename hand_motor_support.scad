motor_width = 40;
motor_length = 25;
motor_heigth = 40;
base_hole_radius = 8;

wall_thickness = 3;
wall_angle = -55;
bottom_thickness = 3;

motor_holes_space = 31;
m3_nuts_radius = 1.75;
motor_head_recess = 12;

x1 = (motor_width/2)+wall_thickness-(motor_holes_space/2);
z1 = (motor_heigth/2)+bottom_thickness-(motor_holes_space/2);

x2 = x1 + motor_holes_space;
z2 = z1 + motor_holes_space;

ear_radius = 10;

ears_fb_x_trans = motor_width/2+wall_thickness;
ears_fb_y_trans1 = -1*ear_radius/2;
ears_fb_y_trans2 = motor_length+ear_radius/2;

module walls()
{
	difference()
	{
		cube([motor_width+(2*wall_thickness), motor_length, motor_heigth+bottom_thickness]);

		translate([wall_thickness,wall_thickness, bottom_thickness])
			cube([motor_width, motor_length, motor_heigth]);

		translate([0, 0, motor_heigth+(3*bottom_thickness)])
			rotate(a=wall_angle, v=[1,0,0])
				translate([0, -0.5*motor_length, 0])
					cube([motor_width+(2*wall_thickness),4*motor_length, motor_heigth]);
	}
}

module ears()
{
	difference()
	{
		union()
		{
			translate([-1*ear_radius/2,ear_radius,0])
				cylinder(r=ear_radius, h=bottom_thickness);
		
			translate([-1*ear_radius/2,motor_length-ear_radius,0])
				cylinder(r=ear_radius, h=bottom_thickness);

			translate([motor_width+(2*wall_thickness)+(ear_radius/2),ear_radius,0])
				cylinder(r=ear_radius, h=bottom_thickness);

			translate([motor_width+(2*wall_thickness)+(ear_radius/2),motor_length-ear_radius,0])
				cylinder(r=ear_radius, h=bottom_thickness);
		}

		// Mount attachment holes
		translate([-1*ear_radius/2,ear_radius,0])
			cylinder(r=m3_nuts_radius, h=bottom_thickness);

		translate([-1*ear_radius/2,motor_length-ear_radius,0])
			cylinder(r=m3_nuts_radius, h=bottom_thickness);

		translate([motor_width+(2*wall_thickness)+(ear_radius/2),ear_radius,0])
			cylinder(r=m3_nuts_radius, h=bottom_thickness);

		translate([motor_width+(2*wall_thickness)+(ear_radius/2),motor_length-ear_radius,0])
			cylinder(r=m3_nuts_radius, h=bottom_thickness);
	}
}

module ears_fb()
{
	difference()
	{
		
		union()
		{
			translate([ears_fb_x_trans,ears_fb_y_trans1,0])
				cylinder(r=ear_radius, h=bottom_thickness);
		
			translate([ears_fb_x_trans,ears_fb_y_trans2,0])
				cylinder(r=ear_radius, h=bottom_thickness);
		}

		// Mount attachment holes
		translate([ears_fb_x_trans,ears_fb_y_trans1,0])
			cylinder(r=m3_nuts_radius, h=bottom_thickness);

		translate([ears_fb_x_trans,ears_fb_y_trans2,0])
			cylinder(r=m3_nuts_radius, h=bottom_thickness);
	}
}

difference()
{
	union()
	{
		walls();
//		ears();
		ears_fb();
	}

	// Motor screws
	translate([x1, -1, z1])
		rotate(a=-90, v=[1,0,0])
			cylinder(r=m3_nuts_radius, h=2*wall_thickness);

	translate([x1, -1, z2])
		rotate(a=-90, v=[1,0,0])
			cylinder(r=m3_nuts_radius, h=2*wall_thickness);

	translate([x2, -1, z1])
		rotate(a=-90, v=[1,0,0])
			cylinder(r=m3_nuts_radius, h=2*wall_thickness);

	translate([x2, -1, z2])
		rotate(a=-90, v=[1,0,0])
			cylinder(r=m3_nuts_radius, h=2*wall_thickness);

	// Motor recess
	translate([(motor_width/2)+wall_thickness, -1,bottom_thickness+(motor_heigth/2)])
		rotate(a=-90, v=[1,0,0])
			cylinder(r=motor_head_recess, h=2*wall_thickness, $fn=36);



	translate([(motor_width/2)+wall_thickness,motor_length/2,0])
		cylinder(r=base_hole_radius, h=bottom_thickness);

}