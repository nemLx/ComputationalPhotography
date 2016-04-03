function im = colorShift(original, red, yellow)

im = rgb2lab(im2double(original));
im = lab2rgb(im(:,:,1), im(:,:,2)*red, im(:,:,3)*yellow);

imshow(im)

end
