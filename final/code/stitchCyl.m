function [o1, o2, m1, m2, mt] = stitchCyl(im1, im2, T)

[h1,w1,~] = size(im1);
[h2,w2,~] = size(im2);

[H,W,hOffset,wOffset] = computeCylCanvas(im1,im2,T);

o1 = zeros(H,W,3);
o2 = zeros(H,W,3);

overlapM = zeros(H,W);
leftM = zeros(H,W);
rightM = zeros(H,W);

lcr = round(h1/2)+hOffset;
lcc = round(w1/2)+wOffset;
[rcc, rcr] = translate(lcc, lcr, T, 0);

parfor i=1:H
	for j=1:W
	
		s1 = false;
    s2 = false;
		I = i+hOffset;
		J = j+wOffset;
		
		[tJ, tI] = translate(J,I,T,1);
		
		I = round(I);
		J = round(J);
		tI = round(tI);
		tJ = round(tJ);
		
		if (I >= 1 && J >= 1 && I <= h1 && J <= w1)
			o1(i,j,:) = im1(I,J,:);
      s1 = true;
      leftM(i,j) = 1;
		end
		
		if (tI >= 1 && tJ >= 1 && tI <= h2 && tJ <= w2)
			o2(i,j,:) = im2(tI,tJ,:);
			s2 = true;
      rightM(i,j) = 1;
		end

    if (s1 && s2)
      overlapM(i,j) = 1;
      
      dl = (i-lcr)^2+(j-lcc)^2;
      dr = (i-rcr)^2+(j-rcc)^2;
      
      if (dl > dr)
        leftM(i,j) = 0;
      else
        rightM(i,j) = 0;
      end
    end

	end
end

% iMask = computeIntensityMask(o1, o2, overlapM, rightM);
% o2 = o2+iMask;

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










