use <_cookie_cutter.scad>

render(convexity = 10)
	cookie_cutter() {
		import("koubachi_k.dxf", layer = "shape");
		import("koubachi_k.dxf", layer = "struts");
	}
