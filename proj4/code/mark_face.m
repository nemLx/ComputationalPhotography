%% input: set filenames for your face

outimfn = 'nemo.jpg';
outsize = [1024 1024];

outfile = 'nemo.txt';
fid = fopen(outfile, 'w');

im = im2double(imread('nemo_orig.jpg'));

%% annotate
figure(1), hold off, imagesc(im), axis image;
hold on
for k = 1:43
    disp(num2str(k))
    [x(k), y(k)] = ginput(1);
    plot(x(k), y(k), '*r')
    text(x(k)+10, y(k), num2str(k));
    fprintf(fid, '%0.2f\t%0.2f\n', x(k), y(k));
end
fclose(fid);

%% crop and resize face
meanx = mean(x);
meany = mean(y);
maxx = max(x);
maxy = max(y);
minx = min(x);
miny = min(y);

faceheight = maxy-miny+1;
facewidth = maxx-minx+1;
if faceheight/outsize(1) > facewidth/outsize(2)
  facewidth = facewidth / (facewidth / outsize(2)) * (faceheight/outsize(1));
else
  faceheight = faceheight / (faceheight / outsize(1)) * (facewidth/outsize(2));
end
y1 = round(meany - faceheight*0.7);
y2 = round(meany + faceheight*0.7);
x1 = round(meanx - facewidth*0.7);
x2 = round(meanx + facewidth*0.7);
im_out = imresize(im(y1:y2, x1:x2, :), outsize, 'bilinear');
imwrite(im_out, outimfn);

x_out = (x-meanx)/(x2-x1+1)*size(im_out,2)+size(im_out,2)/2;
y_out = (y-meany)/(y2-y1+1)*size(im_out,1)+size(im_out,1)/2;
pts = [x_out(:) y_out(:)];
save(outfile, 'pts', '-ascii');