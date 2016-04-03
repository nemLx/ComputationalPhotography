function [out] = merge(patch, original, ps, overlap, mode, r, c)
	
	out = original;
	c_d = c + ps - 1;
	r_d = r + ps -1;

	if mode == 0
		
		[m_a,m_b] = get_mask(out(1:ps, c:c+overlap-1,:), patch(:,1:overlap,:), 0, ps);	
		out(1:ps, c:c_d, :) = out(1:ps, c:c_d,:).*repmat(m_a,[1,1,3]);
		patch = patch.*repmat(m_b,[1,1,3]);
		out(1:ps, c:c_d,:) = out(1:ps, c:c_d,:) + patch(:,:,:);
		
	elseif mode == 1
		
		[m_a, m_b] = get_mask(out(r:r+overlap-1,1:ps, :), patch(1:overlap,:,:), 1, ps);
		out(r:r_d, 1:ps, :) = out(r:r_d, 1:ps, :).*repmat(m_a,[1,1,3]);
		patch = patch.*repmat(m_b,[1,1,3]);
		out(r:r_d,1:ps, :) = out(r:r_d,1:ps, :) + patch(:,:,:);
		
	elseif mode == 2

		[m_a,m_b] = get_mask(out(r:r+ps-1, c:c+overlap-1,:), patch(:,1:overlap,:), 0, ps);
		[m_c,m_d] = get_mask(out(r:r+overlap-1,c:c+ps-1, :), patch(1:overlap,:,:), 1, ps);
		out(r:r_d, c:c_d, :) = out(r:r_d, c:c_d, :).*repmat(m_a|m_c,[1,1,3]);
		patch = patch.*repmat(m_b&m_d,[1,1,3]);
		out(r:r_d, c:c_d,:) = out(r:r_d, c:c_d,:) + patch(:,:,:);

	end
	
end












