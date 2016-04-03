function [] = examine(M, P)
	
	figure(1), imshow(M), hold on
	
	for i = 1:43
		text(P(i,1), P(i,2), num2str(i));
	end
	
% 	plot(P(:,1), P(:,2));

end