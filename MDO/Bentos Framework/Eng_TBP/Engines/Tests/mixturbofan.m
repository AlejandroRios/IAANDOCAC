function varargout = mixturbofan(varargin)
% MIXTURBOFAN MATLAB code for mixturbofan.fig
%      MIXTURBOFAN, by itself, creates a new MIXTURBOFAN or raises the existing
%      singleton*.
%
%      H = MIXTURBOFAN returns the handle to a new MIXTURBOFAN or the handle to
%      the existing singleton*.
%
%      MIXTURBOFAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MIXTURBOFAN.M with the given input arguments.
%
%      MIXTURBOFAN('Property','Value',...) creates a new MIXTURBOFAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mixturbofan_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mixturbofan_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mixturbofan

% Last Modified by GUIDE v2.5 10-Jun-2015 00:29:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mixturbofan_OpeningFcn, ...
                   'gui_OutputFcn',  @mixturbofan_OutputFcn, ...
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


% --- Executes just before mixturbofan is made visible.
function mixturbofan_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mixturbofan (see VARARGIN)

% Choose default command line output for mixturbofan
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mixturbofan wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mixturbofan_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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

function gafb_Callback(hObject, eventdata, handles)
% hObject    handle to gafb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gafb as text
%        str2double(get(hObject,'String')) returns contents of gafb as a double


% --- Executes during object creation, after setting all properties.
function gafb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gafb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cpafb_Callback(hObject, eventdata, handles)
% hObject    handle to cpafb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cpafb as text
%        str2double(get(hObject,'String')) returns contents of cpafb as a double


% --- Executes during object creation, after setting all properties.
function cpafb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cpafb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function prafb_Callback(hObject, eventdata, handles)
% hObject    handle to prafb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prafb as text
%        str2double(get(hObject,'String')) returns contents of prafb as a double


% --- Executes during object creation, after setting all properties.
function prafb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prafb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Tt7_Callback(hObject, eventdata, handles)
% hObject    handle to Tt7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tt7 as text
%        str2double(get(hObject,'String')) returns contents of Tt7 as a double


% --- Executes during object creation, after setting all properties.
function Tt7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tt7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function nafb_Callback(hObject, eventdata, handles)
% hObject    handle to nafb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nafb as text
%        str2double(get(hObject,'String')) returns contents of nafb as a double


% --- Executes during object creation, after setting all properties.
function nafb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nafb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function LHVafb_Callback(hObject, eventdata, handles)
% hObject    handle to LHVafb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of LHVafb as text
%        str2double(get(hObject,'String')) returns contents of LHVafb as a double


% --- Executes during object creation, after setting all properties.
function LHVafb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LHVafb (see GCBO)
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



function prfd_Callback(hObject, eventdata, handles)
% hObject    handle to prfd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prfd as text
%        str2double(get(hObject,'String')) returns contents of prfd as a double


% --- Executes during object creation, after setting all properties.
function prfd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prfd (see GCBO)
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



function m5_Callback(hObject, eventdata, handles)
% hObject    handle to m5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of m5 as text
%        str2double(get(hObject,'String')) returns contents of m5 as a double


% --- Executes during object creation, after setting all properties.
function m5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to m5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function prmxf_Callback(hObject, eventdata, handles)
% hObject    handle to prmxf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prmxf as text
%        str2double(get(hObject,'String')) returns contents of prmxf as a double


% --- Executes during object creation, after setting all properties.
function prmxf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prmxf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function prc2_Callback(hObject, eventdata, handles)
% hObject    handle to prc2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prc2 as text
%        str2double(get(hObject,'String')) returns contents of prc2 as a double


% --- Executes during object creation, after setting all properties.
function prc2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prc2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function prc3_Callback(hObject, eventdata, handles)
% hObject    handle to prc3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of prc3 as text
%        str2double(get(hObject,'String')) returns contents of prc3 as a double


% --- Executes during object creation, after setting all properties.
function prc3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prc3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function expr_Callback(hObject, eventdata, handles)
% hObject    handle to expr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of expr as text
%        str2double(get(hObject,'String')) returns contents of expr as a double


