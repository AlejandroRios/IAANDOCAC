function varargout = cnturbofan(varargin)
% CNTURBOFAN MATLAB code for cnturbofan.fig
%      CNTURBOFAN, by itself, creates a new CNTURBOFAN or raises the existing
%      singleton*.
%
%      H = CNTURBOFAN returns the handle to a new CNTURBOFAN or the handle to
%      the existing singleton*.
%
%      CNTURBOFAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CNTURBOFAN.M with the given input arguments.
%
%      CNTURBOFAN('Property','Value',...) creates a new CNTURBOFAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cnturbofan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cnturbofan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cnturbofan

% Last Modified by GUIDE v2.5 07-Jun-2015 23:26:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cnturbofan_OpeningFcn, ...
                   'gui_OutputFcn',  @cnturbofan_OutputFcn, ...
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


% --- Executes just before cnturbofan is made visible.
function cnturbofan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cnturbofan (see VARARGIN)

% Choose default command line output for cnturbofan
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cnturbofan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cnturbofan_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function g_Callback(hObject, eventdata, handles)
% hObject    handle to g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g as text
%        str2double(get(hObject,'String')) returns contents of g as a double


% --- Executes during object creation, after setting all properties.
function g_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function gaf_Callback(hObject, eventdata, handles)
% hObject    handle to gaf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gaf as text
%        str2double(get(hObject,'String')) returns contents of gaf as a double


% --- Executes during object creation, after setting all properties.
function gaf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cp_Callback(hObject, eventdata, handles)
% hObject    handle to cp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cp as text
%        str2double(get(hObject,'String')) returns contents of cp as a double


% --- Executes during object creation, after setting all properties.
function cp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cpaf_Callback(hObject, eventdata, handles)
% hObject    handle to cpaf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cpaf as text
%        str2double(get(hObject,'String')) returns contents of cpaf as a double


% --- Executes during object creation, after setting all properties.
function cpaf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cpaf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function prd_Callback(hObject, eventdata, handles)
% hObject    handle to prd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prd as text
%        str2double(get(hObject,'String')) returns contents of prd as a double


% --- Executes during object creation, after setting all properties.
function prd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nc_Callback(hObject, eventdata, handles)
% hObject    handle to nc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nc as text
%        str2double(get(hObject,'String')) returns contents of nc as a double


% --- Executes during object creation, after setting all properties.
function nc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nb_Callback(hObject, eventdata, handles)
% hObject    handle to nb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nb as text
%        str2double(get(hObject,'String')) returns contents of nb as a double


% --- Executes during object creation, after setting all properties.
function nb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function prb_Callback(hObject, eventdata, handles)
% hObject    handle to prb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prb as text
%        str2double(get(hObject,'String')) returns contents of prb as a double


% --- Executes during object creation, after setting all properties.
function prb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nm_Callback(hObject, eventdata, handles)
% hObject    handle to nm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nm as text
%        str2double(get(hObject,'String')) returns contents of nm as a double


% --- Executes during object creation, after setting all properties.
function nm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function prn_Callback(hObject, eventdata, handles)
% hObject    handle to prn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prn as text
%        str2double(get(hObject,'String')) returns contents of prn as a double


% --- Executes during object creation, after setting all properties.
function prn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function prc_Callback(hObject, eventdata, handles)
% hObject    handle to prc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prc as text
%        str2double(get(hObject,'String')) returns contents of prc as a double


% --- Executes during object creation, after setting all properties.
function prc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tt4_Callback(hObject, eventdata, handles)
% hObject    handle to Tt4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tt4 as text
%        str2double(get(hObject,'String')) returns contents of Tt4 as a double


% --- Executes during object creation, after setting all properties.
function Tt4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tt4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function m0_Callback(hObject, eventdata, handles)
% hObject    handle to m0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m0 as text
%        str2double(get(hObject,'String')) returns contents of m0 as a double


% --- Executes during object creation, after setting all properties.
function m0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function p0_Callback(hObject, eventdata, handles)
% hObject    handle to p0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of p0 as text
%        str2double(get(hObject,'String')) returns contents of p0 as a double


% --- Executes during object creation, after setting all properties.
function p0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to p0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function T0_Callback(hObject, eventdata, handles)
% hObject    handle to T0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T0 as text
%        str2double(get(hObject,'String')) returns contents of T0 as a double


