function [mr, mg, mb] = meanIntensity(im)

	mr = mean(mean(im(:,:,1)));
	mg = mean(mean(im(:,:,2)));
	mb = mean(mean(im(:,:,3)));

end