% --- Executes during object creation, after setting all properties.
function expr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to expr (see GCBO)
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
% --- Executes on button press in cal.
function cal_Callback(hObject, eventdata, handles)
% hObject    handle to cal (see GCBO)
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
nbs=get(handles.nb,'string');
nb=str2num(nbs);
prbs=get(handles.prb,'string');
prb=str2num(prbs);
nts=get(handles.et,'string');
nt=str2num(nts);
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
ets=get(handles.et,'string');
et=str2num(ets);
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
gafbs=get(handles.gafb,'string');
gafb=str2num(gafbs);
cpafbs=get(handles.cpafb,'string');
cpafb=str2num(cpafbs);
prafbs=get(handles.prafb,'string');
prafb=str2num(prafbs);
Tt7s=get(handles.Tt7,'string');
Tt7=str2num(Tt7s);
nafbs=get(handles.nafb,'string');
nafb=str2num(nafbs);
LHVafbs=get(handles.LHVafb,'string');
LHVafbk=str2num(LHVafbs);
LHVafb=(LHVafbk*1000);
prfs=get(handles.prf,'string');
prf=str2num(prfs);
nfs=get(handles.nf,'string');
nf=str2num(nfs);
prfds=get(handles.prfd,'string');
prfd=str2num(prfds);
nms=get(handles.nm,'string');
nm=str2num(nms);
m5s=get(handles.m5,'string');
m5=str2num(m5s);
prmxfs=get(handles.prmxf,'string');
prmxf=str2num(prmxfs);
exprs=get(handles.expr,'string');
expr=str2num(exprs);
R=((cp*(g-1))/g);
Raf=((cpaf*(gaf-1))/gaf);
Rafb=((cpafb*(gafb-1))/gafb);
if a==1
    vetormx
    uiwait
load mini
load int
load maxi
format bank

[a0 v0 pt0 Tt0 pt2 Tt2 pt13 Tt13 pt15 Tt15 m15 T15 p15 pt3 Tt3 pt4 f pt5 Tt5 Tt9 pt9 m9 p9 T9 v9 A9Rm0 v9eff nspthr  nth np no TSFC fo alphat]=mxturbofan(T0,m0,p0,prd,prf,nf,prfd,mini,nc,Tt4,LHV,prb,nb,et,nm,m5,prmxf,Tt7,LHVafb,prafb,nafb,prn,g,cp,gaf,cpaf,gafb,cpafb,R,Raf,Rafb,expr);

prcv=mini:int:maxi;
for prc=prcv(2):int:maxi
    
