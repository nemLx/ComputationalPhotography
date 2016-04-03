function [o1, o2, m1, m2, mt] = stitchPlanar(im1, im2, H)

im1 = im2double(im1);
im2 = im2double(im2);

[r1, c1, ~] = size(im1);
[r2, c2, ~] = size(im2);
% [R, C, rOffset, cOffset] = computeCanvasSize(im1, im2, H);
R = 10000;
C = 10000;
rOffset = -5000;
cOffset = -5000;

o1 = zeros(R, C, 3);
o2 = zeros(R, C, 3);

overlapM = zeros(R, C);
leftM = zeros(R, C);
rightM = zeros(R, C);

lcr = round(r1/2);
lcc = round(c1/2);
[rcr, rcc] = convert(round(r2/2), round(c2/2), H, true);

for i=1:R
  for j=1:C
    
    s1 = false;
    s2 = false;
    I = i+rOffset;
    J = j+cOffset;
    
    [nr, nc] = convert(I,J,H,false);
    
    if (nr > 0 && nr <= r2 && nc > 0 && nc <=c2)
      o2(i,j,1) = im2(nr,nc,1);
      o2(i,j,2) = im2(nr,nc,2);
      o2(i,j,3) = im2(nr,nc,3);
      
      s2 = true;
      rightM(i,j) = 1;
    end
    
    if (I > 0 && I <= r1 && J > 0 && J <=c1)
      o1(i,j,:) = im1(I,J,:);
      
      s1 = true;
      leftM(i,j) = 1;
    end
    
    if (s1 && s2)
      overlapM(i,j) = 1;
      
      dl = (I-lcr)^2+(J-lcc)^2;
      dr = (I-rcr)^2+(J-rcc)^2;
      
      if (dl > dr)
        leftM(i,j) = 0;
      else
        rightM(i,j) = 0;
      end
    end
    
  end
end

iMask = computeIntensityMask(o1, o2, overlapM, rightM);
o2 = o2+iMask;

o1 = extendEven3(o1);
o2 = extendEven3(o2);
m1 = extendEven2(leftM);
m2 = extendEven2(rightM);
mt = extendEven2(overlapM);

end



function [m] = computeIntensityMask(im1, im2, M, dM)

lrmean = mean(mean(M.*im1(:,:,1)));
lgmean = mean(mean(M.*im1(:,:,2)));
lbmean = mean(mean(M.*im1(:,:,3)));

rrmean = mean(mean(M.*im2(:,:,1)));
rgmean = mean(mean(M.*im2(:,:,2)));
rbmean = mean(mean(M.*im2(:,:,3)));

m(:,:,1) = (lrmean-rrmean) * dM;
m(:,:,2) = (lgmean-rgmean) * dM;
m(:,:,3) = (lbmean-rbmean) * dM;

end





