function [] = runComp(file, name, size, patchsize, overlap, tol)

	in = imread(file);
	
	out = quilt_random(in, size, patchsize);
	imwrite(out(1:size-patchsize, 1:size-patchsize, :), strcat(name, '_random_', int2str(patchsize),'.jpeg'));
	
	out = quilt_simple(in, size, patchsize, overlap, tol);
	imwrite(out(1:size-patchsize, 1:size-patchsize, :), strcat(name, '_simple_', int2str(patchsize),'.jpeg'));
	
	out = quilt_cut(in, size, patchsize, overlap, tol);
	imwrite(out(1:size-patchsize, 1:size-patchsize, :), strcat(name, '_cut_', int2str(patchsize),'.jpeg'));
	
end