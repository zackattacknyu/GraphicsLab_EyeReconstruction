%{

This was used to test the two different types of k-means used:
    Naive k-means on only brightness values with k=2
    k-Means on brightness, x, and y with k=30
This was only a test script.
The function that was actually used to generate the final data set
    is in a different file.
%}

image1 = im2double(imread('rabbitImages/image1.jpg'));

filter = fspecial('average',3);
newImage1 = conv2(image1,filter,'same');

image1Size = size(image1);
height = image1Size(1);
width = image1Size(2);

threshold = 0.3;

xVals = 1:width;
xVals = xVals/width;
xValsArray = repmat(xVals,[height 1]);
yVals = 1:height;
yVals = yVals/height;
yVals = transpose(yVals);
yValsArray = repmat(yVals,[1 width]);

image1Data = zeros(height,width,3);
image1Data(:,:,1) = newImage1;
image1Data(:,:,2) = xValsArray;
image1Data(:,:,3) = yValsArray;

N = height*width;

%NOTE:
%This block of code should be used if we are testing the first k-Means
%       test, where k=2 and we are clustering on brightness
%
%image1DataSeq = reshape(newImage1,[N 1]);
%[indices,cluster] = kmeans(image1DataSeq,2);

%NOTE:
%This block of code should be used if we are testing the second k-Means
%       test, where k=30 and we are clustering on x,y, and brightness
%
image1DataSeq = reshape(image1Data,[N 3]);
[indices,cluster] = kmeans(image1DataSeq,30);

clusterValues = cluster(:,1);
clusterSeg = double(clusterValues>threshold);
image1Seg = zeros(1,N);
image1NonSeg = zeros(1,N);
for index = 1:N
    image1Seg(index) = clusterSeg(indices(index));
    image1NonSeg(index) = clusterValues(indices(index));
end
image1Seg = reshape(image1Seg,[height width]);
image1NonSeg = reshape(image1NonSeg,[height width]);

%This shows the k-Means clustering with the cluster values 
%       shown at each pixel
figure
imshow(image1NonSeg);

%This shows the k-Means clustering with each cluster classified
%   as 0 or 1 depending on which side of the threshold it is at
figure
imshow(image1Seg);