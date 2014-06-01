function [ segImage ] = getSegImage( image )
%GETSEGIMAGE Summary of this function goes here
%   Detailed explanation goes here

threshold=0.3;

%filter = fspecial('gaussian',5);
filter = fspecial('average',3);
newImage = conv2(image,filter,'same');

image1Seg = getKMeansImage(newImage);
image1SegRefine = medfilt2(image1Seg,[2 2]);
image1BiFilter = bfilter2(image1SegRefine,[2 2],[0 0]);


segImage = double(image1BiFilter>threshold);



end

