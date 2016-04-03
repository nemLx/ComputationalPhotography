function comb = hybridImage(low, high, lowSig, highSig)

low = im2double(rgb2gray(low)); 
high = im2double(rgb2gray(high));

[high, low] = align_images(high, low);

low = imfilter(low, fspecial('gaussian', 100, lowSig), 'same');
high = high - imfilter(high, fspecial('gaussian', 100, highSig), 'same');

comb = low+high;

figure(1), hold off, imagesc(comb), axis image, colormap gray
disp('input crop points');
[x, y] = ginput(2);  x = round(x); y = round(y);
comb = comb(min(y):max(y), min(x):max(x), :);

low = low(min(y):max(y), min(x):max(x), :);
high = high(min(y):max(y), min(x):max(x), :);

imwrite(low, 'low.jpg');
imwrite(high, 'high.jpg');

figure(1), hold off, imagesc(comb), axis image, colormap gray

end

