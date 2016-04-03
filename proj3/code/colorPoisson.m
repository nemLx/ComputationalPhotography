function [o] = colorPoisson(back_gnd, fore_gnd, mask, mixed_gradient)

	back = im2double(back_gnd);
	fore = im2double(fore_gnd);
	
	b_r = back(:,:,1);
	b_g = back(:,:,2);
	b_b = back(:,:,3);
	
	f_r = fore(:,:,1);
	f_g = fore(:,:,2);
	f_b = fore(:,:,3);
	
	b_r = poisson(f_r,b_r,mask,mixed_gradient);
	b_g = poisson(f_g,b_g,mask,mixed_gradient);
	b_b = poisson(f_b,b_b,mask,mixed_gradient);
	
	o = zeros(size(back_gnd));
	
	o(:,:,1) = b_r;
	o(:,:,2) = b_g;
	o(:,:,3) = b_b;

end