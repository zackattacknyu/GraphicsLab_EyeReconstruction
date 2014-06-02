
firstImage = im2double(imread('wildMouseCornea/image1.jpg'));
sizeImage = size(firstImage);
height = sizeImage(1);
width = sizeImage(2);

numImages = 50;
index = 1;
%numPossibleTotalValues = numImages*height*width*2;

%xVals = zeros(1,numPossibleTotalValues);
%yVals = zeros(1,numPossibleTotalValues);
%zVals = zeros(1,numPossibleTotalValues);

%prevImageSeg = zeros(sizeImage);

for num = 1:numImages
    
    imname = strcat('wildMouseCornea/image',num2str(num),'.jpg');
    image1 = im2double(imread(imname));

    image1Seg = getSegImage(image1);
    
    imnameWrite = strcat('wildMouseResults/image',num2str(num),'.jpg');
    imwrite(image1Seg,imnameWrite,'JPEG');
    
    %{
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
    %}
end

%{
xVals = xVals(1:index);
yVals = yVals(1:index);
zVals = zVals(1:index);

plot3(xVals,yVals,zVals,'r.');
%}

