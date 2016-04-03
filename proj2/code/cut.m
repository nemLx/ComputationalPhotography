function [path] = cut(cost, direction)
	pointers = zeros(size(cost));
	path = zeros(size(cost));
	
	[m,n] = size(cost);
	
	if direction == 0 % vertical
		for i = 2:m
			for j = 1:n
				[v, d] = min([getValue(cost, i-1, j-1, m, n), getValue(cost, i-1, j, m, n), getValue(cost, i-1, j+1, m, n)]);
				cost(i,j) = cost(i,j) + v;
				pointers(i,j) = d;
			end
		end
		
		[v, min_c] = min(cost(m,:));
		path(m, min_c) = 1;
		
		
		for i = m:-1:2
			p = pointers(i, min_c);
			if p == 1
				min_c = min_c - 1;
% 			elseif p == 2
% 				min_c = min_c;
			elseif p == 3
				min_c = min_c + 1;
			end
			path(i-1, min_c) = 1;
		end
		
	elseif direction == 1 % horizontal
		
		for i = 1:m
			for j = 2:n
				[v, d] = min([getValue(cost, i-1, j-1, m, n), getValue(cost, i, j-1, m, n), getValue(cost, i+1, j-1, m, n)]);
				cost(i,j) = cost(i,j) + v;
				pointers(i,j) = d;
			end
		end
		
		[v, min_r] = min(cost(:,n));
		path(min_r,n) = 1;
		
		for j = n:-1:2
			p = pointers(min_r, j);
			if p == 1
				min_r = min_r - 1;
% 			elseif p == 2
% 				min_r = min_r;
			elseif p == 3
				min_r = min_r + 1;
			end
			path(min_r, j-1) = 1;
		end
		
	end
	
end

function [out] = getValue(M, i, j, m, n)

	if i >=1 && i <= m && j >= 1 && j <= n
		out = M(i,j);
		return
	end
	
	out = bitmax;
end









