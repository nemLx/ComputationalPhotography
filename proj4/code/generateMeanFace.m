% computes the mean geometry, triangulation and overal mean face of a set
% of faces
% IM : array of images
% P : array of key points corresponding to the faces
% S : an index of images in IM to be counted in the result, facilitates
% subset average (male/female)

function [meanShape, meanTris, meanFace] = generateMeanFace(IM, P, S)

	[nl, count] = size(S);
	meanShape = getMeanShape(P, S);
	meanTris = delaunay(meanShape);
	meanFace = im2double(zeros([1024,1024,3]));
	
	parfor i = 1:count
		curr = morph((1/count)*im2double(IM{S(i)}), P{S(i)}, meanShape, meanTris);
		meanFace = meanFace + curr;
	end

end

function [o] = getMeanShape(P,S)

	[nl, count] = size(S);
	o = zeros(43,2);
	
	for i = 1:43
		sumX = 0;
		sumY = 0;
		for j = 1:count
			
			curr = P{S(j)};
			sumX = sumX + curr(i,1);
			sumY = sumY + curr(i,2);
			
		end
		o(i,1) = sumX / count;
		o(i,2) = sumY / count;
	end

end