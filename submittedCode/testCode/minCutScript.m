%{
This is the test script that was used to generate
    the min-cut algorithm results.

%}

%averages the image
image1 = im2double(imread('image1.jpg'));
filter = fspecial('average',3);
imageInit = conv2(image1,filter,'same');
imageSize = size(imageInit);

%Instead of picking seed values, I just used
%   this to get the seed values
foreColorBWVal = max(max(imageInit));
backColorBWVal = min(min(imageInit));

%{
The min-cut script I made for Homework 3 was designed to be used
    on pixels that were RGB not brightness. Instead of re-writing the code,
    I just assigned each channel the same brightness value, which will
    yield results that are equivalent to using a single brightness value.
Most of this code then is just recycled from Homework 3.
%}
foreColor = [foreColorBWVal foreColorBWVal foreColorBWVal];
backColor = [backColorBWVal backColorBWVal backColorBWVal];

H = imageSize(1);
W = imageSize(2);

image = zeros(H,W,3);
image(:,:,1) = imageInit;
image(:,:,2) = imageInit;
image(:,:,3) = imageInit;


N = H*W;
pixelData = reshape(image,[N 3]);
backColorMatrix = repmat(backColor,[N 1]);
foreColorMatrix = repmat(foreColor,[N 1]);
foreRGBdist = sqrt(sum(abs(foreColorMatrix-pixelData),2));
backRGBdist = sqrt(sum(abs(backColorMatrix-pixelData),2));

lambda = 0.5;
segclass = zeros(N,1);
pairwise = sparse(N,N);

% Define binary classification problem
labelcost = [0 1;1 0]*lambda;
unary = [foreRGBdist backRGBdist]';

%add all horizontal links
for x = 1:W-1
  for y = 1:H
    node  = 1 + (y-1) + (x-1)*H;
    right = 1 + (y-1) + x*H;
    dist = norm(pixelData(node,:)-pixelData(right,:));
    pairwise(node,right) = dist;
    pairwise(right,node) = dist;
  end
end

%add all vertical nbr links
for x = 1:W
  for y = 1:H-1
    node = 1 + (y-1) + (x-1)*H;
    down = 1 + y + (x-1)*H;
    dist = norm(pixelData(node,:)-pixelData(down,:));
    pairwise(node,down) = dist;
    pairwise(down,node) = dist;
  end
end

%This calls the GCMex function from Homework 3
[labels E Eafter] = GCMex(segclass, single(unary), pairwise, single(labelcost),0);

figure
imagesc(reshape(labels,[H W]));


