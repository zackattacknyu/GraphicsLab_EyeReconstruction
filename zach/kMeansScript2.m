A = im2double(imread('rabbitImages/image1.jpg'));
try
    kMeansImage = getKMeansImage(A);
catch err
    kMeansImage = zeros(imageSize);
end
figure
imshow(kMeansImage);