
imname = 'rabbitImages/image1.jpg';
image1 = im2double(imread(imname));

%filter = fspecial('gaussian',5);
filter = fspecial('average',3);
newImage1 = conv2(image1,filter,'same');

image1Seg = getSegImage(newImage1);

figure
imshow(image1Seg);

figure
image1SegRefine = medfilt2(image1Seg,[2 2]);
imshow(image1SegRefine);


figure
image1BiFilter = bfilter2(image1SegRefine,[2 2],[0 0]);
imshow(image1BiFilter);
