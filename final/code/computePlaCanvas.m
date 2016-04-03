function [R, C, rOffset, cOffset] = computePlaCanvas(im1, im2, H)

	[h1, w1, ~] = size(im1);
	[h2, w2, ~] = size(im2);
	
	[tlr, tlc] = convert(0,0,H,true);
	[trr, trc] = convert(0,w2,H,true);
	[blr, blc] = convert(h2,0,H,true);
	[brr, brc] = convert(h2,w2,H,true);
	
	minX = 0;
	minY = 0;
	maxX = w1;
	maxY = h1;

	if (tlc < 0)
		minX = min(tlc, blc);
		minY = min([tlr, trr, minY]);
		maxY = max([blr, brr, maxY]);
	elseif (tlc > 0)
		maxX = max(trc, brc);
		minY = min([tlr, trr, minY]);
		maxY = max([blr, brr, maxY]);
	end
	
	R = round(maxY - minY);
	C = round(maxX - minX);
	
	cOffset = minX;
	rOffset = minY;
	
end