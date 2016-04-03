% direction = 0 : vertical
%						= 1 : horizontal
function [m_a, m_b] = get_mask(p_a, p_b, direction, patchsize)
	
	ssd_r = (p_a(:,:,1) - p_b(:,:,1)).^2;
	ssd_g = (p_a(:,:,2) - p_b(:,:,2)).^2;
	ssd_b = (p_a(:,:,3) - p_b(:,:,3)).^2;
	
	cost = ssd_r + ssd_g + ssd_b;
	path = cut(cost, direction);	
	m_a = im2double(zeros([patchsize, patchsize]));
	
	[m,n] = size(path);
	
	if direction == 0
		
		for i = 1:m
			for j = 1:n
				m_a(i,j) = 1;
				if path(i,j) == 1
					break;
				end
			end
		end
		
	elseif direction == 1
		
		for j = 1:n
			for i = 1:m
				m_a(i,j) = 1;
				if path(i,j) == 1
					break;
				end
			end
		end
		
	end
	
	m_b = im2double(ones([patchsize, patchsize])) - m_a;
	
end