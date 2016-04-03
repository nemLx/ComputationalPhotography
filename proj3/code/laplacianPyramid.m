function [o] = laplacianPyramid(fore, back, mask, iteration)

[fore, back, mask] = extendEven(fore, back, mask);

g_mask = imfilter(mask, fspecial('gaussian', 5, 3), 'same');

[fore_g, fore_l] = g_l(fore);
fore = imresize(fore_g, 0.5, 'bilinear');
fore_g = fore_g.*repmat(g_mask,[1,1,3]);
fore_l = fore_l.*repmat(g_mask,[1,1,3]);
fore_l_fname = strcat('l_f_', int2str(iteration), '.png');
imwrite(mat2gray(fore_l), fore_l_fname);

[back_g, back_l] = g_l(back);
back = imresize(back_g, 0.5, 'bilinear');
back_g = back_g.*repmat(ones(size(g_mask))-g_mask,[1,1,3]);
back_l = back_l.*repmat(ones(size(g_mask))-g_mask,[1,1,3]);
back_l_fname = strcat('l_b_', int2str(iteration), '.png');
imwrite(mat2gray(back_l), back_l_fname);

merged = fore_l+back_l;
merged_fname = strcat('m_', int2str(iteration), '.png');
imwrite(mat2gray(merged), merged_fname);

mask = imresize(g_mask, 0.5);

if iteration == 1
	o = back_g + fore_g;
	return
else
	next = laplacianPyramid(fore, back, mask, iteration-1);
	
	next = imresize(next,2);
	o = next+merged;
	
end
end

function [g,l] = g_l(in)
g = imfilter(in,fspecial('gaussian',1,0.1),'same');
t = imresize(g, 0.5, 'bilinear');
l = g - imresize(t,2, 'bilinear');
end

function [fore, back, mask] = extendEven(fore, back, mask)
[m,n] = size(fore);

if (mod(m,2) ~= 0)
	fore = padarray(fore, [1,0], 'replicate','post');
end

if (mod(n,2) ~= 0)
	fore = padarray(fore, [0,1], 'replicate','post');
end

[m,n] = size(back);

if (mod(m,2) ~= 0)
	back = padarray(back, [1,0], 'replicate','post');
end

if (mod(n,2) ~= 0)
	back = padarray(back, [0,1], 'replicate','post');
end

[m,n] = size(mask);

if (mod(m,2) ~= 0)
	mask = padarray(mask, [1,0], 'replicate','post');
end

if (mod(n,2) ~= 0)
	mask = padarray(mask, [0,1], 'replicate','post');
end

end

