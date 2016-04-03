function [g, l] = laplacianPyramid(original, iteration)

original = im2double(original);

for i = 0:iteration 
    
    [m,n] = size(original);
    
    if (mod(m,2) ~= 0)
        original = padarray(original, [1,0], 'replicate','post');
    end
    
    if (mod(n,2) ~= 0)
        original = padarray(original, [0,1], 'replicate','post');
    end
    
    g = imfilter(original, fspecial('gaussian', 15, 3), 'same');
    g_fname = strcat('g_', int2str(i), '.jpg');
    imwrite(imresize(g, 2^i), g_fname);
    g_r = imresize(g, 0.5);
    
    l = original - imresize(g_r, 2);
    l_fname = strcat('l_', int2str(i), '.jpg');
    imwrite(imresize(mat2gray(l), 2^i), l_fname);
    
    original = g_r;
end