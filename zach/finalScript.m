
image1 = im2double(imread('rabbitImages/image1.jpg'));

%filter = fspecial('gaussian',5);
filter = fspecial('average',3);
newImage1 = conv2(image1,filter,'same');

image1Seg = getSegImage(newImage1);
figure
imshow(image1Seg);

numPixels = sum(sum(image1Seg));
xVals = zeros(1,numPixels);
yVals = zeros(1,numPixels);
zVals = zeros(1,numPixels);
index = 1;
for x = 1:width
   for y = 1:height
      if(image1Seg(y,x)==1)
         xVals(index) = x;
         yVals(index) = y;
         zVals(index) = 1;
         index = index + 1;
      end
   end
end

figure
plot3(xVals,yVals,zVals,'r.');
