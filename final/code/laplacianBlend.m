function [o] = laplacianBlend(im1, im2, m1, m2, iteration)

g_mask_1 = imfilter(m1, fspecial('gaussian', [10 10], 2), 'same');
g_mask_2 = imfilter(m2, fspecial('gaussian', [10 10], 2), 'same');

[im1_g, im1_l] = g_l(im1);
im1_next = imresize(im1_g, 0.5, 'bilinear');
% im1_g = im1.*repmat(g_mask_2,[1,1,3]);
% im1_l = im1_l.*repmat(g_mask_2,[1,1,3]);

im1_g = im1.*repmat(ones(size(g_mask_2))-g_mask_2,[1,1,3]);
im1_l = im1_l.*repmat(ones(size(g_mask_2))-g_mask_2,[1,1,3]);

% fore_l_fname = strcat('l_f_', int2str(iteration), '.png');
% imwrite(mat2gray(im1_l), fore_l_fname);

[im2_g, im2_l] = g_l(im2);
im2_next = imresize(im2_g, 0.5, 'bilinear');
% im2_g = im2.*repmat(ones(size(g_mask_2))-g_mask_2,[1,1,3]);
% im2_l = im2_l.*repmat(ones(size(g_mask_2))-g_mask_2,[1,1,3]);

im2_g = im2.*repmat(g_mask_2,[1,1,3]);
im2_l = im2_l.*repmat(g_mask_2,[1,1,3]);

% back_l_fname = strcat('l_b_', int2str(iteration), '.png');
% imwrite(mat2gray(im2_l), back_l_fname);

merged = im1_l+im2_l;

% merged_fname = strcat('m_', int2str(iteration), '.png');
% imwrite(mat2gray(merged), merged_fname);

g_mask_1 = imresize(g_mask_1, 0.5);
g_mask_2 = imresize(g_mask_2, 0.5);

if iteration == 1
  o = im2_g+im1_g;
  return
else
  next = laplacianBlend(im1_next, im2_next, g_mask_1, g_mask_2, iteration-1);
  next = imresize(next, 2);
  o = next+merged;
end

end



function [g,l] = g_l(in)
g = imfilter(in,fspecial('gaussian',[50 50], 10),'same');
t = imresize(g, 0.5, 'bilinear');
l = in - imresize(t,2, 'bilinear');
end



