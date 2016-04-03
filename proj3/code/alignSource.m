function [im2, mask2] = alignSource(im_s, mask, im_t)
% im_s2 = alignSource(im_s, mask, im_t)
% Asks user for bottom-center position and outputs an aligned source image.

figure(1), hold off, imagesc(im_s), axis image
figure(2), hold off, imagesc(im_t), axis image
[y, x] = find(mask);
y1 = min(y)-1; y2 = max(y)+1; x1 = min(x)-1; x2 = max(x)+1;
[tx, ty] = ginput(1);
tx = int64(tx);
ty = int64(ty);

im2 = zeros(size(im_s));
mask2 = zeros(size(mask));
mask2(ty:ty+(y2-y1), tx:tx+(x2-x1), :) = mask(y1:y2,x1:x2,:);
im2(ty:ty+(y2-y1), tx:tx+(x2-x1), :) = im_s(y1:y2, x1:x2, :);

% yind = (y1:y2);
% yind2 = yind - max(y) + round(ty);
% xind = (x1:x2);
% xind2 = xind - round(mean(x)) + round(tx);
% 
% y = y - max(y) + round(ty);
% x = x - round(mean(x)) + round(tx);
% ind = y + (x-1)*size(im_t, 1);
% mask2 = false(size(im_t, 1), size(im_t, 2));
% mask2(ind) = true;
% 
% im_s2(yind2, xind2, :) = im_s(yind, xind, :);

% im_t(repmat(mask2, [1 1 3])) = im_s2(repmat(mask2, [1 1 3]));

% figure(1), hold off, imagesc(im_s2), axis image;
% figure(2), hold off, imagesc(im_t), axis image;
% drawnow;
