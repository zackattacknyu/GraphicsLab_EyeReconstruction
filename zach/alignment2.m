image1 = im2double(imread('rabbitImages/image1.jpg'));
image2 = im2double(imread('rabbitImages/image2.jpg'));
imageSize = size(image1);
height = imageSize(1);
width = imageSize(2);

figure
imshow(image1)

%filter = fspecial('gaussian',5);
filter = fspecial('average',3);
newImage1 = conv2(image1,filter,'same');
%newImage1 = medfilt2(image1,[3 3]);
figure
imshow(newImage1);

threshold = 0.3;
image1data = newImage1>threshold;
%image1data = getKMeansImage(newImage1);

figure
imshow(image1data);
%image1data = image1>threshold;
%image2data = image2>threshold;


matchesMap = image1data & image2data;