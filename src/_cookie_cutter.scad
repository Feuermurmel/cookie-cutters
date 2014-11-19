rim_bottom_width = .4;
rim_top_width = 2;
rim_height = 12;
rim_base_height = 1.5;
rim_base_width = 5;


module rim_shape() {
	union() {
		cylinder(h = rim_height, d1 = rim_bottom_width, d2 = rim_top_width, $fn = 8);
		
		translate([0, 0, rim_height - rim_base_height])
			cylinder(h = rim_base_height, d = rim_base_width, $fn = 8);
	}
}

module cookie_cutter() {
	union() {
		minkowski() {
			linear_extrude(height = .001) {
				difference() {
					minkowski() {
						children(0);
						circle(r = .01, $fn = 4);
					}
					
					children(0);
				}
			}
			
			rim_shape();
		}
		
		if ($children > 1) {
			translate([0, 0, rim_height - rim_base_height])
				linear_extrude(height = rim_base_height)
					children(1);
		}
	}
}
