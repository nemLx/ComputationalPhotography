function fftimpow = getFft(original)

fftimpow = log(abs(fftshift(fft2(original))+eps));

sv = sort(fftimpow(:));  
minv = sv(1); 
maxv = sv(end);
minv = sv(round(0.005*numel(sv)));
figure(1), hold off, imagesc(fftimpow, [minv maxv]), axis off, colormap jet, axis image

end
