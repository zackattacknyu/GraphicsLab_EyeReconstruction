firstImage = im2double(imread('resultImages/image1.jpg'));
sizeImage = size(firstImage);
height = sizeImage(1);
width = sizeImage(2);

numImages = 50;
threshold = 0.3;

outputName = 'rabbit2_withoutAddedImages.TIFF';
outputName2 = 'rabbit2_withAddedImages.TIFF';

image1Seg = double(firstImage>threshold);
[minRow,maxRow] = getMinMaxRow(image1Seg);
rowHeight = maxRow-minRow;
image1SegUse = image1Seg(minRow:minRow+rowHeight,:);
imwrite(image1SegUse,outputName,'TIFF');
imwrite(image1SegUse,outputName2,'TIFF');

prevImageSegUse = image1SegUse;

for num = 2:numImages
    
    imname = strcat('resultImages/image',num2str(num),'.jpg');
    image1 = im2double(imread(imname));

    image1Seg = double(image1>threshold);
    [minRow,maxRow] = getMinMaxRow(image1Seg);
    image1SegUse = image1Seg(minRow:minRow+rowHeight,:);
    imwrite(image1SegUse,outputName,'writemode','append');
    
    image01SegUse = double(image1SegUse&prevImageSegUse);
    imwrite(image01SegUse,outputName2,'writemode','append');
    
    prevImageSegUse = image1SegUse;

end