function [o, T, W] = autoCylinder(fname, numImgs, fMM, Ti, Wi)

in = readImgs(fname,numImgs);

[h,w,~] = size(in{1});
temp = zeros(1);

if (0)
	warped = warp(in, w/2, h/2, fMM);
else
	warped = Wi;
end



if (0)

	T = cell(1,numImgs);

	parfor i=1:numImgs

		L = numImgs-i;
		R = L+1;

		if (L < 1)
			L = numImgs;
		end

		if (R > numImgs)
			R = 1;
		end

		T{i} = autoTranslation(in{L}, in{R}, w/2, h/2, w, fMM);
	end
else
	T = Ti;
end


for i=numImgs:-1:1
	
	L = i-1;
	R = i;
	
	if (L < 1)
		L = numImgs;
	end
	
	I = numImgs+1-i;
	
	if (i == numImgs)
		[o1,o2,m1,m2,~] = stitchCyl(warped{L}, warped{R}, T{I});
		temp = pyrBlend(o1, o2, m1, m2, 6);
	else
		[o1,o2,m1,m2,~] = stitchCyl(warped{L}, temp, T{I});
		temp = pyrBlend(o1, o2, m1, m2, 6);
	end
	
end

imwrite(temp, 't.jpg');


[o1,o2,m1,m2,~] = stitchCyl(warped{numImgs-1}, temp, T{1});
temp = pyrBlend(o1, o2, m1, m2, 6);


[o1,o2,m1,m2,~] = stitchCyl(warped{numImgs-2}, temp, T{2});
temp = pyrBlend(o1, o2, m1, m2, 6);

[o1,o2,m1,m2,~] = stitchCyl(warped{numImgs-3}, temp, T{3});
temp = pyrBlend(o1, o2, m1, m2, 6);

[o1,o2,m1,m2,~] = stitchCyl(warped{numImgs-4}, temp, T{4});
temp = pyrBlend(o1, o2, m1, m2, 6);

[o1,o2,m1,m2,~] = stitchCyl(warped{numImgs-5}, temp, T{5});
temp = pyrBlend(o1, o2, m1, m2, 6);

[o1,o2,m1,m2,~] = stitchCyl(warped{numImgs-6}, temp, T{6});
temp = pyrBlend(o1, o2, m1, m2, 6);

[o1,o2,m1,m2,~] = stitchCyl(warped{numImgs-7}, temp, T{7});
o = pyrBlend(o1, o2, m1, m2, 6);

imwrite(o, 'o.jpg');

W = warped;

end