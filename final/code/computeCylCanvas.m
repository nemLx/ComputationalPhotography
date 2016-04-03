function [R, C, rOffset, cOffset] = computeCylCanvas(im1, im2, T)

% [h1,w1,~] = size(im1);
% [h,w,~] = size(im2);
% 
% [tRx, tRy] = translate(w,0,T,0);
% [bRx, bRy] = translate(w,h,T,0);
% 
% [tMx, tMy] = translate(w/2,0,T,0);
% [bMx, bMy] = translate(w/2,h,T,0);
% 
% minX = 0;
% maxX = tRx;
% minY = min(0, tMy);
% maxY = max(max(h1,h), bMy);

[h1, w1, ~] = size(im1);
[h2, w2, ~] = size(im2);

[tRx, tRy] = translate(w2,0,T,0);
[bRx, bRy] = translate(w2,h2,T,0);


minX = 0;
maxX = tRx;
minY = min(0,tRy);
maxY = max(h1,bRy);

R = round(maxY-minY+1);
C = round(maxX-minX+1);

rOffset = minY;
cOffset = minX;

end