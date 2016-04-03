function [xCyl, yCyl] = getCoordCylInv(xPla, yPla, f, s, c)

 	xCyl = c*asin(xPla/f)/pi;
	yCyl = s*yPla/(sqrt(xPla*xPla+f*f));

end