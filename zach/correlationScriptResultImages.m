image1 = im2double(imread('resultImage1.jpg'));
image2 = im2double(imread('resultImage2.jpg'));
imageTemp = im2double(rgb2gray(imread('resultImageTemplate.jpg')));

%filter = fspecial('gaussian',5);
%filter = fspecial('average',3);
%newImage1 = conv2(image1,filter,'same');
newImage1 = image1;

image1Size = size(image1);
height = image1Size(1);
width = image1Size(2);

%template = [1 1 1];
template = imageTemp;

corrImage = conv2(newImage1,rot90(template),'same');
minVal = min(min(corrImage));
maxVal = max(max(corrImage));
corrImageNorm = (corrImage-minVal)/(maxVal-minVal);

corrImage2 = conv2(image2,rot90(template),'same');
minVal2 = min(min(corrImage2));
maxVal2 = max(max(corrImage2));
corrImageNorm2 = (corrImage2-minVal2)/(maxVal2-minVal2);

threshold = 0.4;
figure
imagesc(corrImageNorm)
colorbar;
figure
imagesc(corrImageNorm2)
colorbar;
%corrImageSeg = double(corrImageNorm>threshold);
%imshow(corrImageSeg);