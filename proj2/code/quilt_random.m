function [ out_img ] = quilt_random( sample, outsize, patchsize )

	patch_needed_row = floor(outsize/patchsize);

	out_img = zeros(outsize, outsize, 3);

	for i = 0:(patch_needed_row-1)
		for j = 0:(patch_needed_row-1)

			patch = randomPatch(sample, patchsize);
			out_img(i*patchsize+1:(i+1)*patchsize, j*patchsize+1:(j+1)*patchsize, :) = patch(1:patchsize,1:patchsize,:);

		end
	end

	out_img = uint8(out_img);

end