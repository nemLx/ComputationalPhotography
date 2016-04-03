function [dr, dg, db] = diffIntensity(im1, im2)

	[r1, g1, b1] = meanIntensity(im1);
	[r2, g2, b2] = meanIntensity(im2);
	
	dr = r1-r2;
	dg = g1-g2;
	db = b1-b2;

end