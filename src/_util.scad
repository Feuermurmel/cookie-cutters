_inf = 1e6;
_inf2 = _inf * 2;
_eps = 1e-3;


module infinite_extrude() {
	translate([0, 0, -_inf])
		linear_extrude(height = _inf2)
			children(0);
}

module sum() {
	intersection() {
		translate([-_inf2, 0, 0]) {
			minkowski() {
				translate([_inf, 0, 0]) {
					children(0);
				}
				
				translate([_inf, 0, 0]) {
					children(1);
				}
			}
		}
		
		cube(_inf, center = true);
	}
}