[v01 pt01 Tt01]=inlet(R,g,T0,m0,p0,cp);
a0=v01/m0;
[pt21 Tt21]=diffuser(prd,pt01,Tt01);
[pt131 Tt131]=fan(pt21,prf,g,nf,Tt21);
tauf1=Tt131/Tt21;
Tt151=Tt131;
pt151=pt131*prfd;
[pt31 Tt31]=compressor(prc,pt21,g,nc,Tt21);
[pt41 f1]=burner(prb,pt31,Tt31,cpaf,Tt4,cp,LHV,nb);
prt1=((prfd*prf)/(prb*prc));
taut1=prt1^(((gaf-1)/gaf)*et);
Tt51=Tt4*taut1;
pt51=pt41*prt1;
T51=Tt51/(1+(((gaf-1)*(m5^2))/2));
a51=(((gaf*Raf*T51)^0.5));
alpha1=((nm*(1+f1)*(cpaf/cp)*(Tt4-Tt51))-(Tt31-Tt21))/(Tt131-Tt21);
alphat1=((nm*(1+f1)*(cpaf/cp)*(Tt4-Tt51))-(Tt31-Tt21))/(Tt131-Tt21);
ht6m1=((((1+f1)*taut1*cpaf*Tt4)+(alpha1*tauf1*cp*Tt01))/(1+alpha1+f1));
cp6m1=((((1+f1)*cpaf)+(alpha1*cp))/(1+alpha1+f1));
g6m1=(((1+f1)*cpaf)+(alpha1*cp))/(((1+f1)*(cpaf/gaf))+(alpha1*(cp/g)));
m151=((((((1+((gaf-1)*0.5*(m5^2)))^(gaf/(gaf-1)))^((g-1)/g))-1)*(2/(g-1)))^0.5);
T151=Tt151/(1+(((g-1)*(m151^2))/2));
p151=pt151/((Tt151/T151)^(g/(g-1)));
a151=(((g*R*T151)^0.5));
p51=pt51/((Tt51/T51)^(gaf/(gaf-1)));
A15RA51=((alpha1/(1+f1))*(gaf/g)*(a151/a51)*(m5/m151));
c11=(((1+(gaf*(m5^2)))+(A15RA51*(1+(g*(m151^2)))))/(1+A15RA51));
c21=((((gaf/g6m1)*(m5/a51))+((g/g6m1)*((m151*(A15RA51))/a151)))*((((g6m1-1)*ht6m1)^0.5)/(1+A15RA51)));
c1=((c11/c21)^2);
m6m1=(((c1-(2*g6m1)- (((c1-(2*g6m1))^2)-(4*((g6m1^2)-(c1*(g6m1-1)*0.5))))^0.5 )/(2*(g6m1^2)-(c1*(g6m1-1))))^0.5);
p6m1=p51*(c11/(1+g6m1*(m6m1^2)));
pt6mi1=((((1+(((g6m1-1)*(m6m1^2))/2))^(g6m1/(g6m1-1)))*p6m1));
prmi1=pt6mi1/pt51;
prm1=prmi1*prmxf;
pt6m1=pt6mi1*prmxf;
pt71=(pt6m1*prafb);
fafb1=(((cp6m1*Tt7-ht6m1))/(((nafb*LHVafb))-Tt7*cp6m1));
pt91=pt71*prn;
p91=expr*p0;
Tt91=Tt7;
m91=(((((pt91/p91)^((gafb-1)/(gafb)))-1)*(2/(gafb-1)))^0.5);
T91=(Tt91/(1+(0.5*(gafb-1)*((m91)^2))));
v91=((2*cpafb*(Tt91-T91))^0.5);
A9Rm01=((1+fafb1+f1)*((Rafb*T91)/(p91*v91)));
v9eff1=(v91+(A9Rm01*((p91-p0)/(1+f1+fafb1))));
nspthr1=((((1+alpha1+f1+(fafb1*(1+alpha1+f1)))/(1+alpha1))*(v9eff1/a0))-m0);
TSFC1=( ((f1+(fafb1*(1+alpha1+f1)))/((1+alpha1)*a0)) *10^6)/nspthr1;
nth1=((((1+alpha1+f1+(fafb1*(1+alpha1+f1)))*((v9eff1)^2))-((1+alpha1)*(v0^2)))/(2*((f1*LHV)+((fafb1*(1+alpha1+f1))*LHVafb))));
np1=(2*nspthr1*v0)/(((1+alpha1+f1+(fafb1*(1+alpha1+f1)))/((1+alpha1)*a0)*(v9eff1^2))-((v0^2)/a0));
no1=np1*nth1;
fo1=f1+fafb1;


TSFC=[TSFC TSFC1];
nspthr=[nspthr nspthr1];
np=[np np1];
nth=[nth nth1];
no=[no no1];
alphat=[alphat alphat1];
fo=[fo fo1];

end
save TSFC TSFC
save nspthr nspthr
save np np
save nth nth
save no no
save alphat alphat
save fo fo
save prcv prcv
elseif b==1
    vetormx
    uiwait
load mini
load int
load maxi
format bank

[a0 v0 pt0 Tt0 pt2 Tt2 pt13 Tt13 pt15 Tt15 m15 T15 p15 pt3 Tt3 pt4 f pt5 Tt5 Tt9 pt9 m9 p9 T9 v9 A9Rm0 v9eff nspthr  nth np no TSFC fo alphat]=mxturbofan(T0,m0,p0,prd,mini,nf,prfd,prc,nc,Tt4,LHV,prb,nb,et,nm,m5,prmxf,Tt7,LHVafb,prafb,nafb,prn,g,cp,gaf,cpaf,gafb,cpafb,R,Raf,Rafb,expr);

prfv=mini:int:maxi;
for prf=prfv(2):int:maxi
    
