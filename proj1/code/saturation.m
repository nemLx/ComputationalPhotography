function im = saturation(original, power)

double = im2double(original);
[h, s, v] = rgb2hsv(double);

im = hsv2rgb(h, s.^power, v);
imshow(im)
    
end
