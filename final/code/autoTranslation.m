function [T] = autoTranslation(im1, im2, xc, yc, w, fMM)

matchTol = 6;

[f1, d1] = sift(rgb2gray(im1));
[f2, d2] = sift(rgb2gray(im2));

m = siftmatch(d1, d2, matchTol);
[x1,y1,x2,y2] = extractMatchCoords(f1, f2, m);
mp1 = [x1, y1];
mp2 = [x2, y2];

mp1 = cylAll(mp1, xc, yc, w, fMM);
mp2 = cylAll(mp2, xc, yc, w, fMM);

T = computeTranslation_RANSAC(mp2, mp1);

end