[v01 pt01 Tt01]=inlet(R,g,T0,m0,p0,cp);
a0=v01/m0;
[pt21 Tt21]=diffuser(prd,pt01,Tt01);
[pt131 Tt131]=fan(pt21,prf,g,nf,Tt21);
tauf1=Tt131/Tt21;
Tt151=Tt131;
pt151=pt131*prfd;
[pt31 Tt31]=compressor(prc,pt21,g,nc,Tt21);
[pt41 f1]=burner(prb,pt31,Tt31,cpaf,Tt4,cp,LHV,nb);
prt1=((prfd*prf)/(prb*prc));
taut1=prt1^(((gaf-1)/gaf)*et);
Tt51=Tt4*taut1;
pt51=pt41*prt1;
T51=Tt51/(1+(((gaf-1)*(m5^2))/2));
a51=(((gaf*Raf*T51)^0.5));
alpha1=((nm*(1+f1)*(cpaf/cp)*(Tt4-Tt51))-(Tt31-Tt21))/(Tt131-Tt21);
alphat1=((nm*(1+f1)*(cpaf/cp)*(Tt4-Tt51))-(Tt31-Tt21))/(Tt131-Tt21);
ht6m1=((((1+f1)*taut1*cpaf*Tt4)+(alpha1*tauf1*cp*Tt01))/(1+alpha1+f1));
cp6m1=((((1+f1)*cpaf)+(alpha1*cp))/(1+alpha1+f1));
g6m1=(((1+f1)*cpaf)+(alpha1*cp))/(((1+f1)*(cpaf/gaf))+(alpha1*(cp/g)));
m151=((((((1+((gaf-1)*0.5*(m5^2)))^(gaf/(gaf-1)))^((g-1)/g))-1)*(2/(g-1)))^0.5);
T151=Tt151/(1+(((g-1)*(m151^2))/2));
p151=pt151/((Tt151/T151)^(g/(g-1)));
a151=(((g*R*T151)^0.5));
p51=pt51/((Tt51/T51)^(gaf/(gaf-1)));
A15RA51=((alpha1/(1+f1))*(gaf/g)*(a151/a51)*(m5/m151));
c11=(((1+(gaf*(m5^2)))+(A15RA51*(1+(g*(m151^2)))))/(1+A15RA51));
c21=((((gaf/g6m1)*(m5/a51))+((g/g6m1)*((m151*(A15RA51))/a151)))*((((g6m1-1)*ht6m1)^0.5)/(1+A15RA51)));
c1=((c11/c21)^2);
m6m1=(((c1-(2*g6m1)- (((c1-(2*g6m1))^2)-(4*((g6m1^2)-(c1*(g6m1-1)*0.5))))^0.5 )/(2*(g6m1^2)-(c1*(g6m1-1))))^0.5);
p6m1=p51*(c11/(1+g6m1*(m6m1^2)));
pt6mi1=((((1+(((g6m1-1)*(m6m1^2))/2))^(g6m1/(g6m1-1)))*p6m1));
prmi1=pt6mi1/pt51;
prm1=prmi1*prmxf;
pt6m1=pt6mi1*prmxf;
pt71=(pt6m1*prafb);
fafb1=(((cp6m1*Tt7-ht6m1))/(((nafb*LHVafb))-Tt7*cp6m1));
pt91=pt71*prn;
p91=expr*p0;
Tt91=Tt7;
m91=(((((pt91/p91)^((gafb-1)/(gafb)))-1)*(2/(gafb-1)))^0.5);
T91=(Tt91/(1+(0.5*(gafb-1)*((m91)^2))));
v91=((2*cpafb*(Tt91-T91))^0.5);
A9Rm01=((1+fafb1+f1)*((Rafb*T91)/(p91*v91)));
v9eff1=(v91+(A9Rm01*((p91-p0)/(1+f1+fafb1))));
nspthr1=((((1+alpha1+f1+(fafb1*(1+alpha1+f1)))/(1+alpha1))*(v9eff1/a0))-m0);
TSFC1=( ((f1+(fafb1*(1+alpha1+f1)))/((1+alpha1)*a0)) *10^6)/nspthr1;
nth1=((((1+alpha1+f1+(fafb1*(1+alpha1+f1)))*((v9eff1)^2))-((1+alpha1)*(v0^2)))/(2*((f1*LHV)+((fafb1*(1+alpha1+f1))*LHVafb))));
np1=(2*nspthr1*v0)/(((1+alpha1+f1+(fafb1*(1+alpha1+f1)))/((1+alpha1)*a0)*(v9eff1^2))-((v0^2)/a0));
no1=np1*nth1;
fo1=f1+fafb1;


