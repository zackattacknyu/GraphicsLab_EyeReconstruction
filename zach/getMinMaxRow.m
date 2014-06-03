function [ minRow,maxRow ] = getMinMaxRow( image1 )
%GETMINMAXROW Gets min and max row that contains a nonzero value
imageSize = size(image1);
height = imageSize(1);
width = imageSize(2);
rowSumsImage1 = sum(image1,2);
minRow = height;
maxRow = 1;
for row = 1:height
    if(rowSumsImage1(row) > 0)
       if(row < minRow)
          minRow = row; 
       end
       if(row > maxRow)
          maxRow = row; 
       end
    end
end

end

