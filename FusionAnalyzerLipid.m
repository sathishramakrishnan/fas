function varargout = FusionAnalyzerLipid(varargin)
% FUSIONANALYZERLIPID MATLAB code for doing lipid mixing analysis
% FUSIONANALYZERLIPID, by itself, creates a new FUSIONANALYZERLIPID 
% or raises the existing singleton*.
%
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FusionAnalyzerLipid_OpeningFcn, ...
                   'gui_OutputFcn',  @FusionAnalyzerLipid_OutputFcn, ...
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



% --- Executes just before fusionanalyzerlipid is made visible.
function FusionAnalyzerLipid_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle upto figure
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments upto fusionanalyzerlipid (see VARARGIN)

% Choose default command line output for fusionanalyzerlipid
handles.output = hObject;

set(handles.accept,'Enable','off');
set(handles.dim,'Enable','off');
set(handles.filepath,'Enable','off');
set(handles.transfilename,'Enable','off');
set(handles.measuredistance,'Enable','off');
set(handles.pixelinfo,'Enable','off');
set(handles.identifypattern,'Enable','off');
set(handles.originalimage,'Enable','off');
set(handles.removebackground,'Enable','off');
set(handles.numbertheholes,'Enable','off');
set(handles.go,'Enable','off');
set(handles.analyzeimage,'Enable','off');
set(handles.Frameedit,'Enable','off');
set(handles.Frameslider,'Enable','off');
set(handles.curframe,'Enable','off');
set(handles.sliderimg,'Enable','off');
set(handles.holeframe,'Enable','off');
set(handles.holeslider,'Enable','off');
set(handles.gaussian,'Enable','off');
set(handles.median,'Enable','off');
set(handles.average,'Enable','off');
set(handles.unsharp,'Enable','off');
set(handles.analysisprogressinfo,'Enable','off');
set(handles.analyzeimage,'Enable','off');
set(handles.imagesubstack,'Enable','off');
set(handles.from,'Enable','off');
set(handles.to,'Enable','off');
set(handles.holenum,'Enable','off');
set(handles.a1,'xtick',[],'ytick',[])
set(handles.a2,'xtick',[],'ytick',[])
set(handles.a3,'xtick',[],'ytick',[])
set(handles.a4,'xtick',[],'ytick',[])
set(handles.a5,'xtick',[],'ytick',[])
set(handles.a6,'xtick',[],'ytick',[])
set(handles.writedata,'Enable','off');
set(handles.justplot,'Enable','off');
% pos1=get(handles.tab1Panel,'Position');
% tgroup = uitabgroup(handles.fusionanalyzerlipid,'Position',pos1);
% % tgroup = uitabgroup('Parent', handles.figure1);
% tab1 = uitab('Parent', tgroup, 'Title', 'Intensity');
% tab2 = uitab('Parent', tgroup, 'Title', 'Normalized Intensity');
% 
% %Place panels into each tab
% handles.a3 = axes('parent',tab1);
% handles.a4 = axes('parent',tab2);
% % set(handles.tab1Panel,'Parent',tab1)
% % set(handles.tab2Panel,'Parent',tab2)
% 
% %Reposition each panel to same location as panel 1
% set(handles.tab2Panel,'position',get(handles.tab1Panel,'position'));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fusionanalyzerlipid wait for user response (see UIRESUME)
% uiwait(handles.fusionanalyzerlipid);


