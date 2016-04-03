% morphs two images:
%		tris is the established triangulation
%		start_pts is the coordinates of all points in the starting frame
%		end_pts is the coordinates of all points in the ending frame

function [o] = morph(im, start_pts, end_pts, tris)

	[r,c,nl] = size(im);
	[tri_count,nl] = size(tris);
	o = ones(size(im));

	% stores transformations of all triangles
	transforms = zeros(3,3,tri_count);
	
	% compute transform separately for each triangle in the triangulation
	for i = 1:tri_count
		transforms(:,:,i) = getTransform(start_pts, end_pts, tris(i,:));
	end

	% determine which triangle each pixel in the destination belongs to
	[X,Y] = flatten(r,c);
	lookup = mytsearch(end_pts(:,1), end_pts(:,2), tris, X, Y);

	% now do reverse transform for each pixel in each triangle in the destination
	for i = 1:r
		for j = 1:c
			
			flat_index = r*(i-1)+j;
			trig_index = lookup(flat_index);

			if isnan(trig_index)
				continue;
			else
				des_coords = transpose([i,j,1]);
				src_coords = transforms(:,:,trig_index)*des_coords;
				r_c = int32(src_coords(1));
				c_c = int32(src_coords(2));

				if r_c <= r && r_c > 0 && c_c <=c && c_c > 0
						o(i,j,:) = im(r_c,c_c,:);
				end
			end
		end
	end

end

function [o1, o2] = flatten(r,c)

	o1 = zeros(r*c,1);
	o2 = zeros(r*c,1);

	for i = 1:r
		for j = 1:c
			index = r*(i-1)+j;
			o1(index) = j;
			o2(index) = i;
		end
	end

end

function [o] = getTransform(pts1, pts2, tri)

	s = zeros(3,2);
	e = zeros(3,2);

	for i = 1:3
		s(i,1) = pts1(tri(i),2);
		s(i,2) = pts1(tri(i),1);
		e(i,1) = pts2(tri(i),2);
		e(i,2) = pts2(tri(i),1);
	end
	
	o = computeAffine(e,s);
	
end