%To do - move legend to southeast
function elastic(fname1, fname2, diameter_in_mm, length_in_cm, name_of_graph, no_of_points_to_fit)
	%elastic('thin_wire_force.txt','thin_wire_angle.txt',0.25,82.3,'Thin Wire',8)

	M = dlmread(fname1); %name of text file containing force
	N = dlmread(fname2); %name of text file containing angle
	force = -M(3:length(M), 2)
	angle_of_rotation = -N(3:length(N), 2) * pi/180 %conversion to radian
	area_of_wire = pi * (diameter_in_mm/4000)^2;
	r_in_cm = 2.4; %needs to be updated
	stress = force/area_of_wire;
	strain = r_in_cm * angle_of_rotation/length_in_cm;

	y = stress(1:no_of_points_to_fit,1);
	x = strain(1:no_of_points_to_fit,1);
	p = polyfit(x,y,1)
	f = p(2) + p(1) * x;
	h = figure()

	S = [strain,stress];
	plot(strain,stress,"*;Experimental curve;", x, f, "--;Line for Youngs Modulus;","linewidth",2)
	ylabel ("Stress (Pa)");
    xlabel ("Strain (m)");
    axis([0, 1.2*max(strain), 0, 1.4*max(stress)]);
    title(name_of_graph);
    text(0.6*max(strain), max(stress)/2, sprintf("breaking point(%1.4g, %1.4g)",max(stress), max(strain)));
    text(max(x)*1.5, (p(2) + p(1) * max(x)), sprintf("Young's modulus = %1.4g Pa", p(1)))
	grid on;

	saveas(h, name_of_graph, 'jpg');
	csvwrite (name_of_graph, S);
