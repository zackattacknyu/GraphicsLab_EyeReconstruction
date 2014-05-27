image1 = im2double(imread('rabbitImages/image1.jpg'));
image2 = im2double(imread('rabbitImages/image2.jpg'));
imageSize = size(image1);
height = imageSize(1);
width = imageSize(2);

threshold = 0.3;
image1data = image1>threshold;
image2data = image2>threshold;

maxOffset = 10;
offsetsInfo = zeros(maxOffset+1,maxOffset+1);
for xOffset = 0:maxOffset
   for yOffset = 0:maxOffset
      
       %calculate the info for this x,y offset pair
       image1Box = image1data(1:height-yOffset,1:width-xOffset);
       image2Box = image2data(yOffset+1:height,xOffset+1:width);
       image12Aligned = double(image1Box&image2Box);
       numMatches = sum(image12Aligned(:));
       
       if(xOffset==5 && yOffset==6)
          figure
          imshow(image1Box)
          figure
          imshow(image2Box)
       end
       
       %normalizes by number possibe matches
       boxSize = size(image1Box);
       numMatchesNorm = numMatches/(boxSize(1)*boxSize(2));
       
       offsetsInfo(xOffset+1,yOffset+1) = numMatchesNorm;
       
   end
end