image1 = im2double(imread('rabbitImages/image1.jpg'));

%filter = fspecial('gaussian',5);
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
image1DataSeq = reshape(image1Data,[N 3]);
[indices,cluster] = kmeans(image1DataSeq,30);

clusterValues = cluster(:,1);
clusterSeg = double(clusterValues>threshold);
image1Seg = zeros(1,N);
for index = 1:N
    image1Seg(index) = clusterSeg(indices(index));
end
image1Seg = reshape(image1Seg,[height width]);
imshow(image1Seg);