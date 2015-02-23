use <_util.scad>

module 2d_half_space() {
	translate([0, -1e6]) {
		square(2e6);
	}
}

module rim_cross_section() {
	import("_cross_section.dxf", layer = "shape");
}

module outer_rim_shape() {
	rotate_extrude($fn = 8) {
		intersection() {
			rim_cross_section();
			2d_half_space();
		}
	}
}

module inner_rim_shape() {
	rotate_extrude($fn = 8) {
		difference() {
			rim_cross_section();
			2d_half_space();
		}
	}
}

module fillings_shape() {
	rotate_extrude($fn = 8) {
		import("_cross_section.dxf", layer = "fillings");
	}
}

module struts_plane() {
	scale([1e6, 1e6, 1]) {
		rotate_extrude($fn = 4) {
			import("_cross_section.dxf", layer = "struts");
		}
	}
}

module fillings_plane() {
	scale([1e6, 1e6, 1]) {
		rotate_extrude($fn = 4) {
			import("_cross_section.dxf", layer = "fillings");
		}
	}
}

module plane_minkowski() {
	minkowski() {
		children(0);
		
		linear_extrude(height = 1e-3)
			children(1);
	}
}

module cookie_cutter() {
	union() {
		// Outer rim.
		difference() {
			plane_minkowski() {
				outer_rim_shape();
				children(0);
			}
			
			infinite_extrude()
				children(0);
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
		intersection() {
			struts_plane();
			
			infinite_extrude() {
				children(1);
			}
		}
		
		// Fillings.
		difference() {
			plane_minkowski() {
				fillings_shape();
				children(2);
			}
			
			infinite_extrude()
				children(0);
		}
	}
}

module cookie_cutter_from_dxf(file_name) {
	render(convexity = 10) {
		cookie_cutter() {
			import(file_name, layer = "shape");
			import(file_name, layer = "struts");
			import(file_name, layer = "fillings");
		}
	}
}
