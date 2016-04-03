function [xPla, yPla] = getCoordPla(xCyl, yCyl, f, s)

	xPla = f*tan(xCyl/s);
	yPla = f*(yCyl/s)*sec(xCyl/s);
	
end