% --- Executes during object creation, after setting all properties.
function T0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function LHV_Callback(hObject, eventdata, handles)
% hObject    handle to LHV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LHV as text
%        str2double(get(hObject,'String')) returns contents of LHV as a double


% --- Executes during object creation, after setting all properties.
function LHV_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LHV (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function A9Rm0_Callback(hObject, eventdata, handles)
% hObject    handle to A9Rm0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A9Rm0 as text
%        str2double(get(hObject,'String')) returns contents of A9Rm0 as a double


% --- Executes during object creation, after setting all properties.
function A9Rm0_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A9Rm0 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function status_Callback(hObject, eventdata, handles)
% hObject    handle to status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of status as text
%        str2double(get(hObject,'String')) returns contents of status as a double


% --- Executes during object creation, after setting all properties.
function status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function prf_Callback(hObject, eventdata, handles)
% hObject    handle to prf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prf as text
%        str2double(get(hObject,'String')) returns contents of prf as a double


% --- Executes during object creation, after setting all properties.
function prf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes on button press in pushbutton1.
function alpha_Callback(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha as text
%        str2double(get(hObject,'String')) returns contents of alpha as a double


% --- Executes during object creation, after setting all properties.
function alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function prfn_Callback(hObject, eventdata, handles)
% hObject    handle to prfn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prfn as text
%        str2double(get(hObject,'String')) returns contents of prfn as a double


% --- Executes during object creation, after setting all properties.
function prfn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prfn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nf_Callback(hObject, eventdata, handles)
% hObject    handle to nf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nf as text
%        str2double(get(hObject,'String')) returns contents of nf as a double


% --- Executes during object creation, after setting all properties.
function nf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function et_Callback(hObject, eventdata, handles)
% hObject    handle to et (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of et as text
%        str2double(get(hObject,'String')) returns contents of et as a double


% --- Executes during object creation, after setting all properties.
function et_CreateFcn(hObject, eventdata, handles)
% hObject    handle to et (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function alpha2_Callback(hObject, eventdata, handles)
% hObject    handle to alpha2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha2 as text
%        str2double(get(hObject,'String')) returns contents of alpha2 as a double


% --- Executes during object creation, after setting all properties.
function alpha2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alpha3_Callback(hObject, eventdata, handles)
% hObject    handle to alpha3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha3 as text
%        str2double(get(hObject,'String')) returns contents of alpha3 as a double


% --- Executes during object creation, after setting all properties.
function alpha3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% --- Executes when selected object is changed in uipanel6.
function uipanel6_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel6 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
a=get(handles.a, 'Value');
b=get(handles.b, 'Value');
c=get(handles.c, 'Value');
d=get(handles.d, 'Value');
save a a
save b b
save c c
save d d
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load a
load b
load c
load d
format bank
prds=get(handles.prd,'string');
prd=str2num(prds);
ncs=get(handles.nc,'string');
nc=str2num(ncs);
ets=get(handles.et,'string');
et=str2num(ets);
nbs=get(handles.nb,'string');
nb=str2num(nbs);
prbs=get(handles.prb,'string');
prb=str2num(prbs);
nms=get(handles.nm,'string');
nm=str2num(nms);
prns=get(handles.prn,'string');
prn=str2num(prns);
prcs=get(handles.prc,'string');
prc=str2num(prcs);
LHVs=get(handles.LHV,'string');
LHVk=str2num(LHVs);
LHV=(LHVk*1000);
prds=get(handles.prd,'string');
prd=str2num(prds);
ncs=get(handles.nc,'string');
nc=str2num(ncs);
nbs=get(handles.nb,'string');
nb=str2num(nbs);
prbs=get(handles.prb,'string');
prb=str2num(prbs);
nts=get(handles.nm,'string');
nt=str2num(nts);
prns=get(handles.prn,'string');
prn=str2num(prns);
prcs=get(handles.prc,'string');
prc=str2num(prcs);
Tt4s=get(handles.Tt4,'string');
Tt4=str2num(Tt4s);
m0s=get(handles.m0,'string');
m0=str2num(m0s);
p0s=get(handles.p0,'string');
p0k=str2num(p0s);
p0=(p0k*1000);
T0s=get(handles.T0,'string');
T0=str2num(T0s);
gs=get(handles.g,'string');
g=str2num(gs);
cps=get(handles.cp,'string');
cp=str2num(cps);
gafs=get(handles.gaf,'string');
gaf=str2num(gafs);
cpafs=get(handles.cpaf,'string');
cpaf=str2num(cpafs);
prfs=get(handles.prf,'string');
prf=str2num(prfs);
alphas=get(handles.alpha,'string');
alpha=str2num(alphas);
prfns=get(handles.prfn,'string');
prfn=str2num(prfns);
nfs=get(handles.nf,'string');
nf=str2num(nfs);
R=((cp*(g-1))/g);
Raf=((cpaf*(gaf-1))/gaf);
if a==1
    
    vetorsptrbf
    uiwait
load mini
load int
load maxi
format bank
[a0 v0 pt0 Tt0 pt2 Tt2 pt13 Tt13 pt19 Tt19 m19 T19 p19 r19 v19 v19eff pt3 Tt3 pt4 f pt5 Tt5 Tt9 pt9 m9 p9 T9 v9 A9Rm0 veff nspthrf nspthr rfc nth nspthrs np no TSFC nspthrsalpha]=turbofan(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nm,prn,Raf,et,prf,prfn,nf,mini);
alphav=mini:int:maxi;
for alpha=alphav(2):int:maxi
 [a01 v01 pt01 Tt01 pt21 Tt21 pt131 Tt131 pt191 Tt191 m191 T191 p191 r191 v191 v19eff1 pt31 Tt31 pt41 f1 pt51 Tt51 Tt91 pt91 m91 p91 T91 v91 A9Rm01 veff1 nspthrf1 nspthr1 rfc1 nth1 nspthrs1 np1 no1 TSFC1 nspthrsalpha1]=turbofan1(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nm,prn,Raf,et,prf,prfn,nf,alpha);
    a0=[a0 a01];
    v0=[v0 v01];
    pt0=[pt0 pt01];
    Tt0=[Tt0 Tt01];
    pt2=[pt2 pt21];
    Tt2=[Tt2 Tt21];
    pt13=[pt13 pt131];
    Tt13=[Tt13 Tt131]; 
    pt19=[pt19 pt191];
    Tt19=[Tt19 Tt191];
    m19=[m19 m191];
    T19=[T19 T191]; 
    p19=[p19 p191];
    r19=[r19 r191]; 
    v19=[v19 v191];
    v19eff=[v19eff v19eff1];
    pt3=[pt3 pt31];
    Tt3=[Tt3 Tt31];
    pt4=[pt4 pt41];
    f=[f f1];
    pt5=[pt5 pt51];
    Tt5=[Tt5 Tt51];
    Tt9=[Tt9 Tt91];
    pt9=[pt9 pt91];
    m9=[m9 m91];
    p9=[p9 p91];
    T9=[T9 T91];
    v9=[v9 v91];
    A9Rm0=[A9Rm0 A9Rm01];
    veff=[veff veff1];
    nspthrf=[nspthrf nspthrf1]; 
    nspthr=[nspthr nspthr1];
    rfc=[rfc rfc1];
    nth=[nth nth1];
    np=[np np1];
    no=[no no1];
    TSFC=[ TSFC  TSFC1];
    nspthrs=[nspthrs nspthrs1];
    nspthrsalpha=[nspthrsalpha nspthrsalpha1];
end
save alphav alphav
guidata(hObject,handles)
save TSFC TSFC
guidata(hObject,handles)
save nth nth
guidata(hObject,handles)
save np np
guidata(hObject,handles)
save no no
guidata(hObject,handles)
save nspthrs nspthrs
guidata(hObject,handles)
save nspthrsalpha nspthrsalpha
guidata(hObject,handles)
elseif b==1
vetorsptrbf
    uiwait
load mini
load int
load maxi
format bank
[a0 v0 pt0 Tt0 pt2 Tt2 pt13 Tt13 pt19 Tt19 m19 T19 p19 r19 v19 v19eff pt3 Tt3 pt4 f pt5 Tt5 Tt9 pt9 m9 p9 T9 v9 A9Rm0 veff nspthrf nspthr rfc nth nspthrs np no TSFC nspthrsalpha]=turbofan(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,mini,LHV,nb,prb,gaf,nm,prn,Raf,et,prf,prfn,nf,alpha);
Tt4v=mini:int:maxi;
for Tt4=Tt4v(2):int:maxi
    [a01 v01 pt01 Tt01 pt21 Tt21 pt131 Tt131 pt191 Tt191 m191 T191 p191 r191 v191 v19eff1 pt31 Tt31 pt41 f1 pt51 Tt51 Tt91 pt91 m91 p91 T91 v91 A9Rm01 veff1 nspthrf1 nspthr1 rfc1 nth1 nspthrs1 np1 no1 TSFC1 nspthrsalpha1]=turbofan1(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nm,prn,Raf,et,prf,prfn,nf,alpha);
 a0=[a0 a01];
    v0=[v0 v01];
    pt0=[pt0 pt01];
    Tt0=[Tt0 Tt01];
    pt2=[pt2 pt21];
    Tt2=[Tt2 Tt21];
    pt13=[pt13 pt131];
    Tt13=[Tt13 Tt131]; 
    pt19=[pt19 pt191];
    Tt19=[Tt19 Tt191];
    m19=[m19 m191];
    T19=[T19 T191]; 
    p19=[p19 p191];
    r19=[r19 r191]; 
    v19=[v19 v191];
    v19eff=[v19eff v19eff1];
    pt3=[pt3 pt31];
    Tt3=[Tt3 Tt31];
    pt4=[pt4 pt41];
    f=[f f1];
    pt5=[pt5 pt51];
    Tt5=[Tt5 Tt51];
    Tt9=[Tt9 Tt91];
    pt9=[pt9 pt91];
    m9=[m9 m91];
    p9=[p9 p91];
    T9=[T9 T91];
    v9=[v9 v91];
    A9Rm0=[A9Rm0 A9Rm01];
    veff=[veff veff1];
    nspthrf=[nspthrf nspthrf1]; 
    nspthr=[nspthr nspthr1];
    rfc=[rfc rfc1];
    nth=[nth nth1];
    np=[np np1];
    no=[no no1];
    TSFC=[ TSFC  TSFC1];
    nspthrs=[nspthrs nspthrs1];
    nspthrsalpha=[nspthrsalpha nspthrsalpha1];
    end
save Tt4v Tt4v
guidata(hObject,handles)
save TSFC TSFC
guidata(hObject,handles)
save nth nth
guidata(hObject,handles)
save np np
guidata(hObject,handles)
save no no
guidata(hObject,handles)
save nspthrs nspthrs
guidata(hObject,handles)
save nspthrsalpha nspthrsalpha
guidata(hObject,handles)
elseif c==1
vetorsptrbf
    uiwait
load mini
load int
load maxi
format bank
[a0 v0 pt0 Tt0 pt2 Tt2 pt13 Tt13 pt19 Tt19 m19 T19 p19 r19 v19 v19eff pt3 Tt3 pt4 f pt5 Tt5 Tt9 pt9 m9 p9 T9 v9 A9Rm0 veff nspthrf nspthr rfc nth nspthrs np no TSFC nspthrsalpha]=turbofan(R,g,T0,m0,p0,cp,prd,mini,nc,cpaf,Tt4,LHV,nb,prb,gaf,nm,prn,Raf,et,prf,prfn,nf,alpha);
prcv=mini:int:maxi;
for prc=prcv(2):int:maxi
    [a01 v01 pt01 Tt01 pt21 Tt21 pt131 Tt131 pt191 Tt191 m191 T191 p191 r191 v191 v19eff1 pt31 Tt31 pt41 f1 pt51 Tt51 Tt91 pt91 m91 p91 T91 v91 A9Rm01 veff1 nspthrf1 nspthr1 rfc1 nth1 nspthrs1 np1 no1 TSFC1 nspthrsalpha1]=turbofan1(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nm,prn,Raf,et,prf,prfn,nf,alpha);
 a0=[a0 a01];
    v0=[v0 v01];
    pt0=[pt0 pt01];
    Tt0=[Tt0 Tt01];
    pt2=[pt2 pt21];
    Tt2=[Tt2 Tt21];
    pt13=[pt13 pt131];
    Tt13=[Tt13 Tt131]; 
    pt19=[pt19 pt191];
    Tt19=[Tt19 Tt191];
    m19=[m19 m191];
    T19=[T19 T191]; 
    p19=[p19 p191];
    r19=[r19 r191]; 
    v19=[v19 v191];
    v19eff=[v19eff v19eff1];
    pt3=[pt3 pt31];
    Tt3=[Tt3 Tt31];
    pt4=[pt4 pt41];
    f=[f f1];
    pt5=[pt5 pt51];
    Tt5=[Tt5 Tt51];
    Tt9=[Tt9 Tt91];
    pt9=[pt9 pt91];
    m9=[m9 m91];
    p9=[p9 p91];
    T9=[T9 T91];
    v9=[v9 v91];
    A9Rm0=[A9Rm0 A9Rm01];
    veff=[veff veff1];
    nspthrf=[nspthrf nspthrf1]; 
    nspthr=[nspthr nspthr1];
    rfc=[rfc rfc1];
    nth=[nth nth1];
    np=[np np1];
    no=[no no1];
    TSFC=[ TSFC  TSFC1];
    nspthrs=[nspthrs nspthrs1];
    nspthrsalpha=[nspthrsalpha nspthrsalpha1];
    end
save prcv prcv
guidata(hObject,handles)
save TSFC TSFC
guidata(hObject,handles)
save nth nth
guidata(hObject,handles)
save np np
guidata(hObject,handles)
save no no
guidata(hObject,handles)
save nspthrs nspthrs
guidata(hObject,handles)
save nspthrsalpha nspthrsalpha
guidata(hObject,handles)
elseif d==1
vetorsptrbf
    uiwait
load mini
load int
load maxi
format bank
[a0 v0 pt0 Tt0 pt2 Tt2 pt13 Tt13 pt19 Tt19 m19 T19 p19 r19 v19 v19eff pt3 Tt3 pt4 f pt5 Tt5 Tt9 pt9 m9 p9 T9 v9 A9Rm0 veff nspthrf nspthr rfc nth nspthrs np no TSFC nspthrsalpha]=turbofan(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nm,prn,Raf,et,mini,prfn,nf,alpha);
prfv=mini:int:maxi;
for prf=prfv(2):int:maxi
    [a01 v01 pt01 Tt01 pt21 Tt21 pt131 Tt131 pt191 Tt191 m191 T191 p191 r191 v191 v19eff1 pt31 Tt31 pt41 f1 pt51 Tt51 Tt91 pt91 m91 p91 T91 v91 A9Rm01 veff1 nspthrf1 nspthr1 rfc1 nth1 nspthrs1 np1 no1 TSFC1 nspthrsalpha1]=turbofan1(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nm,prn,Raf,et,prf,prfn,nf,alpha);
 a0=[a0 a01];
    v0=[v0 v01];
    pt0=[pt0 pt01];
    Tt0=[Tt0 Tt01];
    pt2=[pt2 pt21];
    Tt2=[Tt2 Tt21];
    pt13=[pt13 pt131];
    Tt13=[Tt13 Tt131]; 
    pt19=[pt19 pt191];
    Tt19=[Tt19 Tt191];
    m19=[m19 m191];
    T19=[T19 T191]; 
    p19=[p19 p191];
    r19=[r19 r191]; 
    v19=[v19 v191];
    v19eff=[v19eff v19eff1];
    pt3=[pt3 pt31];
    Tt3=[Tt3 Tt31];
    pt4=[pt4 pt41];
    f=[f f1];
    pt5=[pt5 pt51];
    Tt5=[Tt5 Tt51];
    Tt9=[Tt9 Tt91];
    pt9=[pt9 pt91];
    m9=[m9 m91];
    p9=[p9 p91];
    T9=[T9 T91];
    v9=[v9 v91];
    A9Rm0=[A9Rm0 A9Rm01];
    veff=[veff veff1];
    nspthrf=[nspthrf nspthrf1]; 
    nspthr=[nspthr nspthr1];
    rfc=[rfc rfc1];
    nth=[nth nth1];
    np=[np np1];
    no=[no no1];
    TSFC=[ TSFC  TSFC1];
    nspthrs=[nspthrs nspthrs1];
    nspthrsalpha=[nspthrsalpha nspthrsalpha1];
    end
save prfv prfv
guidata(hObject,handles)
save TSFC TSFC
guidata(hObject,handles)
save nth nth
guidata(hObject,handles)
save np np
guidata(hObject,handles)
save no no
guidata(hObject,handles)
save nspthrs nspthrs
guidata(hObject,handles)
save nspthrsalpha nspthrsalpha
guidata(hObject,handles)
end

% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close('cnturbofan')


% --- Executes on button press in mn.
function mn_Callback(hObject, eventdata, handles)
% hObject    handle to mn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menu
close('cnturbofan');


% --- Executes on button press in bptsfc.
function bptsfc_Callback(hObject, eventdata, handles)
% hObject    handle to bptsfc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load a
load b
load c
load d
if a==1
load alphav
load TSFC
plot(alphav,TSFC)
xlabel('Bypass Ratio')
ylabel('TSFC (mg/s/N)')
elseif b==1
    load Tt4v
load TSFC
plot(Tt4v,TSFC)
xlabel('Turbine Inlet Total Temperature (K)')
ylabel('TSFC (mg/s/N)')
 elseif c==1
    load prcv
load TSFC
plot(prcv,TSFC)
xlabel('Total Pressure Ratio in the Compressor')
ylabel('TSFC (mg/s/N)')
 elseif d==1
    load prfv
load TSFC
plot(prfv,TSFC)
xlabel('Total Pressure Ratio in the Fan')
ylabel('TSFC (mg/s/N)')
end

% --- Executes on button press in efffbp.
function efffbp_Callback(hObject, eventdata, handles)
% hObject    handle to efffbp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load a
load b
load c
load d
if a==1
load alphav
load nth
load np
load no
plot(alphav,nth,alphav,np,alphav,no)
xlabel('Bypass Ratio')
ylabel('Efficiency')
legend('Thermal','Propulsive','Overal')
elseif b==1
    load Tt4v
load nth
load np
load no
plot(Tt4v,nth,Tt4v,np,Tt4v,no)
xlabel('Turbine Inlet Total Temperature (K)')
ylabel('Efficiency')
legend('Thermal','Propulsive','Overal')
 elseif c==1
    load prcv
load nth
load np
load no
plot(prcv,nth,prcv,np,prcv,no)
xlabel('Total Pressure Ratio in the Compressor')
ylabel('Efficiency')
legend('Thermal','Propulsive','Overal')
 elseif d==1
    load prfv
load nth
load np
load no
plot(prfv,nth,prfv,np,prfv,no)
xlabel('Total Pressure Ratio in the Fan')
ylabel('Efficiency')
legend('Thermal','Propulsive','Overal')
end

% --- Executes on button press in bpsnnsthr.
function bpsnnsthr_Callback(hObject, eventdata, handles)
% hObject    handle to bpsnnsthr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load a
load b
load c
load d
if a==1
load alphav
load nspthrs
load nspthrsalpha
plot(alphav,nspthrs,alphav,nspthrsalpha)
xlabel('Bypass Ratio')
ylabel('Nondimensional specific thrust')
legend('Fn/((1+alpha)m0.a0)','Fn/(m0.a0)')
elseif b==1
    load Tt4v
load nspthrs
load nspthrsalpha
plot(Tt4v,nspthrs,Tt4v,nspthrsalpha)
xlabel('Turbine Inlet Total Temperature (K)')
ylabel('Nondimensional specific thrust')
legend('Fn/((1+alpha)m0.a0)','Fn/(m0.a0)')
elseif c==1
    load prcv
load nspthrs
load nspthrsalpha
plot(prcv,nspthrs,prcv,nspthrsalpha)
xlabel('Total Pressure Ratio in the Compressor')
ylabel('Nondimensional specific thrust')
legend('Fn/((1+alpha)m0.a0)','Fn/(m0.a0)')
elseif d==1
    load prfv
load nspthrs
load nspthrsalpha
plot(prfv,nspthrs,prfv,nspthrsalpha)
xlabel('Total Pressure Ratio in the Fan')
ylabel('Nondimensional specific thrust')
legend('Fn/((1+alpha)m0.a0)','Fn/(m0.a0)')
end
