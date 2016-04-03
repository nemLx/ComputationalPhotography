function [o] = trimZero(im)

[r, c, ~] = size(im);

i = r;
while i > 0
  s = sum(sum(im(i,:,:)));
  if (s>100)
    break;
  end
  i = i-1;
end

j = c;
while j > 0
  s = sum(sum(im(:,j,:)));
  if (s>100)
    break;
  end
  j = j-1;
end

o = im(1:i, 1:j, :);

end