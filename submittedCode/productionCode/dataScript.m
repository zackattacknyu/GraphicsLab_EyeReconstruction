%{

This is the production script that takes the result images
    and makes a 3D data set. It puts the data set into 
    a multi-layer TIFF file, which can be read by the
    volume renderer VolView as a 3D data set.

%}

firstImage = im2double(imread('resultImages/image1.jpg'));
sizeImage = size(firstImage);
height = sizeImage(1);
width = sizeImage(2);

numImages = 50;
threshold = 0.3;

%{
Between each result image pair, I wanted to put an image that consisted
    of the pixels where both images had fibers. This was done to bring
    out the fibers better in the final data set. In order to make sure
    this was a good idea, I generated a data set with the added images
    and one without the added images.
%}
outputName = 'rabbit_withAddedImages.TIFF'; %has the added images
outputName2 = 'rabbit_withoutAddedImages.TIFF'; %does not have added images

image1Seg = double(firstImage>threshold);

%generates the initial TIFF files
imwrite(image1Seg,outputName,'TIFF');
imwrite(image1Seg,outputName2,'TIFF');

prevImageSeg = image1Seg;

for num = 2:numImages
    
    imname = strcat('resultImages/image',num2str(num),'.jpg');
    image1 = im2double(imread(imname));

    image1Seg = double(image1>threshold);
    
    %gets the in between image
    image01Seg = double(prevImageSeg&image1Seg);
    
    %adds the current image as well as the "in between" image as
    %   another layer on the TIFF file
    imwrite(image01Seg,outputName,'writemode','append');
    imwrite(image1Seg,outputName,'writemode','append');
    
    %adds just the current image as another layer on the TIFF file
    imwrite(image1Seg,outputName2,'writemode','append');
    
    prevImageSeg = image1Seg;

end