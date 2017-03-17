% 
% The MATLAB code is part of the work published in the paper:
% Z Zhang, LLS Ong, K Fang, A Matthew, J Dauwels, M Dao, HH Asada. 
% "Image classification of unlabeled malaria parasites in red blood cells" 
% published in the 2016 IEEE 38th Annual International Conference of the 
% Engineering in Medicine and Biology Society (EMBC), 
% DOI: 10.1109/EMBC.2016.7591599. 
%
% This script trains a cascade object detector called 'cell_hog.xml'
% using HOG features to detect red blood cells 

TrainFiles1 = dir('train\1\*.jpg');
TrainFiles2 = dir('train\2\*.jpg');


%%%%%%%%%%%%%%%%%%%%%%%% Construction of 2D matrix from 1D image vectors
imageFilename = {};
objectBoundingBoxes = {};
a = [1,1,80,80];
for i = 1 : size(TrainFiles1,1);
    str = int2str(i);
    str = strcat('train\1\',str,'.jpg');    
    imageFilename{i} = str;
    objectBoundingBoxes{i} = a;
end
for i = 1 : size(TrainFiles2,1);
    str = int2str(i);
    str = strcat('train\2\',str,'.jpg');    
    imageFilename{i+size(TrainFiles1,1)} = str;
    objectBoundingBoxes{i+size(TrainFiles1,1)} = a;
end
data = struct('imageFilename',imageFilename,'objectBoundingBoxes',objectBoundingBoxes);
negativeFolder = fullfile('train\3\');
trainCascadeObjectDetector('cell_hog.xml',data,negativeFolder,'FalseAlarmRate',0.2,'NumCascadeStages',5,'FeatureType','HOG');