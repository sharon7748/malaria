 # malaria
Automatic detection of malaria parasites in red blood cells

This MATLAB code is part of the work published in the paper:
Z Zhang, LLS Ong, K Fang, A Matthew, J Dauwels, M Dao, HH Asada.  "Image classification of unlabeled malaria parasites in red blood cells" published in the 2016 IEEE 38th Annual International Conference of the Engineering in Medicine and Biology Society (EMBC), DOI: 10.1109/EMBC.2016.7591599. 


This script uses a cascade object detector called 'cell_hog.xml' to detect red blood cells. From the detected red blood cell candidates, a combination of different techniques were used to identify which cells are infected or uninfected by malaria parasites.
Uninfected cells are indicated by green bounding boxes and infected cells are indicated by red bounding boxes. 
