function [out] = iterate(sample, target, N, patchsize, tol)

	temp = 0;

	for i=1:N
		
		alpha = 0.8*(i-1)/(N-1) + 0.1;
		p = 2*floor(patchsize/3)+1;
		overlap = 1*floor(p/6)+1;
		
		temp = texture_transfer(sample,target,temp,p,overlap,tol,alpha);
	end
	
	out = temp;

end