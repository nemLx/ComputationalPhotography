function [rp, cp] = convert(r,c,H,invert)

	if (invert)
		p = H\[c;r;1];
	else
		p = H*[c;r;1];
	end
		
	rp = round(p(2)/p(3));
	cp = round(p(1)/p(3));
	
end