TSFC=[TSFC TSFC1];
nspthr=[nspthr nspthr1];
np=[np np1];
nth=[nth nth1];
no=[no no1];
alphat=[alphat alphat1];
fo=[fo fo1];

end
save TSFC TSFC
save nspthr nspthr
save np np
save nth nth
save no no
save alphat alphat
save fo fo
save prfv prfv
elseif c==1
    vetormx
    uiwait
load mini
load int
load maxi
format bank

[a0 v0 pt0 Tt0 pt2 Tt2 pt13 Tt13 pt15 Tt15 m15 T15 p15 pt3 Tt3 pt4 f pt5 Tt5 Tt9 pt9 m9 p9 T9 v9 A9Rm0 v9eff nspthr  nth np no TSFC fo alphat]=mxturbofan(T0,m0,p0,prd,prf,nf,prfd,prc,nc,mini,LHV,prb,nb,et,nm,m5,prmxf,Tt7,LHVafb,prafb,nafb,prn,g,cp,gaf,cpaf,gafb,cpafb,R,Raf,Rafb,expr);

Tt4v=mini:int:maxi;
for Tt4=Tt4v(2):int:maxi
    
[v01 pt01 Tt01]=inlet(R,g,T0,m0,p0,cp);
a0=v01/m0;
[pt21 Tt21]=diffuser(prd,pt01,Tt01);
[pt131 Tt131]=fan(pt21,prf,g,nf,Tt21);
tauf1=Tt131/Tt21;
Tt151=Tt131;
pt151=pt131*prfd;
[pt31 Tt31]=compressor(prc,pt21,g,nc,Tt21);
[pt41 f1]=burner(prb,pt31,Tt31,cpaf,Tt4,cp,LHV,nb);
prt1=((prfd*prf)/(prb*prc));
taut1=prt1^(((gaf-1)/gaf)*et);
Tt51=Tt4*taut1;
pt51=pt41*prt1;
T51=Tt51/(1+(((gaf-1)*(m5^2))/2));
a51=(((gaf*Raf*T51)^0.5));
alpha1=((nm*(1+f1)*(cpaf/cp)*(Tt4-Tt51))-(Tt31-Tt21))/(Tt131-Tt21);
alphat1=((nm*(1+f1)*(cpaf/cp)*(Tt4-Tt51))-(Tt31-Tt21))/(Tt131-Tt21);
ht6m1=((((1+f1)*taut1*cpaf*Tt4)+(alpha1*tauf1*cp*Tt01))/(1+alpha1+f1));
cp6m1=((((1+f1)*cpaf)+(alpha1*cp))/(1+alpha1+f1));
g6m1=(((1+f1)*cpaf)+(alpha1*cp))/(((1+f1)*(cpaf/gaf))+(alpha1*(cp/g)));
m151=((((((1+((gaf-1)*0.5*(m5^2)))^(gaf/(gaf-1)))^((g-1)/g))-1)*(2/(g-1)))^0.5);
T151=Tt151/(1+(((g-1)*(m151^2))/2));
p151=pt151/((Tt151/T151)^(g/(g-1)));
a151=(((g*R*T151)^0.5));
p51=pt51/((Tt51/T51)^(gaf/(gaf-1)));
A15RA51=((alpha1/(1+f1))*(gaf/g)*(a151/a51)*(m5/m151));
c11=(((1+(gaf*(m5^2)))+(A15RA51*(1+(g*(m151^2)))))/(1+A15RA51));
c21=((((gaf/g6m1)*(m5/a51))+((g/g6m1)*((m151*(A15RA51))/a151)))*((((g6m1-1)*ht6m1)^0.5)/(1+A15RA51)));
c1=((c11/c21)^2);
m6m1=(((c1-(2*g6m1)- (((c1-(2*g6m1))^2)-(4*((g6m1^2)-(c1*(g6m1-1)*0.5))))^0.5 )/(2*(g6m1^2)-(c1*(g6m1-1))))^0.5);
p6m1=p51*(c11/(1+g6m1*(m6m1^2)));
pt6mi1=((((1+(((g6m1-1)*(m6m1^2))/2))^(g6m1/(g6m1-1)))*p6m1));
prmi1=pt6mi1/pt51;
prm1=prmi1*prmxf;
pt6m1=pt6mi1*prmxf;
pt71=(pt6m1*prafb);
fafb1=(((cp6m1*Tt7-ht6m1))/(((nafb*LHVafb))-Tt7*cp6m1));
pt91=pt71*prn;
p91=expr*p0;
Tt91=Tt7;
m91=(((((pt91/p91)^((gafb-1)/(gafb)))-1)*(2/(gafb-1)))^0.5);
T91=(Tt91/(1+(0.5*(gafb-1)*((m91)^2))));
v91=((2*cpafb*(Tt91-T91))^0.5);
A9Rm01=((1+fafb1+f1)*((Rafb*T91)/(p91*v91)));
v9eff1=(v91+(A9Rm01*((p91-p0)/(1+f1+fafb1))));
nspthr1=((((1+alpha1+f1+(fafb1*(1+alpha1+f1)))/(1+alpha1))*(v9eff1/a0))-m0);
TSFC1=( ((f1+(fafb1*(1+alpha1+f1)))/((1+alpha1)*a0)) *10^6)/nspthr1;
nth1=((((1+alpha1+f1+(fafb1*(1+alpha1+f1)))*((v9eff1)^2))-((1+alpha1)*(v0^2)))/(2*((f1*LHV)+((fafb1*(1+alpha1+f1))*LHVafb))));
np1=(2*nspthr1*v0)/(((1+alpha1+f1+(fafb1*(1+alpha1+f1)))/((1+alpha1)*a0)*(v9eff1^2))-((v0^2)/a0));
no1=np1*nth1;
fo1=f1+fafb1;


