function [out] = quilt_simple(sample, outsize, patchsize, overlap, tol)

	sample = im2double(sample);
	out = im2double(zeros(outsize, outsize, 3));
	p_needed = floor((outsize-patchsize)/(patchsize-overlap))+1;
	clear ssd_patch;

	for i = 1:p_needed % i : row
		r = (i-1)*(patchsize-overlap)+1;
		for j = 1:p_needed % j : col
			c = (j-1)*(patchsize-overlap)+1;

			% place first patch topleft manually
			if i == 1 && j == 1
				patch = randomPatch(sample, patchsize);
				out(1:patchsize, 1:patchsize, :) = patch(:,:,:);
				%out_img(1:patchsize, 1:patchsize, :) = sample(1:patchsize,1:patchsize,:);
				continue;
			end

			if i == 1
				mode = 0;
			elseif j == 1
				mode = 1;
			else
				mode = 2;
			end

			content_filter = out(r:r+patchsize-1, c:c+patchsize-1, :);
			selection_filter = get_selection_filter(mode, patchsize, overlap);

			cost = ssd_patch(sample, content_filter, selection_filter, false);
			patch = choose_sample(sample, cost, patchsize, tol);

			out(r:r+patchsize-1, c:c+patchsize-1, :) = patch(:,:,:);

		end
	end

end









