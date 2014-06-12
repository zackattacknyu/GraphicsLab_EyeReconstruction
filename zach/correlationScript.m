%{
This is the test script used to try out correlation as a means
    of detecting the location of the fibers.
%}

%image1 = im2double(imread('rabbitImages/image1.jpg'));
image1 = im2double(imread('rabbitImages/image2.jpg'));
imageTemp = im2double(rgb2gray(imread('imageTemplate.jpg')));

%does averaging of the original image
filter = fspecial('average',3);
newImage1 = conv2(image1,filter,'same');
figure
imshow(newImage1);

image1Size = size(image1);
height = image1Size(1);
width = image1Size(2);

%does the average filter on the template too
template = conv2(imageTemp,filter,'same');
figure
imshow(template);

%performs the correlation
corrImage = conv2(newImage1,rot90(template),'same');
minVal = min(min(corrImage));
maxVal = max(max(corrImage));
corrImageNorm = (corrImage-minVal)/(maxVal-minVal);

figure
imagesc(corrImageNorm)
colorbar;