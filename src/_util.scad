module infinite_extrude() {
	translate([0, 0, -1e6])
		linear_extrude(height = 2e6)
			children(0);
}
