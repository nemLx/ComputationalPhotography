function [o] = matBlend(o1, o2, m1, m2)

    o1 = o1.*repmat(m1, [1,1,3]);
	o2 = o2.*repmat(m2,[1,1,3]);
    
    o = o1+o2;
end