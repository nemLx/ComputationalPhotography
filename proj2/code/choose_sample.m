function [patch] = choose_sample(sample, cost, patchsize, tol)

	[m,n,d] = size(sample);
	radius = floor(patchsize/2);	
	
	cost(1:radius, 1:n) = bitmax;
	cost(m-radius+1:m, 1:n) = bitmax;
	cost(1:m, 1:radius) = bitmax;
	cost(1:m, n-radius+1:n) = bitmax;
	
	minc = min(min(cost));
	[x,y] = find(cost < minc*(1 + tol));
	i = randi([1,max(size(x))]);

	x = x(i);
	y = y(i);
	
	patch = sample(x-radius:x+radius, y-radius:y+radius, :);
	
end