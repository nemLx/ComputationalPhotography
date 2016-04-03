function [cost] = ssd_patch(sample, content_filter, selection_filter, gray)

	persistent s_r_q s_g_q s_b_q s_g unit;

	if gray
		
    s = sample;
		
		if isempty(s_g)
			s_g = s.^2;
			unit = ones(size(s_g));
		end
		
		content = content_filter;
		
		cost = imfilter(s_g, selection_filter);
		cost = cost + sum(sum(content.^2))*unit;
		cost = cost + imfilter(s, -2*content);
        
		cost = sqrt(cost);
		% add one to get rid of zeros
		cost = cost + unit;

		return
	end
	
	if isempty(s_r_q)
		s_r_q = sample(:,:,1).^2;
		s_g_q = sample(:,:,2).^2;
		s_b_q = sample(:,:,3).^2;
		unit = ones(size(sample(:,:,1)));
	end
	
	cost = imfilter(s_r_q, selection_filter);
	cost = cost + imfilter(s_g_q, selection_filter);
	cost = cost + imfilter(s_b_q, selection_filter);
	
	cost = cost + sum(sum(content_filter(:,:,1).^2))*unit;
	cost = cost + sum(sum(content_filter(:,:,2).^2))*unit;
	cost = cost + sum(sum(content_filter(:,:,3).^2))*unit;
	
	cost = cost + imfilter(sample(:,:,1), -2*content_filter(:,:,1));
	cost = cost + imfilter(sample(:,:,2), -2*content_filter(:,:,2));
	cost = cost + imfilter(sample(:,:,3), -2*content_filter(:,:,3));
	
	cost = sqrt(cost);
	% add one to get rid of zeros
	cost = cost + unit;
	
end