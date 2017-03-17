function varargout = malaria(varargin)
% MALARIA MATLAB code for malaria.fig
%      MALARIA, by itself, creates a new MALARIA or raises the existing
%      singleton*.
%
%      H = MALARIA returns the handle to a new MALARIA or the handle to
%      the existing singleton*.
%
%
% The MATLAB code is an example of the implementation published in the paper:
% Z Zhang, LLS Ong, K Fang, A Matthew, J Dauwels, M Dao, HH Asada. 
% "Image classification of unlabeled malaria parasites in red blood cells" 
% published in the 2016 IEEE 38th Annual International Conference of the 
% Engineering in Medicine and Biology Society (EMBC), 
% DOI: 10.1109/EMBC.2016.7591599. 

% Last Modified by GUIDE v2.5 15-Mar-2016 22:53:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @malaria_OpeningFcn, ...
                   'gui_OutputFcn',  @malaria_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before malaria is made visible.
function malaria_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to malaria (see VARARGIN)

% Choose default command line output for malaria
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes malaria wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = malaria_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
openimage


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global T
axes(handles.axes2);
T=getimage;
detector = vision.CascadeObjectDetector('cell_hog.xml');
detector.MinSize = [50 50];
detector.MaxSize = [85 85];
img = imresize(handles.img,[480 640]);
bbox= step(detector,img);
detector = vision.CascadeObjectDetector('stage2_hog1.xml');
detector.MinSize = [35 35];
detector.MaxSize = [55 55];
bboxInfected = [];
for b = 1:size(bbox,1)
    a = imcrop(img,bbox(b,:));
    [centersDark, radiiDark] = imfindcircles(a, [3 8], 'ObjectPolarity','dark','Sensitivity',0.85);
     if size(centersDark) >= 1
      %  for d= 1:size(centersDark,1)
      %  centersDark(d,:)=centersDark(d,:)+bbox(b,1:2);
      %  end
        bboxInfected=[bboxInfected;bbox(b,:)];        
    end
    %viscircles(centersDark, radiiDark,'LineStyle','--');
    bbox1= step(detector,a);
    for c = 1:size(bbox1,1)
   % bbox1(c,1:2)=bbox1(c,1:2)+bbox(b,1:2);
       bboxInfected=[bboxInfected;bbox(b,:)];

    end
   imgBase = a;
   imgGray = double(rgb2gray(a)); 
   imgGray = imgGray./max(imgGray(:));
   
   imgthres = imgGray < 0.3; 
   imgthres = imclearborder(imgthres);
   imgthres = bwareaopen(imgthres,20);
   imgthresCC = bwconncomp(imgthres);
   imgStats = regionprops(imgthresCC,'MajorAxisLength','MinorAxisLength','Centroid','Area');
   
   aspectRatio = [imgStats.MajorAxisLength]./[imgStats.MinorAxisLength];
   imgStats = imgStats(aspectRatio <5);    
   imgStats = imgStats([imgStats.Area] < 140);
   
   if(isempty(imgStats) == 0)
       bboxInfected=[bboxInfected;bbox(b,:)];       
   end
end
imshow(img);
for b = 1:size(bbox,1)
    rectangle('Position', bbox(b,:),'EdgeColor','green');
end
for b = 1:size(bboxInfected,1)
    rectangle('Position', bboxInfected(b,:),'EdgeColor','red');
end
handles.img=img;
guidata(hObject,handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 [sfilename ,sfilepath]=uiputfile({'*.jpg';'*.bmp';'*.tif';'*.*'},'save','untitled.jpg');
   if ~isequal([sfilename,sfilepath],[0,0])
      sfilefullname=[sfilepath ,sfilename];
     imwrite(handles.img,sfilefullname);
   else
      msgbox('cancle','fail');
   end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
