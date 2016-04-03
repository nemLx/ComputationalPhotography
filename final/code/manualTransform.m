function [T, pt1, pt2] = manualTransform(in1, in2, xc, yc, w, fMM)

[pt1, pt2] = selectPoints(in1, in2);
pt1c = cylAll(pt1, xc, yc, w, fMM);
pt2c = cylAll(pt2, xc, yc, w, fMM);
T = computeTranslation(pt2c, pt1c);

end