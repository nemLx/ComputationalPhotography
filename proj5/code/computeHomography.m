function [H] = computeHomography(x1, y1, x2, y2)

	[nx1, ny1, t1, nx2, ny2, t2] = normalize(x1, y1, x2, y2);
	
	A = constructA(nx1, ny1, nx2, ny2);
	
	[~, ~, V] = svd(A);
	hn = V(:, end);
	
	Hn = transpose(reshape(hn,[3,3]));
	H = t2\(Hn*t1);
	
end



function [x1, y1, t1, x2, y2, t2] = normalize(x1, y1, x2, y2)

	t1 = getNormalizer(x1, y1);
	t2 = getNormalizer(x2, y2);
	
	numPts = numel(x1);
	
	for i=1:numPts
		
		pt = [x1(i); y1(i); 1];
		pt = t1*pt;
		x1(i) = pt(1);
		y1(i) = pt(2);
		
		pt = [x2(i); y2(i); 1];
		pt = t2*pt;
		x2(i) = pt(1);
		y2(i) = pt(2);
		
	end

end



function [t] = getNormalizer(x, y)

	avgX = mean(x);
	avgY = mean(y);
	
	t = [1/avgX 0			 -1; 
			 0			1/avgY -1;
			 0			0			  1 ];

end



function [A] = constructA(x1, y1, x2, y2)

	numPts = numel(x1);
	A = zeros(2*numPts,9);
	
	for i=1:numPts
		
		row1 = 2*i - 1;
		row2 = 2*i;
		
		A(row1, 1) = -1*x1(i);
		A(row1, 2) = -1*y1(i);
		A(row1, 3) = -1;
		
		A(row1, 7) = x1(i)*x2(i);
		A(row1, 8) = y1(i)*x2(i);
		A(row1, 9) = x2(i);
		
		A(row2, 4) = -1*x1(i);
		A(row2, 5) = -1*y1(i);
		A(row2, 6) = -1;
		
		A(row2, 7) = x1(i)*y2(i);
		A(row2, 8) = y1(i)*y2(i);
		A(row2, 9) = y2(i);
		
	end

end