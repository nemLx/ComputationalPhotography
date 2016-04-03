% generate motion interpolation between two point sets
% 
% P: origin point set
% Q: destination point set
% frame_count: number of frames in between

function [o] = interpolate(P,Q,frame_count)
	
	[p_count, nl] = size(P);
	o = zeros([p_count, 2, frame_count]);
	
	for i = 1:frame_count
		ratio = (frame_count-i)/(frame_count-1);
		for j = 1:p_count
			o(j,1,i) = ratio*P(j,1)+(1-ratio)*Q(j,1);
			o(j,2,i) = ratio*P(j,2)+(1-ratio)*Q(j,2);
		end	
	end
	
end