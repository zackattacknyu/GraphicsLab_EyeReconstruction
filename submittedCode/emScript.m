%{

This is a testing script that was used to test the EM algorithm
    on the image to see if it would generate good clusters.

%}


image1 = im2double(imread('rabbitImages/image1.jpg'));

filter = fspecial('average',3);
newImage1 = conv2(image1,filter,'same');

image1Size = size(image1);
height = image1Size(1);
width = image1Size(2);

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
K = 10;
method = 1;
image1DataSeq = reshape(image1Data,[N 3]);

%{

In order to perform the EM algorith, I used code that was written
    by Michael Chen and posted on the Matlab File Exchange.
This is where I called that code. This is the weblink for it:

    http://www.mathworks.com/matlabcentral/fileexchange/26184-em-algorithm-for-gaussian-mixture-model

%}
[label,model,llh] = emgm(transpose(image1DataSeq),20);

threshold = 0.25;
indices = label;
cluster = model.mu;
clusterValues = labelValues(1,:);
clusterSeg = double(clusterValues>threshold);
image1Seg = zeros(1,N);
image1NonSeg = zeros(1,N);
for index = 1:N
    image1Seg(index) = clusterSeg(indices(index));
    image1NonSeg(index) = clusterValues(indices(index));
end
image1Seg = reshape(image1Seg,[height width]);
image1NonSeg = reshape(image1NonSeg,[height width]);

%show the segmented image
figure
imshow(image1Seg);

%show the unsegmented image
figure
imagesc(image1NonSeg);
colorbar;