% --- Outputs from this function are returned upto the command line.
function varargout = FusionAnalyzerLipid_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle upto figure
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function fusionanalyzerlipid_CreateFcn(hObject, eventdata, handles)
% hObject    handle upto fusionanalyzerlipid (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% *******************************************************************
% *******************************************************************
% Menu Bar
% 
% *******************************************************************
% *******************************************************************


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Menu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle upto file (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function openmovie_Callback(hObject, eventdata, handles)

% --- Executes on button press in Openpushbutton.
% Loads AVI file after choosing the file
[fileName,pathName] = uigetfile({'*.avi';'*.*'},'Open Movie');
if (fileName==0)
    warndlg('You did not selected any file','Warning') ; % file is not selected
end
[fpath, fname, fext]=fileparts(fileName);
validex=({'.avi'});
found=0;
for (x=1:length(validex))
if (strcmpi(fext,validex{x}))
     found=1;
set(handles.measuredistance,'Enable','on');
set(handles.pixelinfo,'Enable','on');
set(handles.identifypattern,'Enable','on');
set(handles.originalimage,'Enable','on');
set(handles.Frameedit,'Enable','on');
set(handles.Frameslider,'Enable','on');
% Importing File
Movie=importdata([pathName,fileName]);
h = waitbar(0,'Please wait...');
steps = 100;
for step = 1:steps
    % computations take place here
    waitbar(step / steps)
end
close(h) 
[dimen] = size(Movie(1).cdata)
dimen=num2str(dimen); set(handles.dim,'String',dimen); 
moviesize =size(Movie)
set(handles.filepath,'String',fileName); 
if isstruct(Movie)
    handles.M=Movie;
    maxframe=size(handles.M);
    set(handles.Frameslider,'Value',1);
    set(handles.Frameslider,'Max',moviesize(2));
    set(handles.Frameedit,'String','1');
    set(handles.totframes,'String',moviesize(2)); 
    axes(handles.a1);
    imshow(handles.M(round(get(handles.Frameslider,'Value'))).cdata)   
break; 
end
end
if (found==0)
     errordlg('Selected file does not match available extensions. Please select avi file ','File Format Error');
end
end
% Check the file is loaded into handles
TF = isempty(handles.M);
if (TF == 0)
    set(handles.status,'String','Analysis File Loaded')
end
set(handles.Openpushbutton,'string','Loaded','enable','on','BackgroundColor','green');
guidata(hObject, handles);

% --------------------------------------------------------------------
function savemovie_Callback(hObject, eventdata, handles)
% hObject    handle upto savemovie (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveframe_Callback(hObject, eventdata, handles)
% hObject    handle upto saveframe (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function close_Callback(hObject, eventdata, handles)
% hObject    handle upto close (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Edit Menu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function edit_Callback(hObject, eventdata, handles)
% hObject    handle upto edit (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function cut_Callback(hObject, eventdata, handles)
% hObject    handle upto cut (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function crop_Callback(hObject, eventdata, handles)
% hObject    handle upto crop (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function split_Callback(hObject, eventdata, handles)
% hObject    handle upto split (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function rotate_Callback(hObject, eventdata, handles)
% hObject    handle upto rotate (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Filters Menu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function filters_Callback(hObject, eventdata, handles)
% hObject    handle upto filters (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function gaussian_Callback(hObject, eventdata, handles)
% hObject    handle upto gaussian (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Hole = handles.hole;
[x y z] = size(Hole);
hsize=[8 8]; sigma=1.7;
h=fspecial('gaussian',hsize,sigma);
for i = 1:z
    Image = Hole(:,:,i);
    gimg=imfilter(Image,h,'replicate');
    gaussimg(:,:,i) = gimg;
end   
handles.gaussimg = gaussimg;
set(handles.holeslider,'Value',1);
set(handles.holeslider,'Max',z);
set(handles.curframe,'String','1');
holeslider_Callback(handles.holeslider, eventdata, handles)
axes(handles.a4);
guidata(hObject,handles)

% --------------------------------------------------------------------
function average_Callback(hObject, eventdata, handles)
% hObject    handle upto average (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Hole = handles.hole;
[x y z] = size(Hole);
h=fspecial('average');
for i = 1:z
    Image = Hole(:,:,i);
    aimg=imfilter(Image,h,'replicate');
    averageimg(:,:,i) = gimg;
end   
handles.averageimg = averageimg;
set(handles.holeslider,'Value',1);
set(handles.holeslider,'Max',z);
set(handles.curframe,'String','1');
holeslider_Callback(handles.holeslider, eventdata, handles)
axes(handles.a4);
guidata(hObject,handles)

% --------------------------------------------------------------------
function median_Callback(hObject, eventdata, handles)
% hObject    handle upto median (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
r=medfilt2(handles.img(:,:,1)); g=medfilt2(handles.img(:,:,2)); b=medfilt2(handles.img(:,:,3)); 
handles.img=cat(3,r,g,b);
axes(handles.g2); cla; imshow(handles.img);
guidata(hObject,handles);
updateg4(handles);

% --------------------------------------------------------------------
function unsharp_Callback(hObject, eventdata, handles)
% hObject    handle upto unsharp (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=fspecial('unsharp');
handles.img=imfilter(handles.img,h,'replicate');
axes(handles.g2); cla; imshow(handles.img)
guidata(hObject,handles);
updateg4(handles);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tools Menu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function tools_Callback(hObject, eventdata, handles)
% hObject    handle upto tools (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Process Menu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --------------------------------------------------------------------
function process_Callback(hObject, eventdata, handles)
% hObject    handle upto process (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function isolatepatterns_Callback(hObject, eventdata, handles)
% hObject    handle upto isolatepatterns (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Im = handles.im;
Out = round(255*(sum(Im,3)-min(min(sum(Im,3))))/max(max(sum(Im,3))));
BW = circledetection(Out);
mask = imfill(BW, 'holes');
labeledimage = bwlabel(mask,8);
figure, imshow(labeledimage,[]);
title('Labeled Image, from bwlabel()')
handles.mask1 = mask;
axes(handles.a2);
% final = double(Imagedata).*mask;
imshow(mask);title('Circle detection')
guidata(hObject,handles);

% --------------------------------------------------------------------
function removebg_Callback(hObject, eventdata, handles)
% hObject    handle upto removebg (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mask = handles.mask1;
Im = handles.im;
maxframe=size(handles.M);
for i= 1:maxframe(2)
    I2 = double(Im(:,:,i));
    final(:,:,i) = I2.*mask;  
end
maxframe=size(final);
handles.final=final; 
set(handles.Frameslider,'Value',10);
set(handles.Frameslider,'Max',maxframe(3));
set(handles.Frameedit,'String','1');
set(handles.Cutfromedit,'String','1');
set(handles.Cuttoedit,'String',num2str(maxframe(3)));
axes(handles.a2);
% final = double(Imagedata).*mask;
I = round(get(handles.Frameslider,'Value'));
imshow(final(:,:,I),[1 255]);
title('Background Removed')
guidata(hObject,handles);




% --------------------------------------------------------------------
function desiredhole_Callback(hObject, eventdata, handles)
% hObject    handle upto desiredhole (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=str2num(get(handles.holenum,'String'));
final = handles.final; 
Sa = handles.Sa;
If= final(:,:,1);
pos = Sa{h};
Mask2 = roipoly(If,pos(:,2),pos(:,1));
axes(handles.a2)
refreshdata
imshow(Mask2),title('Hole Extracted');
[x y z] = size(final);
for i= 1:z
    Hole = double(final(:,:,i));
    hole(:,:,i) = Hole.*Mask2;
end
handles.holenum = hole;
guidata(hObject,handles);

% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)
% hObject    handle to About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pwd;
popupmessage('/Users/Sathish/Documents/MATLAB/neuroanalyzer/help.txt')

% --------------------------------------------------------------------
function Version_Callback(hObject, eventdata, handles)
% hObject    handle to Version (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox({'Version 1.0' 'Copyright @ Yale University, 2017'},'Version');


% *******************************************************************
% *******************************************************************
% End Menu Bar
% 
% *******************************************************************
% *******************************************************************

% *******************************************************************
% *******************************************************************
% Inside Software
% 
% *******************************************************************
% *******************************************************************

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image Tools
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in measuredistance.
function measuredistance_Callback(hObject, eventdata, handles)
% hObject    handle upto measuredistance (see GCBO)
% Hint: get(hObject,'Value') returns toggle state of measuredistance
if (get(hObject,'Value')==get(hObject,'Max'))
axes(handles.a1); imdistline
elseif (get(hObject,'Value')==get(hObject,'Min'))
axes(handles.a1); imshow(handles.M(get(handles.Frameslider,'Value')).cdata)
end

% --- Executes on button press in pixelinfo.
function pixelinfo_Callback(hObject, eventdata, handles)
% Impixelinfo command
impixelinfo;

% *******************************************************************
% *******************************************************************
% Inside Software
% 
% *******************************************************************
% *******************************************************************

function acqtime_Callback(hObject, eventdata, handles)
% Controls the acquision time. Info is needed to plot.
acqtime = get(hObject,'String');
handles.acquistiontime=acqtime;
set(handles.accept,'Enable','on');
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function acqtime_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in accept.
function accept_Callback(hObject, eventdata, handles)
% Activates the software functions
set(handles.accept,'string','Accepted','enable','on','BackgroundColor','green');
acqtime = handles.acquistiontime;
guidata(hObject, handles);


% --- Executes on button press in Openpushbutton.
function Openpushbutton_Callback(hObject, eventdata, handles)
% Loads AVI file after choosing the file
[fileName,pathName] = uigetfile({'*.avi';'*.*'},'Open Movie');
if (fileName==0)
    warndlg('You did not selected any file','Warning') ; % file is not selected
end
[fpath, fname, fext]=fileparts(fileName);
validex=({'.avi'});
found=0;
for (x=1:length(validex))
if (strcmpi(fext,validex{x}))
     found=1;
set(handles.measuredistance,'Enable','on');
set(handles.pixelinfo,'Enable','on');
set(handles.identifypattern,'Enable','on');
set(handles.originalimage,'Enable','on');
set(handles.Frameedit,'Enable','on');
set(handles.Frameslider,'Enable','on');
% Importing File
Movie=importdata([pathName,fileName]);
h = waitbar(0,'Please wait...');
steps = 100;
for step = 1:steps
    % computations take place here
    waitbar(step / steps)
end
close(h) 
[dimen] = size(Movie(1).cdata)
dimen=num2str(dimen); set(handles.dim,'String',dimen); 
moviesize =size(Movie)
set(handles.filepath,'String',fileName); 
if isstruct(Movie)
    handles.M=Movie;
    maxframe=size(handles.M);
    set(handles.Frameslider,'Value',1);
    set(handles.Frameslider,'Max',moviesize(2));
    set(handles.Frameedit,'String','1');
    set(handles.totframes,'String',moviesize(2)); 
    axes(handles.a1);
    imshow(handles.M(round(get(handles.Frameslider,'Value'))).cdata)   
break; 
end
end
if (found==0)
     errordlg('Selected file does not match available extensions. Please select avi file ','File Format Error');
end
end
% Check the file is loaded into handles
TF = isempty(handles.M);
if (TF == 0)
    set(handles.status,'String','Analysis File Loaded')
end
set(handles.Openpushbutton,'string','Loaded','enable','on','BackgroundColor','green');
handles.nfmovie = [];
guidata(hObject, handles);

% --- Executes on button press in loadtransimage.
function loadtransimage_Callback(hObject, eventdata, handles)
% hObject    handle upto loadtransimage (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fileName,pathName] = uigetfile({'*.avi';'*.*'},'Open Movie');
if (fileName==0)
    warndlg('You did not selected any file','Warning') ; % file is not selected
end
[fpath, fname, fext]=fileparts(fileName);
validex=({'.avi'});
found=0;
for (x=1:length(validex))
if (strcmpi(fext,validex{x}))
     found=1;
% Importing File
T1=importdata([pathName,fileName]);
% T1=importdata('/Users/Sathish/Desktop/Series010_chan02.avi');
h = waitbar(0,'Please wait...');
steps = 100;
for step = 1:steps
    % computations take place here
    waitbar(step / steps)
end
close(h) 
ImageSize = T1(1).cdata;
set(handles.transfilename,'String',fileName); 
Trans =  T1(1).cdata;
clear T1;
end
if (found==0)
     errordlg('Selected file does not match available extensions. Please select avi file ','File Format Error');
end
end
handles.Trans = Trans;  
TF = isempty(Trans);
if (TF == 0)
    set(handles.status,'String','Trans File Loaded')
end
figure, imshow(handles.Trans)
title('Corresponding Trans image')
set(handles.loadtransimage,'string','Loaded','enable','on','BackgroundColor','green');
guidata(hObject, handles);

function Frameedit_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of Frameedit as text
%        str2double(get(hObject,'String')) returns contents of Frameedit as a double
val = round(str2double(get(handles.Frameedit,'String')));
if isnumeric(val) & length(val)==1 & ...
    val >= get(handles.Frameslider,'Min') & ...
    val <= get(handles.Frameslider,'Max')
    set(handles.Frameslider,'Value',val);
    set(handles.Frameedit,'String',num2str(val));
    axes(handles.a1);
    [Im,Map]=frame2im(handles.M(val));
    imshow(Im)
else
    set(handles.Frameedit,'String',num2str(round(get(handles.Frameslider,'Value'))));
end

% --- Executes during object creation, after setting all properties.
function Frameedit_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Frameslider_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') upto determine range of slider
val=round(get(handles.Frameslider,'Value'));
set(handles.Frameedit,'String',num2str(val));
set(handles.Frameslider, 'SliderStep', [0.01, 0.02]);
axes(handles.a1);
[Im,Map]=frame2im(handles.M(val));
TF = isempty(handles.nfmovie);
if (TF==0)
  [Im,Map]=frame2im(handles.nfmovie(val));
else
  [Im,Map]=frame2im(handles.M(val));
end
imshow(Im)

% --- Executes during object creation, after setting all properties.
function Frameslider_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% *******************************************************************
% *******************************************************************
% Smoothening and Noise Filtering
% *******************************************************************
% *******************************************************************

% --- Executes on button press in noisefiltering.
function noisefiltering_Callback(hObject, eventdata, handles)
% smoothening the movie with gaussian smoothening and median filter
nfmovsize = size(handles.M);
for i =1:nfmovsize(2)
img = handles.M(i).cdata;
img2 = imgaussfilt(img,2);
fmovie(i).cdata = img2;
fmovie(i).colormap = [];
end
if isstruct(fmovie)
    handles.nfmovie = fmovie;
    axes(handles.a1);
    imshow(handles.nfmovie(round(get(handles.Frameslider,'Value'))).cdata)   
end
% Check the file is loaded into handles
TF = isempty(handles.nfmovie);
if (TF == 0)
    set(handles.status,'String','Noise Filtered')
end
set(handles.noisefiltering,'string','Smoothened','enable','on','BackgroundColor','green');
guidata(hObject, handles);


% *******************************************************************
% *******************************************************************
% Preprocessing Tab 
% *******************************************************************
% *******************************************************************

function identifypattern_Callback(hObject, eventdata, handles)
% --- Executes on button press in iden_pattern.
Im = handles.Trans;
Out = round(255*(sum(Im,3)-min(min(sum(Im,3))))/max(max(sum(Im,3))));
BW = findpattern(Out);
mask = imfill(BW, 'holes');
hold on
figure, 
imshow(mask);title('Extract Pattern')
handles.mask = mask;
set(handles.removebackground,'Enable','on');
set(handles.curframe,'Enable','on');
set(handles.sliderimg,'Enable','on');
guidata(hObject,handles);


function originalimage_Callback(hObject, eventdata, handles)
% --- Executes on button press in originalimage.
M2 = handles.M;
if isstruct(M2)    
    maxframe=size(handles.M);
    set(handles.Frameslider,'Value',1);
    set(handles.Frameslider,'Max',maxframe(2));
    set(handles.Frameedit,'String','1');
%     set(handles.Cutfromedit,'String','1');
%     set(handles.Cuttoedit,'String',num2str(maxframe(2)));
    axes(handles.a1);
    imshow(handles.M(round(get(handles.Frameslider,'Value'))).cdata)  
for i = 1:maxframe(2)
    Imagedata = M2(i).cdata;
    Im(:,:,i) =Imagedata(:,:,1)+Imagedata(:,:,2)+Imagedata(:,:,3);
end
    handles.im = Im;
    guidata(hObject, handles);   
end


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove Background
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function removebackground_Callback(hObject, eventdata, handles)
% --- Executes on button press in removebackground.
mask = handles.mask;
M2 = handles.nfmovie;
maxframe=size(handles.M);
for i= 1:maxframe(2)
    Image = M2(i).cdata;
    I2 = double(Image);
    background = uint8(I2.*mask);  
    removedbackground(i).cdata = background;
    removedbackground(i).colormap = [];
end
save removebackground
maxframe=size(removedbackground);
handles.removedbackground=removedbackground; 
set(handles.sliderimg,'Value',1);
set(handles.sliderimg,'Max',maxframe(2));
set(handles.curframe,'String','1');
set(handles.totframes,'String',maxframe(2));
sliderimg_Callback(handles.sliderimg, eventdata, handles)
axes(handles.a2);
title('Background Removed')
set(handles.numbertheholes,'Enable','on');
set(handles.imagesubstack,'Enable','on');
set(handles.from,'Enable','on');
set(handles.to,'Enable','on');
set(handles.holenum,'Enable','on');
guidata(hObject,handles);

function sliderimg_Callback(hObject, eventdata, handles)
% Scroll Slider to move frames in the movie
val=round(get(handles.sliderimg,'Value'));
set(handles.curframe,'String',num2str(val));
set(handles.sliderimg, 'SliderStep', [0.01, 0.02]);
axes(handles.a2);
[Im,Map]=frame2im(handles.removedbackground(val));
imshow(Im)

function sliderimg_CreateFcn(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function totframes_Callback(hObject, eventdata, handles)
% hObject    handle upto totframes (see GCBO)
% totframes indicator

function totframes_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function curframe_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of curframe as text
%        str2double(get(hObject,'String')) returns contents of curframe as a double
finalval = round(str2double(get(handles.curframe,'String')));
if isnumeric(val) & length(val)==1 & ...
    val >= get(handles.sliderimg,'Min') & ...
    val <= get(handles.sliderimg,'Max')
    set(handles.sliderimg,'Value',val);
    set(handles.curframe,'String',num2str(val));
    axes(handles.a1);
    [Im,Map]=frame2im(handles.removedbackground(val));
    imshow(Im)
else
    set(handles.Frameedit,'String',num2str(round(get(handles.sliderimg,'Value'))));
end



function curframe_CreateFcn(hObject, eventdata, handles)
% --- Executes during object creation, after setting all properties.
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove Background completed
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in numbertheholes.
function numbertheholes_Callback(hObject, eventdata, handles)
mask = handles.mask;
Im =handles.Trans;
originalImage = Im(:,:,1);
labeledImage = bwlabel(mask,8);
coloredLabels =label2rgb(labeledImage,'hsv', 'k', 'shuffle');
holeMeasurements = regionprops(labeledImage, originalImage, 'all');
numberOfROIs = size(holeMeasurements, 1);
figure, imshow(originalImage);
title('Hole Numbering'); 
hold on;
boundaries = bwboundaries(mask);
numberOfBoundaries = size(boundaries, 1);
colors=['b' 'g' 'r' 'c' 'm' 'y'];
for k = 1 : numberOfBoundaries
	thisBoundary = boundaries{k};
    cidx = mod(k,length(colors))+1;
	plot(thisBoundary(:,2), thisBoundary(:,1), colors(cidx), 'LineWidth', 2);
%     rndRow = ceil(length(thisBoundary)/(mod(rand*k,7)+1));
%     col = thisBoundary(rndRow,2); row = thisBoundary(rndRow,1);
%     h = text(col+1, row-1, num2str(labeledImage(row, col)));
%     set(h,'Color',colors(cidx),...
%         'FontSize',14,'FontWeight','bold');
end
hold off;
% T = holeMeasurements;
% writetable(T,'myData.txt')
% type 'myData.txt'

textFontSize = 14;	% Size of the text printed in command window.
labelShiftX = -7;	% Align the labels.
blobECD = zeros(1, numberOfROIs); % Print header line.
fprintf(1,'Hole #      Mean Intensity  Area   Perimeter    Centroid       Diameter\n');
% Loop over all holes printing their measurements upto the command window.
for k = 1 : numberOfROIs           % Loop through all holes.
	thisBlobsPixels = holeMeasurements(k).PixelIdxList; % Get list of pixels in the hole.
	meanGL = mean(originalImage(thisBlobsPixels));      % Find mean intensity
	holeArea = holeMeasurements(k).Area;                % Get area.
	holePerimeter = holeMeasurements(k).Perimeter;		% Get perimeter.
	holeCentroid = holeMeasurements(k).Centroid;		% Get centroid
	holeECD(k) = sqrt(4 * holeArea / pi);				% Compute ECD - Equivalent Circular Diameter.
   fprintf(1,'#%2d %17.1f %11.1f %8.1f %8.1f %8.1f % 8.1f\n', k, meanGL, holeArea, holePerimeter, holeCentroid, holeECD(k));
    % Put the "hole number" labels on the "boundaries" grayscale image.
  text(holeCentroid(1) + labelShiftX, holeCentroid(2), num2str(k), 'FontSize', textFontSize, 'FontWeight', 'Bold');
end

allholeIntensities = [holeMeasurements.MeanIntensity];
allholeAreas = [holeMeasurements.Area];
% allowableIntensityIndexes = (allholeIntensities > 100);
allowableAreaIndexes = allholeAreas > 100; % Take the small objects.
keeperIndexes = find(allowableAreaIndexes);
% keeperIndexes = find(allowableIntensityIndexes & allowableAreaIndexes);
% Extract only those holes that meet our criteria, and
keeperholeImage = ismember(labeledImage, keeperIndexes);
% Re-label with only the keeper blobs kept.
labeledDimeImage = bwlabel(keeperholeImage, 8);     % Label each blob so we can make measurements of it
% Now we're done.  We have a labeled image of blobs that meet our specified criteria.
holeBinaryImage = ismember(labeledImage, keeperIndexes);
maskedImagehole = originalImage; % Create a copy.
maskedImagehole(~holeBinaryImage) = 0;  % Set all other pixels to zero.
 
% message = sprintf('Would you like upto crop out each hole upto individual movie?');
% reply = questdlg(message, 'Extract Individual Images?', 'Yes', 'No', 'Yes');
% % Note: reply will = '' for Upper right X, 'Yes' for Yes, and 'No' for No.
% 
% final = handles.im; 
% h=str2num(get(handles.holenum,'String'));
% [x y z] = size(final);
% % if strcmpi(reply, 'Yes')
%     for k = 1: numberOfROIs       % Loop through all holes.
% 		thisholeBoundingBox = holeMeasurements(k).BoundingBox;  % Get list of pixels in current blob.
% 		% Extract out this hole into it's own image.        
% %     for i= 1:z
%         subImage = imcrop(originalImage, thisholeBoundingBox);
% %         Hole = double(subImage);
% %         figure, imshow(Hole)
% %         hole(:,:,i) = Hole;
% %     hole(:,:,i) = Hole.*Mask2;
% %     end
% 		% Determine if it's a dime (small) or a nickel (large coin).
% 		if holeMeasurements(k).Area > 50
% 			Type = 'hole';
%         else	
%             Type = 'Noise';
% 		end
% 		% Display the image with informative caption.
% 		subplot(4, 4, k);
% 		imshow(subImage);
% 		caption = sprintf('Hole #%d.\nArea = %d', ...
% 			blobECD(k), holeMeasurements(k).Area);
% 		title(caption, 'FontSize', textFontSize);
%     end
% % end
% maxframe=size(Hole);
% set(handles.holeslider,'Value',1);
% set(handles.holeslider,'Max',maxframe(3));
% set(handles.holeframe,'String','1');
% handles.hole = Hole;
% holeslider_Callback(handles.holeslider, eventdata, handles)
handles.holeMeasurements = holeMeasurements;
handles.numberOfROIs = numberOfROIs;
handles.boundaries = boundaries;
set(handles.go,'Enable','on');
guidata(hObject,handles);


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create Image Substack
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function from_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of from as text
%        str2double(get(hObject,'String')) returns contents of from as a double


function from_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function to_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of to as text
%        str2double(get(hObject,'String')) returns contents of to as a double


function to_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --------------------------------------------------------------------
function imagesubstack_Callback(hObject, eventdata, handles)
% Crop the original images into substack
% Get the From and upto values
mask = handles.mask;
M2 = handles.removedbackground;
from = round(str2double(get(handles.from,'String')));
to = round(str2double(get(handles.to,'String')));
maxframe=size(handles.removedbackground);
for i= from:to
    Image = M2(i).cdata;
    I2 = uint8(double(Image));
    ImageSub(i).cdata = I2;
    ImageSub(i).colormap = [];
end
empty_elems = arrayfun(@(ImageSub) isempty(ImageSub.cdata) & isempty(ImageSub.colormap),ImageSub);
ImageSubstack = ImageSub(~empty_elems);
handles.ImageSubstack = ImageSubstack;
TF = isempty(ImageSubstack);
if (TF == 0)
    set(handles.status,'String','ImageSubstack Created')
end
guidata(hObject,handles)

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Image Substack End 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --------------------------------------------------------------------
% --------------------------------------------------------------------
% Extract Hole 
% --------------------------------------------------------------------
% --------------------------------------------------------------------
% --------------------------------------------------------------------
function holenum_Callback(hObject, eventdata, handles)
% Choose the hole number
% Used in the function go

function holenum_CreateFcn(hObject, eventdata, handles)
% Executes during object creation, after setting all properties.
% Hint: edit controls usually have a white background on Windows.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function go_Callback(hObject, eventdata, handles)
% --- Executes on button press in go.
set(handles.holeframe,'Enable','on');
set(handles.holeslider,'Enable','on');
set(handles.analyzeimage,'Enable','on');
set(handles.writedata,'Enable','on');
set(handles.justplot,'Enable','on');
holeMeasurements = handles.holeMeasurements;
numberOfROIs= handles.numberOfROIs;
h=str2num(get(handles.holenum,'String'));
% separate holes
thisholeBoundingBox = holeMeasurements(h).BoundingBox;
choice = questdlg('Do you want to process with?', ...
	'Image Selection', ...
	'Original Stack','Substack','Original Stack');
% Handle response
switch choice
    case 'Original Stack'
        final = handles.removedbackground;
        image = 1;
    case 'Substack'
        final = handles.ImageSubstack;
        image = 0;
end
[x y] = size(final);
for i = 1:y
originalImage= final(i).cdata;
%originalImage(originalImage<50)=0;
dimensions = thisholeBoundingBox; 
dimensionX = dimensions(1)+2; dimensionY = dimensions(2)+2;
CropDimensions = [dimensionX dimensionY dimensions(3)-1 dimensions(4)-1];
subImage = imcrop(originalImage, dimensions);
subImage_Size = size(subImage); 
subImage_Centers = [subImage_Size(1)/2 subImage_Size(2)/2];
r=15; % 15 pixels crop
% Get rid of Edges
X1 = subImage_Centers(1)-r;
X2 = subImage_Centers(1)+r;
Y1 = subImage_Centers(2)-r;
Y2 = subImage_Centers(2)+r;
subImage2 = imcrop(subImage,[X1,Y1,abs(X2-X1),abs(Y2-Y1)]);
Hole(i).cdata = subImage2;
Hole(i).colormap = [];
end
handles.hole = Hole;
maxframe=size(handles.hole);
set(handles.holeslider,'Value',1);
set(handles.holeslider,'Max',maxframe(2));
set(handles.holeframe,'String','1'); 
set(handles.holetotalframes,'String',maxframe(2)); 
holeslider_Callback(handles.holeslider, eventdata, handles)
axes(handles.a3);
guidata(hObject,handles);

function holeframe_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of holeframe as text
% str2double(get(hObject,'String')) returns contents of holeframe as a double
holeval = round(str2double(get(handles.holeframe,'String')));
if isnumeric(holeval) & length(holeval)==1 & ...
    holeval >= get(handles.holeslider,'Min') & ...
    holeval <= get(handles.holeslider,'Max')
    set(handles.holeslider,'Value',holeval);
    set(handles.holeframe,'String',num2str(holeval)); 
    axes(handles.a4);
    imshow(handles.hole(:,:,holeval), [1 255])    
else
    set(handles.holeframe,'String',num2str(round(get(handles.holeslider,'Value'))));
end

% --- Executes during object creation, after setting all properties.
function holeframe_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function holeslider_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') upto determine range of slider
val=round(get(handles.holeslider,'Value'));
set(handles.holeframe,'String',num2str(val));
set(handles.holeslider, 'SliderStep', [0.01, 0.02]);
axes(handles.a3);
[Im,Map]=frame2im(handles.hole(val));
imshow(Im)

% --- Executes during object creation, after setting all properties.
function holeslider_CreateFcn(hObject, eventdata, handles)
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function holetotalframes_Callback(hObject, eventdata, handles)
% Hints: get(hObject,'String') returns contents of holetotalframes as text
%        str2double(get(hObject,'String')) returns contents of holetotalframes as a double


% --- Executes during object creation, after setting all properties.
function holetotalframes_CreateFcn(hObject, eventdata, handles)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% ********************************************************************
% ********************************************************************
% Analysis
% ********************************************************************
% ********************************************************************


% --- Executes on button press in analyzeimage.
function analyzeimage_Callback(hObject, eventdata, handles)
% hObject    handle upto analyzeimage (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.analysisprogressinfo,'Enable','on');

% Import thr desired hole movie to process
finalmovie = handles.hole;
moviesize = size(finalmovie);
% Apply Average and Median Filters to smoothen the noise further
h = ones(3,3)/9;
for i = 1:moviesize(2)
    Image = finalmovie(i).cdata;
    Image = Image(:,:,1)+Image(:,:,2)+Image(:,:,3);
    avgimage = imfilter(Image,h);
    medianimage = medfilt2(avgimage);
    analyzemovie(:,:,i) = medianimage;
end 
[x y z] = size(analyzemovie); % Get the size of the movie
Img_Center = [x/2 y/2];% Find the center of the movie
% Assign the directory upto store images
Dir = uigetdir(' ', ' Choose the directory to save the images' );
set(handles.imagedirectory,'String', Dir);
% mkdir(Dir,'images')
centers = [Img_Center(1) Img_Center(2)]; % Center of the image
diameters = 4; radii = diameters/2; 
diameters2 = 8; radii2 = diameters2/2; 
for i = 1:z
    set(handles.analysisprogressinfo,'String',['Currently Processing ', num2str(i), ' of ',num2str(z),' frames']);    
%   time = time*i;
    IMA = double(analyzemovie(:,:,i)); % Number the image
    IMA(IMA<30)=0;
    bw = IMA>50; % Threshold value
    bwsum = sum(sum(bw)); % Total number of bright pixels
    img = bw.*IMA; % Masked image    
    % Initialize the variables
    drawcircle = [centers(1)-radii centers(2)-radii diameters diameters];
    drawcircle2 = [centers(1)-radii2 centers(2)-radii2 diameters2 diameters2];    
    drawcircleinfo(:,i) = drawcircle; % Store the drawcircle coordinates info  
    drawcircleinfo2(:,i) = drawcircle2; % Store the drawcircle coordinates info    
    I_imgSum(i)=sum(sum(IMA)); % Sum of Intensity of the image
    I_ringout (i) = 0;
    % Screen the image for a vesicle          
        stats = regionprops('table',bw,'Centroid','Area','PixelList',...
                        'MajorAxisLength','MinorAxisLength');        
        [m n] = size(stats);
        Area = stats.Area;
        Centroid = stats.Centroid;
        %  Record Area and Centroid as Zero if there is no Vesicle
        if isempty(Area)
            Area = 0;
        end
        if isempty(Centroid)
            Centroidx =0;
            Centroidy =0;
            
        else
        Centroidx = Centroid(1);
        Centroidy = Centroid(2);
        end
    
   % N0thing found      
   if (m == 0) 
            I_imgSum(i)=sum(sum(IMA));                      
            % plot upto store the frame
            refreshdata
            axes(handles.a4);
            h_im = imshow(IMA, [1 255]);   
            % Calculate Inner ring Intensity
            e = imellipse(gca, drawcircle);
            BWMask = createMask(e,h_im);
            im2 = BWMask.*IMA;
            I_ringIn(i)=sum(sum(im2));  
            setColor(e,'green');
            e2 = imellipse(gca, drawcircle2);
            BWMask2 = createMask(e2,h_im);
            im3 = BWMask2.*IMA;
            I_ringOut(i)=sum(sum(im3));
            setColor(e2,'red');
            hold on
%           viscircles(centers,radii);
            F=getframe(handles.a4);
            figure(); %new figure
            image(F.cdata); %show selected axes in new figure
            axis off
            filename = [sprintf('%03d',i) '.tif'];
            fullname = fullfile(Dir,filename);
            saveas(gcf,fullname)
            close(gcf); %and close it
            hold off            
           
   else 
       % Something is in the screen
        if (m >=1 )
            pixels = stats.PixelList;
            [u v] = size(pixels); Area = stats.Area;  
        end
        
        for a = 1:u
            stats1 = stats(1,:);    
            if (Area(a) >=10)
            [b c] = size(pixels{a,:});
%                 if (b>=10)
                  pixels1 = (pixels{a,1});
                  stats1 = stats(a,:);                
%                 end
            end
        end
 
           % Scan for vesicle
            h_im = imshow(IMA, [1 255]);
            e = imellipse(gca, drawcircle);
            BWMask = createMask(e,h_im);
            im2 = BWMask.*IMA;
            I_ringIn (i)=sum(sum(im2));
            setColor(e,'green');
            e2 = imellipse(gca, drawcircle2);
            BWMask2 = createMask(e,h_im);
            im3 = BWMask.*IMA;
            I_ringOut (i)=sum(sum(im3));
            setColor(e2,'red');
        
            % Vesicle Screening
        if (bwsum >= 50)
            centers = stats1.Centroid; 
            refreshdata
            axes(handles.a4);
            h_im = imshow(IMA, [1 255]);        
            hold on
            diameters = mean([stats1.MajorAxisLength stats1.MinorAxisLength],2);
            diameters = diameters+2;
            radii = (diameters/2);
            diameters2 = diameters+6;
            radii2 = diameters2/2;
            drawcircle = [centers(1)-radii centers(2)-radii diameters diameters];
            drawcircle2 = [centers(1)-radii2 centers(2)-radii2 diameters2 diameters2];
            e = imellipse(gca, drawcircle);
            BWMask = createMask(e,h_im);
            im2 = BWMask.*IMA;
            I_ringIn (i)=sum(sum(im2));
            setColor(e,'green');
            e2 = imellipse(gca, drawcircle2);
            BWMask = createMask(e2,h_im);
            im3 = BWMask.*IMA;
            I_ringOut(i)=sum(sum(im3));
            setColor(e2,'red');


            % Plot the circles
%             centers = [centers(1) centers(2)];
%             viscircles(centers,radii);
            F=getframe(handles.a4);
            figure(); %new figure
            image(F.cdata); %show selected axes in new figure
            axis off
            filename = [sprintf('%03d',i) '.tif'];
            fullname = fullfile(Dir,filename);
            saveas(gcf,fullname)
            close(gcf); %and close it
            hold off             
        end
   
   end
% I_Diff = I_ringOut - I_ringIn;

end
acqtime = str2double(handles.acquistiontime); acqtime = acqtime/1000;
totaltime = (moviesize(2)* acqtime);
time = [acqtime:acqtime:totaltime];
I_imgDiff = I_imgSum - I_ringIn;
order = 3;
framelen = 11;
sgf = sgolayfilt(I_ringIn,order,framelen);
sgf2 = sgolayfilt(I_imgDiff,order,framelen);
axes(handles.a5);
refreshdata
plot(time,sgf)
hold on
plot(time,I_imgDiff)
hold off
legend('In','Out');
xlabel('Time (s)')
ylabel('Intensities')

% Normalize with Max
for i =1:z
I_ringInNorm(i) =(I_ringIn(i)-min(I_ringIn))/(max(I_ringIn)-min(I_ringIn));
I_diffNorm(i) = (I_imgDiff(i)-min(I_imgDiff))/(max(I_imgDiff)-min(I_imgDiff));
end
%Plot the Normalized Intensities
axes(handles.a6);
refreshdata
sgfn = sgolayfilt(I_ringInNorm,order,framelen);
plot(time,sgfn)
hold on
plot(time,I_diffNorm)
hold off
legend('In','Out');
xlabel('Time(s)')
ylabel('Normalized Intensity')
guidata(hObject,handles)


% --- Executes on button press in writedata.
function writedata_Callback(hObject, eventdata, handles)
% hObject    handle to writedata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle upto analyzeimage (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uiputfile('*.txt','Save Output file name');
fname = fullfile(path, file);

set(handles.analysisprogressinfo,'Enable','on');
% Import thr desired hole movie to process
finalmovie = handles.hole;
moviesize = size(finalmovie);
% Apply Average and Median Filters to smoothen the noise further
h = ones(3,3)/9;
for i = 1:moviesize(2)
    Image = finalmovie(i).cdata;
    Image = Image(:,:,1)+Image(:,:,2)+Image(:,:,3);
    avgimage = imfilter(Image,h);
    medianimage = medfilt2(avgimage);
    analyzemovie(:,:,i) = medianimage;
end 
[x y z] = size(analyzemovie); % Get the size of the movie
Img_Center = [x/2 y/2];% Find the center of the movie
centers = [Img_Center(1) Img_Center(2)]; % Center of the image
diameters = 4; radii = diameters/2; 
diameters2 = 8; radii2 = diameters2/2; 
for i = 1:z
    set(handles.analysisprogressinfo,'String',['Currently Processing ', num2str(i), ' of ',num2str(z),' frames']);    
%   time = time*i;
    IMA = double(analyzemovie(:,:,i)); % Number the image
    IMA(IMA<30)=0;
    bw = IMA>50; % Threshold value
    bwsum = sum(sum(bw)); % Total number of bright pixels
    img = bw.*IMA; % Masked image    
    % Initialize the variables
    drawcircle = [centers(1)-radii centers(2)-radii diameters diameters];
    drawcircle2 = [centers(1)-radii2 centers(2)-radii2 diameters2 diameters2];    
    drawcircleinfo(:,i) = drawcircle; % Store the drawcircle coordinates info  
    drawcircleinfo2(:,i) = drawcircle2; % Store the drawcircle coordinates info    
    I_imgSum(i)=sum(sum(IMA)); % Sum of Intensity of the image
    I_ringout (i) = 0;
    % Screen the image for a vesicle          
        stats = regionprops('table',bw,'Centroid','Area','PixelList',...
                        'MajorAxisLength','MinorAxisLength');        
        [m n] = size(stats);
        Area = stats.Area;
        Centroid = stats.Centroid;
        %  Record Area and Centroid as Zero if there is no Vesicle
        if isempty(Area)
            Area = 0;
        end
        if isempty(Centroid)
            Centroidx =0;
            Centroidy =0;
            
        else
        Centroidx = Centroid(1);
        Centroidy = Centroid(2);
        end
    
   % N0thing found      
   if (m == 0) 
            I_imgSum(i)=sum(sum(IMA));                      
            % plot upto store the frame
            refreshdata
            axes(handles.a4);
            h_im = imshow(IMA, [1 255]);   
            % Calculate Inner ring Intensity
            e = imellipse(gca, drawcircle);
            BWMask = createMask(e,h_im);
            im2 = BWMask.*IMA;
            I_ringIn(i)=sum(sum(im2));  
            setColor(e,'green');
            e2 = imellipse(gca, drawcircle2);
            BWMask2 = createMask(e2,h_im);
            im3 = BWMask2.*IMA;
            I_ringOut(i)=sum(sum(im3));
            setColor(e2,'red');   
   else 
       % Something is in the screen
        if (m >=1 )
            pixels = stats.PixelList;
            [u v] = size(pixels); Area = stats.Area;  
        end
        
        for a = 1:u
            stats1 = stats(1,:);    
            if (Area(a) >=10)
            [b c] = size(pixels{a,:});
%                 if (b>=10)
                  pixels1 = (pixels{a,1});
                  stats1 = stats(a,:);                
%                 end
            end
        end
 
           % Scan for vesicle
            h_im = imshow(IMA, [1 255]);
            e = imellipse(gca, drawcircle);
            BWMask = createMask(e,h_im);
            im2 = BWMask.*IMA;
            I_ringIn (i)=sum(sum(im2));
            setColor(e,'green');
            e2 = imellipse(gca, drawcircle2);
            BWMask2 = createMask(e,h_im);
            im3 = BWMask.*IMA;
            I_ringOut (i)=sum(sum(im3));
            setColor(e2,'red');
        
            % Vesicle Screening
        if (bwsum >= 50)
            centers = stats1.Centroid; 
            refreshdata
            axes(handles.a4);
            h_im = imshow(IMA, [1 255]);        
            hold on
            diameters = mean([stats1.MajorAxisLength stats1.MinorAxisLength],2);
            diameters = diameters+2;
            radii = (diameters/2);
            diameters2 = diameters+7;
            radii2 = diameters2/2;
            drawcircle = [centers(1)-radii centers(2)-radii diameters diameters];
            drawcircle2 = [centers(1)-radii2 centers(2)-radii2 diameters2 diameters2];
            e = imellipse(gca, drawcircle);
            BWMask = createMask(e,h_im);
            im2 = BWMask.*IMA;
            I_ringIn (i)=sum(sum(im2));
            setColor(e,'green');
            e2 = imellipse(gca, drawcircle2);
            BWMask = createMask(e2,h_im);
            im3 = BWMask.*IMA;
            I_ringOut(i)=sum(sum(im3));
            setColor(e2,'red');
            hold off             
        end
   
   end
% I_Diff = I_ringOut - I_ringIn;
centersinfo(i,:)= centers

end
acqtime = str2double(handles.acquistiontime); acqtime = acqtime/1000;
totaltime = (moviesize(2)* acqtime);
time = [acqtime:acqtime:totaltime];
I_imgDiff = I_imgSum - I_ringIn;
order = 3;
framelen = 11;
sgf = sgolayfilt(I_ringIn,order,framelen);
sgf2 = sgolayfilt(I_imgDiff,order,framelen);
axes(handles.a5);
refreshdata
plot(time,sgf)
hold on
plot(time,I_imgDiff)
hold off
legend('In','Out');
xlabel('Time (s)')
ylabel('Intensities')

% Normalize with Max
for i =1:z
I_ringInNorm(i) =(I_ringIn(i)-min(I_ringIn))/(max(I_ringIn)-min(I_ringIn));
I_diffNorm(i) = (I_imgDiff(i)-min(I_imgDiff))/(max(I_imgDiff)-min(I_imgDiff));
end
%Plot the Normalized Intensities
axes(handles.a6);
refreshdata
sgfn = sgolayfilt(I_ringInNorm,order,framelen);
plot(time,sgfn)
hold on
plot(time,I_diffNorm)
hold off
legend('In','Out');
xlabel('Time(s)')
ylabel('Normalized Intensity')
save centroid centersinfo
% write the txt file
fid = fopen(fname, 'w');
fprintf(fid,'FRAME #      Centroid       Outer Intensity   Inner Intensity\n');
format long g; format compact;
textFontSize = 7; labelShiftX = -8;
for saveFRAMES = 1:moviesize(2)                              		
	writecenters = centersinfo(saveFRAMES,:);	
    Outer_Sum = I_imgSum(saveFRAMES);
    Inner_Intensity = I_ringIn(saveFRAMES); 
	fprintf(fid,'#%2d %8.1f %8.1f % 8.1f % 8.1f\n', saveFRAMES, writecenters, Outer_Sum, Inner_Intensity);
	text(centersinfo(1) + labelShiftX, centersinfo(2), num2str(saveFRAMES), 'FontSize', textFontSize, 'FontWeight', 'Bold');
end
fclose(fid);

% I_Diff = I_imgSum - I_ringIn;
% data_cell = sprintf( 'A%s',num2str(i+1));
% xlswrite(fname,[Area Centroidx Centroidy I_imgSum(i) I_ringIn(i) I_Diff(i)],1,data_cell);
% end
% filename1=['Frames_' num2str(frames) '.txt'];

% fid = fopen(fname, 'w');
% fprintf(fid,'FRAME #      Centroid       finaltime\n');
% for saveROI = 1 : CentroidslistX                               		
% 	centers = Centroidslist(saveROI,:);		
% 	tftime = finaltime(saveROI);				
% 	fprintf(fid,'#%2d %8.1f %8.1f % 8.1f\n', Area, Centroidx Centroidy I_imgSum(i) I_ringIn(i) I_Diff(i));
% 	text(centers(1) + labelShiftX, centers(2), num2str(ROI), 'FontSize', textFontSize, 'FontWeight', 'Bold');
% end
% fclose(fid);
guidata(hObject,handles)



% --- Executes on button press in justplot.
function justplot_Callback(hObject, eventdata, handles)
% --- Executes on button press in reset.
% This function is about to plot a graph. It will just display the plot
set(handles.analysisprogressinfo,'Enable','on');

% Import thr desired hole movie to process
finalmovie = handles.hole;
moviesize = size(finalmovie);
% Apply Average and Median Filters to smoothen the noise further
h = ones(3,3)/9;
for i = 1:moviesize(2)
    Image = finalmovie(i).cdata;
    Image = Image(:,:,1)+Image(:,:,2)+Image(:,:,3);
    avgimage = imfilter(Image,h);
    medianimage = medfilt2(avgimage);
    analyzemovie(:,:,i) = medianimage;
end 
[x y z] = size(analyzemovie); % Get the size of the movie
Img_Center = [x/2 y/2];% Find the center of the movie
centers = [Img_Center(1) Img_Center(2)]; % Center of the image
diameters = 4; radii = diameters/2; 
diameters2 = 8; radii2 = diameters2/2; 
for i = 1:z
    set(handles.analysisprogressinfo,'String',['Currently Processing ', num2str(i), ' of ',num2str(z),' frames']);    
%   time = time*i;
    IMA = double(analyzemovie(:,:,i)); % Number the image
    IMA(IMA<30)=0;
    bw = IMA>50; % Threshold value
    bwsum = sum(sum(bw)); % Total number of bright pixels
    img = bw.*IMA; % Masked image    
    % Initialize the variables
    drawcircle = [centers(1)-radii centers(2)-radii diameters diameters];
    drawcircle2 = [centers(1)-radii2 centers(2)-radii2 diameters2 diameters2];    
    drawcircleinfo(:,i) = drawcircle; % Store the drawcircle coordinates info  
    drawcircleinfo2(:,i) = drawcircle2; % Store the drawcircle coordinates info    
    I_imgSum(i)=sum(sum(IMA)); % Sum of Intensity of the image
    I_ringout (i) = 0;
    % Screen the image for a vesicle          
        stats = regionprops('table',bw,'Centroid','Area','PixelList',...
                        'MajorAxisLength','MinorAxisLength');        
        [m n] = size(stats);
        Area = stats.Area;
        Centroid = stats.Centroid;
        %  Record Area and Centroid as Zero if there is no Vesicle
        if isempty(Area)
            Area = 0;
        end
        if isempty(Centroid)
            Centroidx =0;
            Centroidy =0;
            
        else
        Centroidx = Centroid(1);
        Centroidy = Centroid(2);
        end
    
   % N0thing found      
   if (m == 0) 
            I_imgSum(i)=sum(sum(IMA));                      
            % plot upto store the frame
            refreshdata
            axes(handles.a4);
            h_im = imshow(IMA, [1 255]);   
            % Calculate Inner ring Intensity
            e = imellipse(gca, drawcircle);
            BWMask = createMask(e,h_im);
            im2 = BWMask.*IMA;
            I_ringIn(i)=sum(sum(im2));  
            setColor(e,'green');
            e2 = imellipse(gca, drawcircle2);
            BWMask2 = createMask(e2,h_im);
            im3 = BWMask2.*IMA;
            I_ringOut(i)=sum(sum(im3));
            setColor(e2,'red');   
   else 
       % Something is in the screen
        if (m >=1 )
            pixels = stats.PixelList;
            [u v] = size(pixels); Area = stats.Area;  
        end
        
        for a = 1:u
            stats1 = stats(1,:);    
            if (Area(a) >=10)
            [b c] = size(pixels{a,:});
%                 if (b>=10)
                  pixels1 = (pixels{a,1});
                  stats1 = stats(a,:);                
%                 end
            end
        end
 
           % Scan for vesicle
            h_im = imshow(IMA, [1 255]);
            e = imellipse(gca, drawcircle);
            BWMask = createMask(e,h_im);
            im2 = BWMask.*IMA;
            I_ringIn (i)=sum(sum(im2));
            setColor(e,'green');
            e2 = imellipse(gca, drawcircle2);
            BWMask2 = createMask(e,h_im);
            im3 = BWMask.*IMA;
            I_ringOut (i)=sum(sum(im3));
            setColor(e2,'red');
        
            % Vesicle Screening
        if (bwsum >= 50)
            centers = stats1.Centroid; 
            refreshdata
            axes(handles.a4);
            h_im = imshow(IMA, [1 255]);        
            hold on
            diameters = mean([stats1.MajorAxisLength stats1.MinorAxisLength],2);
            diameters = diameters+2;
            radii = (diameters/2);
            diameters2 = diameters+6;
            radii2 = diameters2/2;
            drawcircle = [centers(1)-radii centers(2)-radii diameters diameters];
            drawcircle2 = [centers(1)-radii2 centers(2)-radii2 diameters2 diameters2];
            e = imellipse(gca, drawcircle);
            BWMask = createMask(e,h_im);
            im2 = BWMask.*IMA;
            I_ringIn (i)=sum(sum(im2));
            setColor(e,'green');
            e2 = imellipse(gca, drawcircle2);
            BWMask = createMask(e2,h_im);
            im3 = BWMask.*IMA;
            I_ringOut(i)=sum(sum(im3));
            setColor(e2,'red');
            hold off             
        end
   
   end
% I_Diff = I_ringOut - I_ringIn;

end
acqtime = str2double(handles.acquistiontime); acqtime = acqtime/1000;
totaltime = (moviesize(2)* acqtime);
time = [acqtime:acqtime:totaltime];
I_imgDiff = I_imgSum - I_ringIn;
order = 3;
framelen = 11;
sgf = sgolayfilt(I_ringIn,order,framelen);
sgf2 = sgolayfilt(I_imgDiff,order,framelen);
axes(handles.a5);
refreshdata
plot(time,sgf)
hold on
plot(time,I_imgDiff)
hold off
legend('In','Out');
xlabel('Time (s)')
ylabel('Intensities')

% Normalize with Max
for i =1:z
I_ringInNorm(i) =(I_ringIn(i)-min(I_ringIn))/(max(I_ringIn)-min(I_ringIn));
I_diffNorm(i) = (I_imgDiff(i)-min(I_imgDiff))/(max(I_imgDiff)-min(I_imgDiff));
end
%Plot the Normalized Intensities
axes(handles.a6);
refreshdata
sgfn = sgolayfilt(I_ringInNorm,order,framelen);
plot(time,sgfn)
hold on
plot(time,I_diffNorm)
hold off
legend('In','Out');
xlabel('Time(s)')
ylabel('Normalized Intensity')
preference = 1;
guidata(hObject,handles)


function reset_Callback(hObject, eventdata, handles)
% hObject    handle upto reset (see GCBO)
% eventdata  reserved - upto be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcbf)
FusionAnalyzerLipid
