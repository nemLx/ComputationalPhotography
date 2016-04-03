% generates a series of morphing frames between the source and target image
% 
% src : soruce image
% des : target image
% src_pts : source keypoints
% des_pts : target keypoints
% frame_count : desired number of morphing frames
% gif_offset : only used to set names of frame files when wanted to stitch
% together multiple morphs
% nomix : set to true if want to alter the geometry only
% segmented : set to true if want to display triangulation on each frame
% extrap : when greater than 0, should be the amount of extrapolation
% beyond the target geometry, 1 is 100%
%
% the functionality of this function is not very well defined, it is more
% of a script and could be easily manipulated. most of the work is done by
% morph and other helpers like extrapolate and interpolate
%

function [] = generateMorphAnimation(src, des, src_pts, des_pts, frame_count, gif_offset, nomix, segmented, extrap)

	src = im2double(src);
	des = im2double(des);
	
	if extrap > 0
		extrapolatedFrames = extrapolate(src_pts, des_pts, frame_count, extrap);
		tris = delaunay(extrapolatedFrames(:,:,frame_count/2));
        
		parfor i=1:frame_count
			instance = morph(src, src_pts, extrapolatedFrames(:,:,i), tris);
			fname = strcat('frame', int2str(i+gif_offset), '.png');
			if segmented
				imwrite(overlayTriangle(instance, extrapolatedFrames(:,:,i),tris), fname);
			else
				imwrite(instance, fname);
			end
		end
		
		return
	end
	
	animatedFrames = interpolate(src_pts, des_pts, frame_count);
	tris = delaunay(animatedFrames(:,:,frame_count/2));
	
	if nomix
		parfor i=1:frame_count
			instance = morph(src, src_pts, animatedFrames(:,:,i), tris);

			fname = strcat('frame', int2str(i+gif_offset), '.png');
			imwrite(instance, fname); 
		end
		return
	end
	
	parfor i=1:frame_count
		src_disolve_factor = (frame_count-i)/(frame_count-1);
		des_disolve_factor = 1 - src_disolve_factor;

		src_instance = morph(src_disolve_factor*src, src_pts, animatedFrames(:,:,i), tris);
		des_instance = morph(des_disolve_factor*des, des_pts, animatedFrames(:,:,i), tris);
		
		fname = strcat('frame', int2str(i+gif_offset), '.png');
		if segmented
			imwrite(overlayTriangle(src_instance+des_instance, animatedFrames(:,:,i),tris), fname);
		else
			imwrite(src_instance+des_instance, fname);
		end
	end
end
