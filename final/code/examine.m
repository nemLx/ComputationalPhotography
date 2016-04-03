function [] = examine(M, P)
	
	
	[r,c] = size(P);
	figure(1), imshow(M), hold on
	
	for i = 1:r
		text(P(i,1), P(i,2), num2str(i));
	end

end