function [im] = extendEven3(im)
		[m,n,~] = size(im);
		
		mp = nextpow2(m);
		np = nextpow2(n);

		if (2^mp ~= m)
				im = padarray(im, [(2^mp-m),0,0],'post');
		end

		if (2^np ~= n)
				im = padarray(im, [0,(2^np-n),0],'post');
		end
end