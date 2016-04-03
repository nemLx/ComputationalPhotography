% given an image and a triangulation, this function plots all the triangles
% in the triangulation on top of the image. it utilizes a funciton
% bresenham, which given coordinates of two points, returns coordinates of
% all points on the line specified by the two points

function [o] = overlayTriangle(im, points, tris)

	o = im2double(im);
	[tri_count, nl] = size(tris);
	
	for i = 1:tri_count
		
		v1 = points(tris(i,1),:);
		v2 = points(tris(i,2),:);
		v3 = points(tris(i,3),:);
		
		[ind12X,ind12Y] = bresenham(v1(1),v1(2),v2(1),v2(2));
		[ind23X,ind23Y] = bresenham(v2(1),v2(2),v3(1),v3(2));
		[ind31X,ind31Y] = bresenham(v3(1),v3(2),v1(1),v1(2));
		
		flat1 = sub2ind([1024, 1024], ind12Y, ind12X);
		flat2 = sub2ind([1024, 1024], ind23Y, ind23X);
		flat3 = sub2ind([1024, 1024], ind31Y, ind31X);
		
		or = o(:,:,1);
		og = o(:,:,2);
		ob = o(:,:,3);
		
		or(flat1) = 1.;
		or(flat2) = 1.;
		or(flat3) = 1.;
		
		og(flat1) = 0.;
		og(flat2) = 0.;
		og(flat3) = 0.;
		
		ob(flat1) = 0.;
		ob(flat2) = 0.;
		ob(flat3) = 0.;
		
		o(:,:,1) = or;
		o(:,:,2) = og;
		o(:,:,3) = ob;
		
	end

end