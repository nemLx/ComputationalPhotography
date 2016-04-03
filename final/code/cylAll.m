function [ptsOut] = cylAll(pts, xc, yc, w, fMM)

	[numPts, ~] = size(pts);
	ptsOut = zeros(size(pts));
	f = getFocalLengthInPixels(w,fMM,35);
	
	for i=1:numPts
		[x,y] = getCoordCyl(pts(i,1)-xc,pts(i,2)-yc,f,f);
		ptsOut(i,1) = x;
		ptsOut(i,2) = y;
	end

end