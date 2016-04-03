% given two triangles, computes the affine transformation between them
% 
% tri1: origin triangle
% tri2: destination triangle

function [o] = computeAffine(tri1, tri2)

	M = ones(3,3);
	v1 = ones(3,1);
	v2 = ones(3,1);

	for i = 1:3
		M(i,1) = tri1(i,1);
		M(i,2) = tri1(i,2);

		v1(i,1) = tri2(i,1);
		v2(i,1) = tri2(i,2);
	end
	
	r1 = linsolve(M,v1);
	r2 = linsolve(M,v2);
	
	o = ones(3,3);
	
	o(1,:) = transpose(r1);
	o(2,:) = transpose(r2);
	o(3,1) = 0;
	o(3,2) = 0;

end