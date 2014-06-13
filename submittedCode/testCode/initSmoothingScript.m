%{
This script is used to test different initial smoothings.
Here is the code that does the initial average filter, median filter,
    and gaussian filter. 
This was only test script to see which one was best, and averaging
    filter won that. In later scripts, the averaging filter is used
    in the first step of generating the data set of fibers.
%}

imname = 'rabbitImages/image1.jpg';
image1 = im2double(imread(imname));

filter2 = fspecial('gaussian',5);
filter = fspecial('average',3);
newImage1 = conv2(image1,filter,'same');
newImage2 = conv2(image1,filter2,'same');
newImage3 = medfilt2(image1,[2 2]);

figure
imshow(newImage1)

figure
imshow(newImage2)

figure
imshow(newImage3)