firstImage = im2double(imread('resultImages/image1.jpg'));
sizeImage = size(firstImage);
height = sizeImage(1);
width = sizeImage(2);

numImages = 50;
index = 1;
numPossibleTotalValues = numImages*height*width*2;

points = zeros(numPossibleTotalValues,3);
threshold = 0.3;
prevImageSeg = zeros(sizeImage);

voxelValues = zeros(1,numPossibleTotalValues);

for num = 1:numImages
    
    imname = strcat('resultImages/image',num2str(num),'.jpg');
    image1 = im2double(imread(imname));

    image1Seg = (image1>threshold);
    
    image01Seg = prevImageSeg&image1Seg;
    
    for x = 1:width
       for y = 1:height
           voxelValues(index) = uint8(image01Seg(y,x));
       end
    end
    
    for x = 1:width
       for y = 1:height
           voxelValues(index) = uint8(image1Seg(y,x));
       end
    end

    index = index + 1;
    
    prevImageSeg = image1Seg;

end

dataFile = fopen('rabbitData3.dat','w');
fwrite(dataFile,voxelValues,'uint8');
fclose(dataFile);