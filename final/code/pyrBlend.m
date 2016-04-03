function [o] = pyrBlend(imga, imgb, maska, maskb, level)

limga = genPyr(imga,'lap',level); % the Laplacian pyramid
limgb = genPyr(imgb,'lap',level);

blurh = fspecial('gauss',20,10); % feather the border
maska = imfilter(maska,blurh,'replicate');
maskb = imfilter(maskb,blurh,'replicate');

limgo = cell(1,level); % the blended pyramid

for p = 1:level
	[Mp, Np, ~] = size(limga{p});
	maskap = imresize(maska,[Mp Np]);
	maskbp = imresize(maskb,[Mp Np]);
	limgo{p} = limga{p}.*repmat(maskap, [1,1,3])+ limgb{p}.*repmat(maskbp, [1,1,3]);
end

o = pyrReconstruct(limgo);

end