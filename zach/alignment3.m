image1 = im2double(imread('rabbitImages/image1.jpg'));
image3 = im2double(imread('rabbitImages/image2.jpg'));
image2 = im2double(rgb2gray(imread('imageTemplate3.jpg')));
imageSize = size(image1);
height = imageSize(1);
width = imageSize(2);

threshold = 0.3;

newImage = conv2(image1,rot90(image2),'same');
newImage2 = conv2(image3,rot90(image3),'same');

minVal = min(min(newImage));
maxVal = max(max(newImage));
newImageNorm = (newImage-minVal)/(maxVal-minVal);

minVal2 = min(min(newImage2));
maxVal2 = max(max(newImage2));
newImage2Norm = (newImage2-minVal2)/(maxVal2-minVal2);

figure
imagesc(newImageNorm);
colorbar;

figure
imagesc(newImage2Norm);
colorbar;