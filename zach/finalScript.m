
firstImage = im2double(imread('rabbitImages/image1.jpg'));
sizeImage = size(firstImage);
height = sizeImage(1);
width = sizeImage(2);

numImages = 3;
index = 1;
numPossibleTotalValues = numImages*height*width*2;

xVals = zeros(1,numPossibleTotalValues);
yVals = zeros(1,numPossibleTotalValues);
zVals = zeros(1,numPossibleTotalValues);

prevImageSeg = zeros(sizeImage);

for num = 1:numImages
    
    imname = strcat('rabbitImages/image',num2str(num),'.jpg');
    image1 = im2double(imread(imname));

    %filter = fspecial('gaussian',5);
    filter = fspecial('average',3);
    newImage1 = conv2(image1,filter,'same');

    image1Seg = getSegImage(newImage1);
    
    image01Seg = prevImageSeg&image1Seg;
        
    for x = 1:width
       for y = 1:height
          if(image1Seg(y,x)==1)
             xVals(index) = x;
             yVals(index) = y;
             zVals(index) = num;
             index = index + 1;
          end
          if(image01Seg(y,x)==1)
             xVals(index) = x;
             yVals(index) = y;
             zVals(index) = num-0.5;
             index = index + 1;
          end
       end
    end
    
    prevImageSeg = image1Seg;
    
end

xVals = xVals(1:index);
yVals = yVals(1:index);
zVals = zVals(1:index);

plot3(xVals,yVals,zVals,'r.');

