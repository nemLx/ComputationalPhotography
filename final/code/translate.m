function [xt,yt] = translate(x,y,T,inverse)

if (inverse)
	xt = x-T(1,3);
	yt = y-T(2,3);
else
	xt = x+T(1,3);
	yt = y+T(2,3);
end

end