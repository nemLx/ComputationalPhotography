function [x1,y1,x2,y2] = extractMatchCoords(f1, f2, m)

	[~, numPts] = size(m);
	
	x1 = zeros(numPts,1);
	y1 = zeros(numPts,1);
	x2 = zeros(numPts,1);
	y2 = zeros(numPts,1);
	
	for i=1:numPts
		
		x1(i) = f1(1,m(1,i));
		y1(i) = f1(2,m(1,i));
		
		x2(i) = f2(1,m(2,i));
		y2(i) = f2(2,m(2,i));
		
	end

end