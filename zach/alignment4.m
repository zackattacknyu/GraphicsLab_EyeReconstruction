image1 = im2double(imread('resultImages/image1.jpg'));
image2 = im2double(imread('resultImages/image2.jpg'));
imageSize = size(image1);
height = imageSize(1);
width = imageSize(2);

threshold = 0.3;

[minRow1,maxRow1] = getMinMaxRow(image1);
[minRow2,maxRow2] = getMinMaxRow(image2);

figure
imagesc(image1(minRow1:maxRow1,:));
colorbar;

figure
imagesc(image2(minRow2:maxRow2,:));
colorbar;