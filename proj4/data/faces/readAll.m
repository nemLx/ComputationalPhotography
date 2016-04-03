IM = cell(19);
P = cell(19);

for i = 1:19
	
	imname = strcat(int2str(i), '.jpg');
	pname = strcat(int2str(i), '.txt');
	
	IM{i} = imread(imname);
	
	[X,Y] = textread(pname, '%f %f');
	Q = [X,Y];
	P{i} = Q;
	
end