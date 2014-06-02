firstImage = im2double(imread('resultImages/image1.jpg'));
sizeImage = size(firstImage);
height = sizeImage(1);
width = sizeImage(2);

numImages = 50;
threshold = 0.3;

outputName = 'rabbit_withAddedImages.TIFF';
outputName2 = 'rabbit_withoutAddedImages.TIFF';

image1Seg = double(firstImage>threshold);
imwrite(image1Seg,outputName,'TIFF');
imwrite(image1Seg,outputName2,'TIFF');

prevImageSeg = image1Seg;

for num = 2:numImages
    
    imname = strcat('resultImages/image',num2str(num),'.jpg');
    image1 = im2double(imread(imname));

    image1Seg = double(image1>threshold);
        
    image01Seg = double(prevImageSeg&image1Seg);
    
    imwrite(image01Seg,outputName,'writemode','append');
    imwrite(image1Seg,outputName,'writemode','append');
    imwrite(image1Seg,outputName2,'writemode','append');
    
    prevImageSeg = image1Seg;

end