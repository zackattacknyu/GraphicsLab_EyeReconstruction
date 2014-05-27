%IMPORTANT: Make sure to put this file in separately
fname = 'rabbit central reduced 2.tif';

info = imfinfo(fname);
num_images = numel(info);
image1 = im2double(imread(fname,1,'Info',info));

imageSize = size(image1);
allImages = zeros(imageSize(1),imageSize(2),num_images);

%NOTE: By trial and error, this proved to be a good threshold
threshold = 0.3;

for k = 1:10
    A = im2double(imread(fname, k, 'Info', info));
    try
        kMeansImage = double(A>threshold);
    catch err
        kMeansImage = zeros(imageSize);
    end
    figure
    imshow(kMeansImage);
    allImages(:,:,k) = kMeansImage;
    %videoImages(:,:,1,k) = kMeansImage;
end