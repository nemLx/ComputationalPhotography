function [patch] = randomPatch(sample, patchsize)

	[m, n, d] = size(sample);
	radius = floor(patchsize/2);
	
	x = randi([radius+1, m-radius]);
	y = randi([radius+1, n-radius]);

	patch = sample(x-radius:x+radius, y-radius:y+radius,:);

end