% generate motion extrapolation of first point set over second point set
% 
% P: origin point set
% Q: destination point set
% extent: ratio of extrapolation

function [o] = extrapolate(P,Q,frame_count,extent)
	
% 	[p_count, nl] = size(P);
% 	o = zeros(size(P));
% 	
% 	for i = 1:p_count
% 		o(i,1) = P(i,1) + (1+extent)*(Q(i,1)-P(i,1));
% 		o(i,2) = P(i,2) + (1+extent)*(Q(i,2)-P(i,2));
% 	end
	
	[p_count, nl] = size(P);
	o = zeros([p_count, 2, frame_count]);
	
	for i = 1:frame_count
		ratio = i*(extent/frame_count);
		for j = 1:p_count
			o(j,1,i) = P(j,1) + (1+ratio)*(Q(j,1)-P(j,1));
			o(j,2,i) = P(j,2) + (1+ratio)*(Q(j,2)-P(j,2));
		end	
	end
	
end