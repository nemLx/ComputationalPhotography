% mode 0 = first row
%			 1 = first column
%			 2 = rest
function [out] = get_selection_filter(mode, patchsize, overlap)
	
	out = ones(patchsize, patchsize);
	
	if mode == 0
		out(:, overlap+1:patchsize) = 0;
	elseif mode == 1
		out(overlap+1:patchsize, :) = 0;
	elseif mode == 2
		out(overlap+1:patchsize, overlap+1:patchsize) = 0;
	end

	out = im2double(out);
end