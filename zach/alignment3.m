image1 = im2double(imread('rabbitImages/image1.jpg'));
image2 = im2double(rgb2gray(imread('imageTemplate2.jpg')));
imageSize = size(image1);
height = imageSize(1);
width = imageSize(2);

%filter = fspecial('gaussian',5);
filter = fspecial('average',3);
%newImage1 = conv2(image1,filter,'same');
%newImage2 = conv2(image2,filter,'same');

threshold = 0.3;

newImage = conv2(image1,rot90(image2),'same');

minVal = min(min(newImage));
maxVal = max(max(newImage));
newImageNorm = (newImage-minVal)/(maxVal-minVal);

imshow(newImageNorm);