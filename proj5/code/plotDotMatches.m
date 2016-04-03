function [] = plotDotMatches(im, mp, mask)

[r, ~] = size(mp);

figure(1), imshow(im), hold on

for i=1:r
	if mask(i) == 1
		scatter(mp(i,1), mp(i,2), 500, '.', 'g');
	else
		scatter(mp(i,1), mp(i,2), 500, '.', 'r');
	end
end

end