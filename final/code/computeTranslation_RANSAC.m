function [T] = computeTranslation_RANSAC(pt1, pt2)

x1 = pt1(:,1);
y1 = pt1(:,2);
x2 = pt2(:,1);
y2 = pt2(:,2);

tol = 10;
randPoints = 4;
loopCount = 1000;

bestQ = 0;
bestT = [];

for i=1:loopCount
	[px1, py1, px2, py2] = sample(x1, y1, x2, y2, randPoints);
	T = computeTranslation([px1, py1],[px2,py2]);
	q = evaluateT(x1, y1, x2, y2, T, tol);
	
	if (q > bestQ)
		bestQ = q;
		bestT = T;
	end
end

T = improve(x1,y1,x2,y2,bestT,tol);
bestQ

end



function [T] = improve(x1,y1,x2,y2,T,tol)

[r, ~] = size(x1);

nx1 = x1;
ny1 = y1;
nx2 = x2;
ny2 = y2;

for i=1:r
	
	[nc, nr] = translate(x1(i), y1(i), T, false);
	
	dist = (nr-y2(i))^2 + (nc-x2(i))^2;
	
	if (dist > tol)
		nx2(i) = nc;
		ny2(i) = nr;
	end
end

T = computeTranslation([nx1,ny1],[nx2,ny2]);

end



function [quality] = evaluateT(x1, y1, x2, y2, T, tol)

[r, ~] = size(x1);
count = 0.;

for i=1:r
	[nc, nr] = translate(x1(i), y1(i), T, false);
	
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