TSFC=[TSFC TSFC1];
nspthr=[nspthr nspthr1];
np=[np np1];
nth=[nth nth1];
no=[no no1];
alphat=[alphat alphat1];
fo=[fo fo1];

end
save TSFC TSFC
save nspthr nspthr
save np np
save nth nth
save no no
save alphat alphat
save fo fo
save Tt4v Tt4v
elseif d==1
vetormx
    uiwait
load mini
load int
load maxi
format bank

[a0 v0 pt0 Tt0 pt2 Tt2 pt13 Tt13 pt15 Tt15 m15 T15 p15 pt3 Tt3 pt4 f pt5 Tt5 Tt9 pt9 m9 p9 T9 v9 A9Rm0 v9eff nspthr  nth np no TSFC fo alphat]=mxturbofan(T0,m0,p0,prd,prf,nf,prfd,prc,nc,Tt4,LHV,prb,nb,et,nm,m5,prmxf,mini,LHVafb,prafb,nafb,prn,g,cp,gaf,cpaf,gafb,cpafb,R,Raf,Rafb,expr);

Tt7v=mini:int:maxi;
for Tt4=Tt7v(2):int:maxi
    
[v01 pt01 Tt01]=inlet(R,g,T0,m0,p0,cp);
a0=v01/m0;
[pt21 Tt21]=diffuser(prd,pt01,Tt01);
[pt131 Tt131]=fan(pt21,prf,g,nf,Tt21);
tauf1=Tt131/Tt21;
Tt151=Tt131;
pt151=pt131*prfd;
[pt31 Tt31]=compressor(prc,pt21,g,nc,Tt21);
[pt41 f1]=burner(prb,pt31,Tt31,cpaf,Tt4,cp,LHV,nb);
prt1=((prfd*prf)/(prb*prc));
taut1=prt1^(((gaf-1)/gaf)*et);
Tt51=Tt4*taut1;
pt51=pt41*prt1;
T51=Tt51/(1+(((gaf-1)*(m5^2))/2));
a51=(((gaf*Raf*T51)^0.5));
alpha1=((nm*(1+f1)*(cpaf/cp)*(Tt4-Tt51))-(Tt31-Tt21))/(Tt131-Tt21);
alphat1=((nm*(1+f1)*(cpaf/cp)*(Tt4-Tt51))-(Tt31-Tt21))/(Tt131-Tt21);
ht6m1=((((1+f1)*taut1*cpaf*Tt4)+(alpha1*tauf1*cp*Tt01))/(1+alpha1+f1));
cp6m1=((((1+f1)*cpaf)+(alpha1*cp))/(1+alpha1+f1));
g6m1=(((1+f1)*cpaf)+(alpha1*cp))/(((1+f1)*(cpaf/gaf))+(alpha1*(cp/g)));
m151=((((((1+((gaf-1)*0.5*(m5^2)))^(gaf/(gaf-1)))^((g-1)/g))-1)*(2/(g-1)))^0.5);
T151=Tt151/(1+(((g-1)*(m151^2))/2));
p151=pt151/((Tt151/T151)^(g/(g-1)));
a151=(((g*R*T151)^0.5));
p51=pt51/((Tt51/T51)^(gaf/(gaf-1)));
A15RA51=((alpha1/(1+f1))*(gaf/g)*(a151/a51)*(m5/m151));
c11=(((1+(gaf*(m5^2)))+(A15RA51*(1+(g*(m151^2)))))/(1+A15RA51));
c21=((((gaf/g6m1)*(m5/a51))+((g/g6m1)*((m151*(A15RA51))/a151)))*((((g6m1-1)*ht6m1)^0.5)/(1+A15RA51)));
c1=((c11/c21)^2);
m6m1=(((c1-(2*g6m1)- (((c1-(2*g6m1))^2)-(4*((g6m1^2)-(c1*(g6m1-1)*0.5))))^0.5 )/(2*(g6m1^2)-(c1*(g6m1-1))))^0.5);
p6m1=p51*(c11/(1+g6m1*(m6m1^2)));
pt6mi1=((((1+(((g6m1-1)*(m6m1^2))/2))^(g6m1/(g6m1-1)))*p6m1));
prmi1=pt6mi1/pt51;
prm1=prmi1*prmxf;
pt6m1=pt6mi1*prmxf;
pt71=(pt6m1*prafb);
fafb1=(((cp6m1*Tt7-ht6m1))/(((nafb*LHVafb))-Tt7*cp6m1));
pt91=pt71*prn;
p91=expr*p0;
Tt91=Tt7;
m91=(((((pt91/p91)^((gafb-1)/(gafb)))-1)*(2/(gafb-1)))^0.5);
T91=(Tt91/(1+(0.5*(gafb-1)*((m91)^2))));
v91=((2*cpafb*(Tt91-T91))^0.5);
A9Rm01=((1+fafb1+f1)*((Rafb*T91)/(p91*v91)));
v9eff1=(v91+(A9Rm01*((p91-p0)/(1+f1+fafb1))));
nspthr1=((((1+alpha1+f1+(fafb1*(1+alpha1+f1)))/(1+alpha1))*(v9eff1/a0))-m0);
TSFC1=( ((f1+(fafb1*(1+alpha1+f1)))/((1+alpha1)*a0)) *10^6)/nspthr1;
nth1=((((1+alpha1+f1+(fafb1*(1+alpha1+f1)))*((v9eff1)^2))-((1+alpha1)*(v0^2)))/(2*((f1*LHV)+((fafb1*(1+alpha1+f1))*LHVafb))));
np1=(2*nspthr1*v0)/(((1+alpha1+f1+(fafb1*(1+alpha1+f1)))/((1+alpha1)*a0)*(v9eff1^2))-((v0^2)/a0));
no1=np1*nth1;
fo1=f1+fafb1;


