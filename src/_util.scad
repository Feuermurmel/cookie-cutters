module _unfuck_nothing() {
	union() {
		children(0);
		
		difference() {
			cube(1, center = true);
			cube(2, center = true);
		}
		
		difference() {
			square(1, center = true);
			square(2, center = true);
		}
	}
}

module intersect() {
	intersection_for(i = [0:$children - 1])
		_unfuck_nothing()
			children(i);
}

module subtract() {
	difference() {
		_unfuck_nothing()
			children(0);
		
		if ($children > 1)
			for(i = [1:$children - 1])
				children(i);
	}
}

module infinite_extrude() {
	translate([0, 0, -1e6])
		linear_extrude(height = 2e6)
			children(0);
}

module sum() {
	minkowski() {
		_unfuck_nothing()
			children(0);
		
		_unfuck_nothing()
			children(1);
	}
}
