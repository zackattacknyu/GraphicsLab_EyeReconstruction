image1 = im2double(imread('rabbitImages/image1.jpg'));
imageTemp = im2double(rgb2gray(imread('imageTemplate.jpg')));

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

threshold = 0.4;
%imshow(corrImageNorm)
corrImageSeg = double(corrImageNorm>threshold);
imshow(corrImageSeg);