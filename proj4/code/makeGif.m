function [] = makeGif(frame_count, name, delay)

	mov = avifile('example.avi','compression','none','fps',2);
	fig = figure;
	for i = 1:frame_count
		axis off;
		
		fname = strcat('frame', int2str(i), '.png');
		im = imread(fname);
		
		imagesc(im);
		F = getframe(fig);
		mov = addframe(mov, F);
		
% 		[imind,cm] = rgb2ind(im,256);
		
% 		if i == 1
% 			imwrite(imind, cm, name, 'Loopcount', inf);
% 		else
% 			imwrite(imind, cm, name, 'WriteMode', 'append', 'DelayTime', delay);
% 		end
	end
	
	mov = close(mov);
end