function [] = animateAll(IM, P, frames, delay)

	[count,nl] = size(IM);

	for i = 1:count
		 generateMorphAnimation(IM{i}, IM{i+1}, P{i}, P{i+1}, frames, frames*(i-1), 1, 0, 0);
	end
	
	generateMorphAnimation(IM{8}, IM{1}, P{8}, P{1}, frames, frames*7, 1, 0, 0);
	
	%makeGif(frames*19, 'all.gif', delay);
	
end