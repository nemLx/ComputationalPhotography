function [o] = getCylinder(im, xc, yc, fMM)

im = im2double(im);

[h, w, ~] = size(im);
f = getFocalLengthInPixels(w,fMM,35);
s = f;

[tLx, tLy] = getCoordCyl(0-xc,0-yc,f,s);
[bLx, bLy] = getCoordCyl(0-xc,h-yc,f,s);
[tRx, tRy] = getCoordCyl(w-xc,0-yc,f,s);
[bRx, bRy] = getCoordCyl(w-xc,h-yc,f,s);

[cTx, cTy] = getCoordCyl(0,-yc,f,s);
[cBx, cBy] = getCoordCyl(0,h-yc,f,s);
[cLx, cLy] = getCoordCyl(-xc,0,f,s);
[cRx, cRy] = getCoordCyl(w-xc,0,f,s);


minX = min([tLx, cLx, bLx, 0]);
maxX = max([tRx, cRx, bRx]);
minY = min([tLy, cTy, tRy, 0]);
maxY = max([bLy, cBy, bRy]);

R = round(maxY-minY);
C = round(maxX-minX);

rOffset = minY;
cOffset = minX;

o = zeros(R, C, 3);

for i=1:R
	for j=1:C
		
		I = i+rOffset;
		J = j+cOffset;
		
		[nxPla, nyPla] = getCoordPla(J, I, f, s);
		
		nxPla = round(nxPla+xc);
		nyPla = round(nyPla+yc);
		
		if (nxPla < 1 || nxPla > w || nyPla < 1 || nyPla > h)
			o(i,j,:) = 0;
		else
			o(i,j,:) = im(nyPla, nxPla, :);
		end
		
	end
end

% 	o = extendEven3(o);

end