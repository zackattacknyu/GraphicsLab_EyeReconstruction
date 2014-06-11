%{
The data sets came to me as a multi-layer TIFF file.

This script was used to take the TIFF files and convert
    it to multiple JPEG files that were just one layer each
    and put them all into one folder.
That way they were easier to go through in order later.
%}


%IMPORTANT: Make sure to put this file in separately
%fname = 'rabbit central reduced 2.tif';
%fname = 'wildMouseCornea.tif';
fname = 'knockoutMouseCornea.tif';

info = imfinfo(fname);
num_images = numel(info);
image1 = im2double(imread(fname,1,'Info',info));
imageSize = size(image1);
allImages = zeros(imageSize(1),imageSize(2),num_images);
for k = 1:num_images
    A = im2double(imread(fname, k, 'Info', info));
    allImages(:,:,k) = A;
    imwrite(A,strcat('knockoutMouseCornea/image',num2str(k),'.jpg'),'JPEG');
end
meanImage = mean(allImages,3);
imagesc(meanImage);
