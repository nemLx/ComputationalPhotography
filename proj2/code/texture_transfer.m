function [out] = texture_transfer(sample, target, prev, patchsize, overlap, tol, alpha)

	target = im2double(target);
	sample = im2double(sample);
	
	prev = im2double(prev);
	[m,n] = size(rgb2gray(target));
	out = im2double(zeros(m, n, 3));
	
	p_needed_row = floor((m-patchsize)/(patchsize-overlap))+1;
	p_needed_col = floor((n-patchsize)/(patchsize-overlap))+1;
	
	clear ssd_patch;
	
	sample_rough = imfilter(rgb2gray(sample), fspecial('gaussian',2,30));
	target_rough = imfilter(rgb2gray(target), fspecial('gaussian',2,30));

	for i = 1:p_needed_row % i : row
		r = (i-1)*(patchsize-overlap)+1;
		for j = 1:p_needed_col % j : col
			c = (j-1)*(patchsize-overlap)+1;
			
			% place first patch topleft manually
			if i == 1 && j == 1
				patch = randomPatch(sample, patchsize);
				out(1:patchsize, 1:patchsize, :) = patch(:,:,:);
				%out(1:patchsize, 1:patchsize, :) = sample(1:patchsize,1:patchsize,:);
				continue;
			end
			%
			
			% determine the mode of operations based on the position of the patch
			if i == 1
				mode = 0; % first row
			elseif j == 1
				mode = 1; % first column
			else
				mode = 2; % rest
			end
			%
			
			% select a patch to put on the canvas
			content_filter = out(r:r+patchsize-1, c:c+patchsize-1, :);
			target_filter = target_rough(r:r+patchsize-1, c:c+patchsize-1, :);
			selection_filter = get_selection_filter(mode, patchsize, overlap);
			
			content_filter = content_filter.*repmat(selection_filter,[1,1,3]);
			%target_filter = target_filter.*repmat(selection_filter,[1,1,3]);
			
			overlap_cost = ssd_patch(sample, content_filter, selection_filter, false);
			transfer_cost = ssd_patch(sample_rough, target_filter, ones(size(target_filter)), true);
			
			if prev ~= 0
				prev_filter = prev(r:r+patchsize-1, c:c+patchsize-1, :);
				prev_cost = ssd_patch(sample, prev_filter, ones(size(prev_filter(:,:,1))), false);
			else
				prev_cost = zeros(size(overlap_cost));
			end
			
			cost = alpha.*(overlap_cost+prev_cost)+(1-alpha)*transfer_cost;
			patch = choose_sample(sample, cost, patchsize, tol);
			%
			
			% merge patch to existing canvas
			out = merge(patch, out, patchsize, overlap, mode, r, c);
			%
			
		end
	end

end


