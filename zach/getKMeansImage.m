function [ newSegImage ] = getKMeansImage( image1 )
%GETKMEANSIMAGE Summary of this function goes here
%   Detailed explanation goes here

[indices,cluster] = kmeans(image1(:),2);
newSegImage = reshape(double((indices==2)),size(image1));

%{
k=3;
[indices2,cluster2] = kmeans(image1(:),k);
sizeIndices = size(indices2);
numPixels = sizeIndices(1);
newBrightnessVals = indices2;
for i = 1:size(indices2)
    newBrightnessVals(i) = cluster2(indices2(i));
end
newSegImage2 = reshape(newBrightnessVals,size(image1));
%}

end

