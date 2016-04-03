function [T] = computeTranslation(pt1, pt2)

	A = constructA(pt1);
	b = constructB(pt2);
	
	x = A\b;
	T = constructT(x);

end

function [A] = constructA(pts)

	[numPts, ~] = size(pts);
	A = zeros(2*numPts, 3);
	
	for i=1:numPts
		x = pts(i,1);
		y = pts(i,2);
		r = 2*i-1;
		
		A(r,1) = 1;
		A(r,3) = x;
		A(r+1,2) = 1;
		A(r+1,3) = y;
	end

end

function [b] = constructB(pts)

	[numPts, ~] = size(pts);
	b = zeros(2*numPts, 1);
	
	for i=1:numPts
		x = pts(i,1);
		y = pts(i,2);
		r = 2*i-1;
		
		b(r) = x;
		b(r+1) = y;
	end

end

function [T] = constructT(x)
	T = diag([1,1,1]);
	T(1,3) = x(1);
	T(2,3) = x(2);
end