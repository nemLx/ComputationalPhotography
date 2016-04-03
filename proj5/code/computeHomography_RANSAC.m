function [H, mask] = computeHomography_RANSAC(x1, y1, x2, y2)

tol = 10;
randPoints = 4;
loopCount = 1000;

bestQ = 0;
bestH = [];

for i=1:loopCount
	[px1, py1, px2, py2] = sample(x1, y1, x2, y2, randPoints);
	H = computeHomography(px1,py1,px2,py2);
	q = evaluateH(x1, y1, x2, y2, H, tol);
	
	if (q > bestQ)
		bestQ = q;
		bestH = H;
	end
end

[H, mask] = improve(x1,y1,x2,y2,bestH,tol);
bestQ

end



function [H, mask] = improve(x1,y1,x2,y2,H,tol)

[r, ~] = size(x1);

nx1 = x1;
ny1 = y1;
nx2 = x2;
ny2 = y2;

mask = ones([r,1]);

for i=1:r
	
	[nr, nc] = convert(y1(i), x1(i), H, false);
	
	dist = (nr-y2(i))^2 + (nc-x2(i))^2;
	
	if (dist > tol)
		nx2(i) = nc;
		ny2(i) = nr;
		mask(i) = 0;
	end
end

H = computeHomography(nx1,ny1,nx2,ny2);

end



function [quality] = evaluateH(x1, y1, x2, y2, H, tol)

[r, ~] = size(x1);
count = 0.;

for i=1:r
	
	[nr, nc] = convert(y1(i), x1(i), H, false);
	
	dist = (nr-y2(i))^2 + (nc-x2(i))^2;
	
	if (dist <= tol)
		count = count+1;
	end
	
end

quality = count/r;

end


function [px1, py1, px2, py2] = sample(x1, y1, x2, y2, count)

px1 = zeros(count,1);
py1 = zeros(count,1);
px2 = zeros(count,1);
py2 = zeros(count,1);

[r, ~] = size(x1);
s = randsample(r,count);

for i=1:count
	
	px1(i) = x1(s(i));
	py1(i) = y1(s(i));
	
	px2(i) = x2(s(i));
	py2(i) = y2(s(i));
	
end

end