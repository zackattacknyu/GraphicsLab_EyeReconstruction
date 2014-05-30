function [ segImage ] = getSegImage( image )
%GETSEGIMAGE Summary of this function goes here
%   Detailed explanation goes here

threshold = 0.3;

segImage = double(image>threshold);



end

