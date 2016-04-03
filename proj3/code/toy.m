function [o] = toy(s)

	s = im2double(s);
	[h, w] = size(s);
	im2var = zeros(h,w);
	im2var(1:h*w) = 1:h*w;
	e = 0;
	A = sparse([],[],[],(h-1)*w+h*(w-1)+1,h*w,h*w*2);
	b = zeros((h-1)*w+h*(w-1)+1,1);
	
	for x = 1:w-1
		for y = 1:h
	
			e=e+1; 
			A(e, im2var(y,x+1))=1; 
			A(e, im2var(y,x))=-1;
			b(e) = s(y,x+1)-s(y,x);

		end
	end
	
	for x = 1:w
		for y = 1:h-1
	
			e=e+1;
			A(e, im2var(y+1,x))=1; 
			A(e, im2var(y,x))=-1;
			b(e) = s(y+1,x)-s(y,x); 

		end
	end
	
	e=e+1; 
	A(e, im2var(1,1))=1; 
	b(e)=s(1,1); 
	
	v=lscov(A,b);
	
	o = zeros(h,w);
	o(1:h*w) = v;
	
	disp(['Error: ' num2str(sqrt(sum((s(:)-o(:)).^2)))]);
	
end