function [o, o1, o2, m1, m2, m, mp1, mp2, mask, f1, f2, d1, d2] = autoStitch(im1, im2, lapBlend)

matchTol = 5;

[f1, d1] = sift(rgb2gray(im1));
[f2, d2] = sift(rgb2gray(im2));

m = siftmatch(d1, d2, matchTol);
[x1,y1,x2,y2] = extractMatchCoords(f1, f2, m);
mp1 = [x1, y1];
mp2 = [x2, y2];
[H, mask] = computeHomography_RANSAC(x1, y1, x2, y2);

[o1, o2, m1, m2, ~] = stitchPlanar(im1, im2, H);

if (lapBlend)
	o = laplacianBlend(o1, o2, m1, m2, 5);
else
	o = matBlend(o1, o2, m1, m2);
end

o = trimZero(o);

end


