function [im1pts, im2pts] = selectPoints(im1, im2)

	[im1pts,im2pts] = cpselect(im1, im2, 'Wait', true);

end