
% fore_gnd : patch to be blended (foreground)
% back_gnd : canvas (background)
% mask		 : binary array with same size as back_gnd
%					   specifying where to put foreground

function [o] = poisson(fore_gnd, back_gnd, mask, mixed_gradient)
	
	[m,n] = size(mask);
	pixel_total = sum(sum(mask));
	p_map_r = zeros(pixel_total,1);
	p_map_c = zeros(pixel_total,1);
	b_map_r = zeros(pixel_total*3,1);
	b_map_c = zeros(pixel_total*3,1);
	pid_mask = zeros(size(mask));
	bid_mask = zeros(size(mask));
	type_mask = zeros(size(mask));
	pixel_counter = 0;
	boundary_counter = pixel_total;
	eqn_counter = 0;
	
	for i = 1:m
		for j = 1:n
			if mask(i,j)
				pixel_counter = pixel_counter+1;
				p_map_r(pixel_counter) = i;
				p_map_c(pixel_counter) = j;
				[t,e] = getType(i,j,m,n,mask);
				pid_mask(i,j) = pixel_counter;
				type_mask(i,j) = t;
				eqn_counter = eqn_counter + e;
				
				t = de2bi(t,4);
				if t(1)
					setBoundary(i,j-1);
				end
				if t(2)
					setBoundary(i-1,j);
				end
				if t(3)
					setBoundary(i,j+1);
				end
				if t(4)
					setBoundary(i+1,j);
				end
				
			end
		end
	end
	
	A = sparse([],[],[],eqn_counter,pixel_total+boundary_counter,2*pixel_total+boundary_counter);
	b = zeros(eqn_counter, 1);
	e = 0;
	
	for i = 1:pixel_total
		
		r = p_map_r(i);
		c = p_map_c(i);
		t = de2bi(type_mask(r,c),4);
		
		if t(1) %l
			setSystem(0,-1,1);
		end
		
		if t(2) %u
			setSystem(-1,0,1);
		end
		
		if t(3) %r
			setSystem(0,1,1);
		elseif c < n
			setSystem(0,1,0);
		end
		
		if t(4) %d
			setSystem(1,0,1);
		elseif r < m
			setSystem(1,0,0);
		end
	end
	
	for i = pixel_total+1:boundary_counter
		r = b_map_r(i);
		c = b_map_c(i);
		e = e+1;
		A(e,bid_mask(r,c)) = 1;
		b(e) = back_gnd(r,c);
	end
	
	v=lscov(A,b);
	
	o = back_gnd;
	for i = 1:pixel_total
		r = p_map_r(i);
		c = p_map_c(i);
		o(r,c) = v(i);
	end
	
	function [] = setBoundary(i,j)
		boundary_counter = boundary_counter+1;
		b_map_r(boundary_counter) = i;
		b_map_c(boundary_counter) = j;
		bid_mask(i,j) = boundary_counter;
	end

	function [] = setB(r_offset,c_offset)
		fore_g = fore_gnd(r,c) - fore_gnd(r+r_offset,c+c_offset);
		back_g = back_gnd(r,c) - back_gnd(r+r_offset,c+c_offset);
		if mixed_gradient
			if abs(fore_g)>abs(back_g)
				b(e) = fore_g;
			else
				b(e) = back_g;
			end
		else
			b(e) = fore_g;
		end
	end

	function [] = setSystem(r_offset,c_offset,isBack)
		e = e+1;
		A(e,i) = 1;
		if isBack
			A(e,bid_mask(r+r_offset,c+c_offset)) = -1;
		else
			A(e,pid_mask(r+r_offset,c+c_offset)) = -1;
		end
		setB(r_offset,c_offset);
	end

end



% t : type of pixel
%
% e : number of eqns contributed, from 1 to 4
%
function [t,e] = getType(i,j,m,n,mask)
	
	l = 0;
	u = 0;
	r = 0;
	d = 0;

	if j>1 && mask(i,j-1)==0 %left
		l = 1;
	end
	if i>1 && mask(i-1,j)==0 %up
		u = 1;
	end
	if j<n && mask(i,j+1)==0 %right
		r = 1;
	end
	if i<m && mask(i+1,j)==0 %down
		d = 1;
	end
	
	t = bi2de([l,u,r,d]);
	e = l + u;
	
	if j<n
		e = e+1;
	end
	
	if i<m
		e = e+1;
	end

end











