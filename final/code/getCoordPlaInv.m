function [xPla, yPla] = getCoordPlaInv(xCyl, yCyl, f, s, c)

xPla = f*sin(xCyl*pi/c);
yPla = f*(yCyl/s)*sec(xCyl/s);

end
