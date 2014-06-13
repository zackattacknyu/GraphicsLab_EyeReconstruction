function [ newSegImage ] = getKMeansImage( image1 )
%GETKMEANSIMAGE Does k-Means clustering on the image
%   This is the production code that was used to 
%       cluster the pixels of the image into fiber ones and non-fiber 
%       ones where (x,y,brightness) were the points clustered

image1Size = size(image1);
height = image1Size(1);
width = image1Size(2);

threshold = 0.3;

xVals = 1:width;
xVals = xVals/width; %normalizes the x-coordinates
xValsArray = repmat(xVals,[height 1]);
yVals = 1:height;
yVals = yVals/height; %normalizes the y-coordinates
yVals = transpose(yVals);
yValsArray = repmat(yVals,[1 width]);

%makes the points to be clustered
image1Data = zeros(height,width,3);
image1Data(:,:,1) = image1;
image1Data(:,:,2) = xValsArray;
image1Data(:,:,3) = yValsArray;

%does the k-Means clustering
N = height*width;
image1DataSeq = reshape(image1Data,[N 3]);
[indices,cluster] = kmeans(image1DataSeq,30);

%classifies the clusters
clusterValues = cluster(:,1);
clusterSeg = double(clusterValues>threshold);
image1Seg = zeros(1,N);
image1NonSeg = zeros(1,N); %in case we do not want to segment the clusters in the future
for index = 1:N
    image1Seg(index) = clusterSeg(indices(index));
    image1NonSeg(index) = clusterValues(indices(index));
end

%returns the segmented image
newSegImage = reshape(image1Seg,[height width]);

end

