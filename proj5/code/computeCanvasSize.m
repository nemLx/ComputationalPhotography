function [R, C, rOffset, cOffset] = computeCanvasSize(im1, im2, H)

	[r1, c1, ~] = size(im1);
	[r2, c2, ~] = size(im2);
	
	[tlr, tlc] = convert(0,0,H,true)
	[trr, trc] = convert(0,c2,H,true)
	[blr, blc] = convert(r2,0,H,true)
	[brr, brc] = convert(r2,c2,H,true)
	
	
	minX = 0;
	minY = 0;
	maxX = c1;
	maxY = r1;

	if (tlc < 0)
	
		minX = min(tlc, blc)
		minY = min([tlr, trr, minY])
		maxY = max([blr, brr, maxY])
		
	elseif (tlc > 0)
		
		maxX = max(trc, brc)
		minY = min([tlr, trr, minY])
		maxY = max([blr, brr, maxY])
		
	end
	
	R = maxY - minY
	C = maxX - minX
	
	rOffset = minY
	cOffset = minX
	
end