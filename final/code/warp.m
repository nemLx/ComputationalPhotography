function [warped] = warp(in, xc, yc, fMM)

[~,numImgs] = size(in);
warped = cell(1, numImgs);

for i=1:numImgs
	
	warped{i} = getCylinder(in{i}, xc, yc, fMM);
	
end

end