TSFC=[TSFC TSFC1];
nspthr=[nspthr nspthr1];
np=[np np1];
nth=[nth nth1];
no=[no no1];
alphat=[alphat alphat1];
fo=[fo fo1];

end
save TSFC TSFC
save nspthr nspthr
save np np
save nth nth
save no no
save alphat alphat
save fo fo
save Tt7v Tt7v    
end



%

% --- Executes on button press in mn.
function mn_Callback(hObject, eventdata, handles)
% hObject    handle to mn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menu
close('mixturbofan');


% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close('mixturbofan');


% --- Executes on button press in tsfc.
function tsfc_Callback(hObject, eventdata, handles)
% hObject    handle to tsfc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load a
load b
load c
load d
if a==1
load prcv
load TSFC
plot(prcv,TSFC)
xlabel('Compressor Total Pressure Ratio')
 ylabel('TSFC (mg/s/N)')
elseif b==1
 load prfv
load TSFC
plot(prfv,TSFC)
xlabel('Fan Total Pressure Ratio')
 ylabel('TSFC (mg/s/N)') 
elseif c==1
load Tt4v
load TSFC
plot(Tt4v,TSFC)
xlabel('Turbine Inlet Total Temperature (K)')
 ylabel('TSFC (mg/s/N)')  
elseif d==1
load Tt7v
load TSFC
plot(Tt7v,TSFC)
xlabel('After buner exit total temperature (K)')
 ylabel('TSFC (mg/s/N)')
