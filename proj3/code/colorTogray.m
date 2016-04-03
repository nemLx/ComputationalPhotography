function [o] = colorTogray(in)

	in_HSV = rgb2hsv(im2double(in));
	gray = rgb2gray(im2double(in));
	
	h = in_HSV(:,:,1);
	s = in_HSV(:,:,2);
	v = in_HSV(:,:,3);
	
	[m,n] = size(v);
	
	im2var = zeros(m,n);
	im2var(1:m*n) = 1:m*n;
	
	eq_total = ((m-1)*n+m*(n-1))*1 + 1;
	e = 0;
 	A = sparse([],[],[],eq_total,m*n,eq_total*2-1);
	b = zeros(eq_total,1);
	
	for x=1:n-1
		for y=1:m
			
			e=e+1; 
			A(e, im2var(y,x+1))=1; 
			A(e, im2var(y,x))=-1;
			b(e) = v(y,x+1)-v(y,x);

% 			e = e+1;
% 			A(e, im2var(y,x+1))=1; 
% 			A(e, im2var(y,x))=-1;
			
% 			v_diff = v(y,x+1)-v(y,x);
% 			g_diff = gray(y,x+1)-gray(y,x);
% 			
% 			if (abs(v_diff)>abs(g_diff))
% 				b(e) = v_diff;
% 			else
% 				b(e) = g_diff;
% 			end
			
		end
	end
	
	for x = 1:n
		for y = 1:m-1

			e=e+1;
			A(e, im2var(y+1,x))=1; 
			A(e, im2var(y,x))=-1;
			b(e) = v(y+1,x)-v(y,x); 

% 			e = e+1;
% 			A(e, im2var(y+1,x))=1; 
% 			A(e, im2var(y,x))=-1;
			
% 			v_diff = v(y+1,x)-v(y,x);
% 			g_diff = gray(y+1,x)-gray(y,x);
% 			
% 			if (abs(v_diff)>abs(g_diff))
% 				b(e) = v_diff;
% 			else
% 				b(e) = g_diff;
% 			end

		end
	end
	
	e=e+1; 
	A(e, im2var(1,1))=1;
	b(e)=gray(1,1);
	
	o = zeros(size(v));
	o(1:m*n) = A\b;
	
end