function [in] = readImgs(name, count)

in = cell(1,count);

for i=1:count
	
	fname = strcat(name, '-', num2str(i), '.jpg');
	in{i} = imread(fname);
end

end