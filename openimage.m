[filename,pathname]=uigetfile({'*.jpg';'*.bmp';'*.tif';'*.*'},'open');
if isequal(filename,0)|isequal(pathname,0)
    errordlg('no file','error');
    return;
else 
   file=[pathname,filename];
   global S   %����һ��ȫ�ֱ���S�������ʼͼ��·�����Ա�֮��Ļ�ԭ����
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
