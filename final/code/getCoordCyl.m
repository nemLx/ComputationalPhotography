function [xCyl, yCyl] = getCoordCyl(xPla, yPla, f, s)

	xCyl = s*atan(xPla/f);
	yCyl = s*yPla/(sqrt(xPla*xPla+f*f));

end

