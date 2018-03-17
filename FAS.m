%  ********************************************************** 
%  Codes displayed for Software Opening Window, Lipid Mixing analysis, 
%  Content Mixing analysis
%  ********************************************************** 

function varargout = FAS(varargin)
% FAS MATLAB code for FAS Opening Window
% FAS, by itself, creates a new FAS or raises the existing singleton*.
%
%      H = FAS returns the handle to a new FAS or the handle to
%      the existing singleton*.
%
%      FAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FAS.M with the given input arguments.
%
%      FAS('Property','Value',...) creates a new FAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FAS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FAS_OpeningFcn via varargin.
%
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FAS_OpeningFcn, ...
                   'gui_OutputFcn',  @FAS_OutputFcn, ...
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


% --- Executes just before FAS is made visible.
function FAS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% Choose default command line output for FAS
handles.output = hObject;
guidata(hObject, handles);
[cdata,map]=imread('neurotrans1.png');
Img=image(cdata, 'Parent', handles.axes1);
set(handles.fusionanalyzer, 'Colormap', map);
set(handles.axes1, ...
    'Visible', 'off', ...
    'YDir'   , 'reverse'       , ...
    'XLim'   , get(Img,'XData'), ...
    'YLim'   , get(Img,'YData')  ...
    );
% Make the GUI modal
set(handles.fusionanalyzer,'WindowStyle','modal')
% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = FAS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in startsoftware.
function startsoftware_Callback(hObject, eventdata, handles)
% handles    structure with handles and user data (see GUIDATA)
EXP1 = [get(handles.lipidmixing,'val')];
EXP2 = [get(handles.content,'val')];
if(EXP2 == 1)
FusionAnalyzerContent
elseif(EXP1==1)
FusionAnalyzerLipid
end
guidata(hObject, handles);
delete(handles.fusionanalyzer);
