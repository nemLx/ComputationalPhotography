function focalLength = getFocalLengthInPixels(imW, fmm, ccdW)

	focalLength = imW*fmm/ccdW;

end