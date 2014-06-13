%{

This is a test script that was used to test
    simple thresholding as a segmentation
    method. 

%}

imname = 'rabbitImages/image1.jpg';
image1 = im2double(imread(imname));

%does the averaging first before segmenting
filter = fspecial('average',3);
newImage1 = conv2(image1,filter,'same');

%NOTE: By trial and error, this proved to be a good threshold
threshold = 0.3;

thresholdImage = double(newImage1>threshold);
imshow(thresholdImage);