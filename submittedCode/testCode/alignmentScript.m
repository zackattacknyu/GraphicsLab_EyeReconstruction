%{

This is the script that I used to test alignment between 
    result images to see if there is more of an overlap
    if you do a slight shift in the x or y direction.

After running this script, the greatest overlap I got was 
    when there was no offset at all.

%}

%reads the segmented images
image1 = im2double(imread('resultImages/image1.jpg'));
image2 = im2double(imread('resultImages/image2.jpg'));
imageSize = size(image1);
height = imageSize(1);
width = imageSize(2);

%makes the logical array from the segmented images
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
       
       %normalizes by number possibe matches
       boxSize = size(image1Box);
       numMatchesNorm = numMatches/(boxSize(1)*boxSize(2));
       
       offsetsInfo(xOffset+1,yOffset+1) = numMatchesNorm;
       
   end
end
