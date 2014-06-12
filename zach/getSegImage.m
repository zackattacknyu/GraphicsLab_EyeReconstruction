function [ segImage ] = getSegImage( image )
%GETSEGIMAGE Takes in the image and returns the segmented one
%   This function will take in a single raw image
%       and perform the steps done to get a nice looking 
%       segmented image.
%   This is the production code that was used to generate 
%       the segmented images that were later put into the 3D data set.

threshold=0.3;

%does the average filter
filter = fspecial('average',3);
newImage = conv2(image,filter,'same');

%does the clustering 
% getKMeansImage is another function that I wrote
image1Seg = getKMeansImage(newImage);

%does the median filter on the segmented image
image1SegRefine = medfilt2(image1Seg,[2 2]);

%{
Does the Bilateral filter on the median filtered image
The bfilter2 code was written by Douglas Lanman 
    and posted on the Matlab file exchange:
http://www.mathworks.com/matlabcentral/fileexchange/12191-bilateral-filtering
%}
image1BiFilter = bfilter2(image1SegRefine,[2 2],[0 0]);

%makes sure the image is still segmented
segImage = double(image1BiFilter>threshold);



end

