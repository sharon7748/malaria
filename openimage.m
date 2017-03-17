[filename,pathname]=uigetfile({'*.jpg';'*.bmp';'*.tif';'*.*'},'open');
if isequal(filename,0)|isequal(pathname,0)
    errordlg('no file','error');
    return;
else 
   file=[pathname,filename];
   global S   %设置一个全局变量S，保存初始图像路径，以便之后的还原操作
   S=file;
   x=imread(file);
   set(handles.axes1,'HandleVisibility','ON');
   axes(handles.axes1);
   imshow(x);
   set(handles.axes1,'HandleVisibility','OFF');
   axes(handles.axes2);
   imshow(x);
   handles.img=x;
   guidata(hObject,handles);
end
