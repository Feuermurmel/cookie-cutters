module 2d_half_space() {
	translate([0, -1e6]) {
		square(2e6);
	}
}

module rim_cross_section() {
	import("_cross_section.dxf", layer = "rim");
}

module outer_rim_shape() {
	rotate_extrude() {
		intersection() {
			rim_cross_section();
			2d_half_space();
		}
	}
}

module inner_rim_shape() {
	rotate_extrude() {
		difference() {
			rim_cross_section();
			2d_half_space();
		}
	}
}

module struts_shape() {
	rotate_extrude() {
		import("_cross_section.dxf", layer = "struts");
	}
}

module plane_minkowski() {
	minkowski() {
		children(0);
		
		linear_extrude(height = 1e-3)
			children(1);
	}
}

module infinite_extrude() {
	translate([0, 0, -1e6])
		linear_extrude(height = 2e6)
			children(0);
}

module cookie_cutter() {
	union() {
		// Outer rim.
		difference() {
			plane_minkowski() {
				outer_rim_shape();
				children(0);
			}
			
			infinite_extrude() {
				children(0);
			}
		}
		
		// Inner rim.
//		intersection() {
//			plane_minkowski() {
//				inner_rim_shape();
//				
//				difference() {
//					square(2e6, center = true);
//					children(0);
//				}
//			}
//			
//			infinite_extrude() {
//				children(0);
//			}
//		}
		
		// Struts.
		if ($children > 1) {
			plane_minkowski() {
				struts_shape();
				children(1);	
			}
		}
	}
}

module cookie_cutter_from_dxf(file_name) {
	render(convexity = 10) {
		cookie_cutter() {
			import(file_name, layer = "shape");
			import(file_name, layer = "struts");
		}
	}
}
