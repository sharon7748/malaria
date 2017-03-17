% 
% The MATLAB code is part of the work published in the paper:
% Z Zhang, LLS Ong, K Fang, A Matthew, J Dauwels, M Dao, HH Asada. 
% "Image classification of unlabeled malaria parasites in red blood cells" 
% published in the 2016 IEEE 38th Annual International Conference of the 
% Engineering in Medicine and Biology Society (EMBC), 
% DOI: 10.1109/EMBC.2016.7591599. 
%
% This script trains a cascade object detector called 'stage2_hog1.xml'
% using HOG features to detect if a cell is infected or uninfected 

TrainFiles1 = dir('train\1\');
Train_Number = 0;

for i = 1:size(TrainFiles1,1)
    if not(strcmp(TrainFiles1(i).name,'.')|strcmp(TrainFiles1(i).name,'..')|strcmp(TrainFiles1(i).name,'Thumbs.db'))
        Train_Number = Train_Number + 1; % Number of all images in the training database
    end
end

%%%%%%%%%%%%%%%%%%%%%%%% Construction of 2D matrix from 1D image vectors
imageFilename = {};
objectBoundingBoxes = {};
a = [1,1,40,40];
for i = 1 : Train_Number
    str = int2str(i);
    str = strcat('train\1\',str,'.jpg');    
    imageFilename{i} = str;
    objectBoundingBoxes{i} = a;
end
data = struct('imageFilename',imageFilename,'objectBoundingBoxes',objectBoundingBoxes);
negativeFolder = fullfile('train\2');
trainCascadeObjectDetector('stage2_hog1.xml',data,negativeFolder,'FalseAlarmRate',0.1,'NumCascadeStages',8,'FeatureType','HOG');