function [out] = quilt_cut(sample, outsize, patchsize, overlap, tol)

	sample = im2double(sample);
	out = im2double(zeros(outsize, outsize, 3));
	p_needed = floor((outsize-patchsize)/(patchsize-overlap))+1
	clear ssd_patch;
	
	for i = 1:p_needed % i : row
		r = (i-1)*(patchsize-overlap)+1;
		for j = 1:p_needed % j : col
			c = (j-1)*(patchsize-overlap)+1;

			% place first patch topleft manually
			if i == 1 && j == 1
				patch = randomPatch(sample, patchsize);
				out(1:patchsize, 1:patchsize, :) = patch(:,:,:);
				continue;
			end

			if i == 1
				mode = 0; % first row
			elseif j == 1
				mode = 1; % first column
			else
				mode = 2; % rest
			end

			content_filter = out(r:r+patchsize-1, c:c+patchsize-1, :);
			selection_filter = get_selection_filter(mode, patchsize, overlap);

			cost = ssd_patch(sample, content_filter, selection_filter, false);
			patch = choose_sample(sample, cost, patchsize, tol);
			
			out = merge(patch, out, patchsize, overlap, mode, r, c);
		end
	end

end


