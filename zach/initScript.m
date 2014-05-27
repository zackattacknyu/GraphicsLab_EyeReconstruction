%IMPORTANT: Make sure to put this file in separately
fname = 'rabbit central reduced 2.tif';

info = imfinfo(fname);
num_images = numel(info);
image1 = im2double(imread(fname,1,'Info',info));
imageSize = size(image1);
allImages = zeros(imageSize(1),imageSize(2),num_images);
%videoImages = zeros(imageSize(1),imageSize(2),1,num_images);
for k = 1:num_images
    A = im2double(imread(fname, k, 'Info', info));
    allImages(:,:,k) = A;
    %videoImages(:,:,1,k) = A;
    imwrite(A,strcat('rabbitImages/image',num2str(k),'.jpg'),'JPEG');
    % ... Do something with image A ...
end
meanImage = mean(allImages,3);
imagesc(meanImage);

%{
writerObj = VideoWriter('rabbit_video_3.avi');
writerObj.FrameRate = 15;
open(writerObj);
writeVideo(writerObj,videoImages);
close(writerObj);
%}