end

% --- Executes on button press in nspthr.
function nspthr_Callback(hObject, eventdata, handles)
% hObject    handle to nspthr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load a
load b
load c
load d
if a==1
load prcv
load nspthr
plot(prcv,nspthr)
xlabel('Compressor Total Pressure Ratio')
ylabel('Nondimensional specific thrust')
elseif b==1
    load prfv
load nspthr
plot(prfv,nspthr)
xlabel('Fan Total Pressure Ratio')
ylabel('Nondimensional specific thrust')
elseif c==1
load Tt4v
load nspthr
plot(Tt4v,nspthr)
xlabel('Turbine Inlet Total Temperature (K)')
ylabel('Nondimensional specific thrust')    
elseif d==1
load Tt7v
load nspthr
plot(Tt7v,nspthr)
xlabel('After buner exit total temperature (K)')
ylabel('Nondimensional specific thrust') 
end
    

% --- Executes on button press in efficiency.
function efficiency_Callback(hObject, eventdata, handles)
% hObject    handle to efficiency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load a
load b
load c
load d
if a==1
load prcv
load nth
load np
load no
plot(prcv,nth,prcv,np,prcv,no)
xlabel('Compressor Total Pressure Ratio')
ylabel('Efficiency')
 legend('Thermal','Propulsive','Overal')
elseif b==1
 load prfv
load nth
load np
load no
plot(prfv,nth,prfv,np,prfv,no)
xlabel('Fan Total Pressure Ratio')
ylabel('Efficiency')
 legend('Thermal','Propulsive','Overal')
elseif c==1
 load Tt4v
load nth
load np
load no
plot(Tt4v,nth,Tt4v,np,Tt4v,no)
xlabel('Turbine Inlet Total Temperature (K)')
ylabel('Efficiency')
 legend('Thermal','Propulsive','Overal')  
elseif d==1
load Tt7v
load nth
load np
load no
plot(Tt7v,nth,Tt7v,np,Tt7v,no)
xlabel('After buner exit total temperature (K)')
ylabel('Efficiency')
 legend('Thermal','Propulsive','Overal')   
end

% --- Executes on button press in bypass.
function bypass_Callback(hObject, eventdata, handles)
% hObject    handle to bypass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load a
load b
load c
load d
if a==1
load prcv
load alphat
plot(prcv,alphat)
xlabel('Compressor Total Pressure Ratio')
ylabel('Bypass Ratio')
elseif b==1
 load prfv
load alphat
plot(prfv,alphat)
xlabel('Fan Total Pressure Ratio')
ylabel('Bypass Ratio')
elseif c==1
load Tt4v
load alphat
plot(Tt4v,alphat)
xlabel('Turbine Inlet Total Temperature (K)')
ylabel('Bypass Ratio')  
elseif d==1
load Tt7v
load alphat
plot(Tt7v,alphat)
xlabel('After buner exit total temperature (K)')
ylabel('Bypass Ratio')  
end

% --- Executes on button press in fo.
function fo_Callback(hObject, eventdata, handles)
% hObject    handle to fo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load a
load b
load c
load d
if a==1
load prcv
load fo
plot(prcv,fo)
xlabel('Compressor Total Pressure Ratio')
ylabel('Overal Fuel to Air Ratio')
elseif b==1
    load prfv
load fo
plot(prfv,fo)
xlabel('Fan Total Pressure Ratio')
ylabel('Overal Fuel to Air Ratio')
elseif c==1
load Tt4v
load fo
plot(Tt4v,fo)
xlabel('Turbine Inlet Total Temperature (K)')
ylabel('Overal Fuel to Air Ratio')
elseif d==1
load Tt7v
load fo
plot(Tt7v,fo)
xlabel('After buner exit total temperature (K)')
ylabel('Overal Fuel to Air Ratio')
end
