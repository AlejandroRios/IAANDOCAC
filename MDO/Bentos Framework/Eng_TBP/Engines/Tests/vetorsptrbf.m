function varargout = vetorsptrbf(varargin)
% VETORSPTRBF MATLAB code for vetorsptrbf.fig
%      VETORSPTRBF, by itself, creates a new VETORSPTRBF or raises the existing
%      singleton*.
%
%      H = VETORSPTRBF returns the handle to a new VETORSPTRBF or the handle to
%      the existing singleton*.
%
%      VETORSPTRBF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VETORSPTRBF.M with the given input arguments.
%
%      VETORSPTRBF('Property','Value',...) creates a new VETORSPTRBF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vetorsptrbf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vetorsptrbf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vetorsptrbf

% Last Modified by GUIDE v2.5 20-Jun-2015 05:49:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vetorsptrbf_OpeningFcn, ...
                   'gui_OutputFcn',  @vetorsptrbf_OutputFcn, ...
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


% --- Executes just before vetorsptrbf is made visible.
function vetorsptrbf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vetorsptrbf (see VARARGIN)

% Choose default command line output for vetorsptrbf
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
load a
load b
load c
load d
if a==1
    set(handles.edit1,'string','Enter The Bypass Ratio Values');
elseif b==1
    set(handles.edit1,'string','Enter The Turbine Inlet Total Temperature Values In Kelvin');
elseif c==1
    set(handles.edit1,'string','Enter The Compressor Total Pressure Ratio Values');
elseif d==1
    set(handles.edit1,'string','Enter The Fan Total Pressure Ratio Values');
end

% UIWAIT makes vetorsptrbf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vetorsptrbf_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function mini_Callback(hObject, eventdata, handles)
% hObject    handle to mini (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mini as text
%        str2double(get(hObject,'String')) returns contents of mini as a double


% --- Executes during object creation, after setting all properties.
function mini_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mini (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function int_Callback(hObject, eventdata, handles)
% hObject    handle to int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of int as text
%        str2double(get(hObject,'String')) returns contents of int as a double


% --- Executes during object creation, after setting all properties.
function int_CreateFcn(hObject, eventdata, handles)
% hObject    handle to int (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxi_Callback(hObject, eventdata, handles)
% hObject    handle to maxi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxi as text
%        str2double(get(hObject,'String')) returns contents of maxi as a double


% --- Executes during object creation, after setting all properties.
function maxi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mini=str2num(get(handles.mini,'string'));
int=str2num(get(handles.int,'string'));
maxi=str2num(get(handles.maxi,'string'));
save mini mini
save int int
save maxi maxi
close('vetorsptrbf')



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
