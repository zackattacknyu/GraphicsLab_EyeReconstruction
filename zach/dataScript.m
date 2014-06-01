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

for num = 1:numImages
    
    imname = strcat('resultImages/image',num2str(num),'.jpg');
    image1 = im2double(imread(imname));

    image1Seg = (image1>threshold);

    image01Seg = prevImageSeg&image1Seg;
        
    for x = 1:width
       for y = 1:height
          if(image1Seg(y,x)==1)
             points(index,:) = [x y num];
             index = index + 1;
          end
          if(image01Seg(y,x)==1)
              points(index,:) = [x y num-0.5];
             index = index + 1;
          end
       end
    end
    
    prevImageSeg = image1Seg;

end

points = points(1:index,:);

dlmwrite('rabbitData.txt',points);