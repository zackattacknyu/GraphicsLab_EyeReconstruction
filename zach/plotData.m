%result = dlmread('rabbitData.txt');

maxRows = 1000000;
resToPlot = result(1:maxRows,:);
plot3(resToPlot(:,1),resToPlot(:,2),resToPlot(:,3),'r.');