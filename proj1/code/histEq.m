function im = histEq(original, boundary)

double = im2double(original);
[h, s, v] = rgb2hsv(double);

c = cumsum(hist(v(:), 0:1/255:1));
v2 = c(uint16(v*255)+1)/numel(v);

im = hsv2rgb(h, s, v2*boundary + v*(1-boundary));
figure(2), imshow(im);

end