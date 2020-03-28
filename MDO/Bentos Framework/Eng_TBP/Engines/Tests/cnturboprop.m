function varargout = cnturboprop(varargin)
% CNTURBOPROP MATLAB code for cnturboprop.fig
%      CNTURBOPROP, by itself, creates a new CNTURBOPROP or raises the existing
%      singleton*.
%
%      H = CNTURBOPROP returns the handle to a new CNTURBOPROP or the handle to
%      the existing singleton*.
%
%      CNTURBOPROP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CNTURBOPROP.M with the given input arguments.
%
%      CNTURBOPROP('Property','Value',...) creates a new CNTURBOPROP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cnturboprop_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cnturboprop_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cnturboprop

% Last Modified by GUIDE v2.5 08-Jun-2015 00:03:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cnturboprop_OpeningFcn, ...
                   'gui_OutputFcn',  @cnturboprop_OutputFcn, ...
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


% --- Executes just before cnturboprop is made visible.
function cnturboprop_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cnturboprop (see VARARGIN)

% Choose default command line output for cnturboprop
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cnturboprop wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cnturboprop_OutputFcn(hObject, eventdata, handles) 
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



function nmhpt_Callback(hObject, eventdata, handles)
% hObject    handle to nmhpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nmhpt as text
%        str2double(get(hObject,'String')) returns contents of nmhpt as a double


% --- Executes during object creation, after setting all properties.
function nmhpt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nmhpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nnzl_Callback(hObject, eventdata, handles)
% hObject    handle to nnzl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nnzl as text
%        str2double(get(hObject,'String')) returns contents of nnzl as a double


% --- Executes during object creation, after setting all properties.
function nnzl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nnzl (see GCBO)
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
function ehpt_Callback(hObject, eventdata, handles)
% hObject    handle to ehpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ehpt as text
%        str2double(get(hObject,'String')) returns contents of ehpt as a double


% --- Executes during object creation, after setting all properties.
function ehpt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ehpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function nprop_Callback(hObject, eventdata, handles)
% hObject    handle to nprop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nprop as text
%        str2double(get(hObject,'String')) returns contents of nprop as a double


% --- Executes during object creation, after setting all properties.
function nprop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nprop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function elpt_Callback(hObject, eventdata, handles)
% hObject    handle to elpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of elpt as text
%        str2double(get(hObject,'String')) returns contents of elpt as a double


% --- Executes during object creation, after setting all properties.
function elpt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nmlpt_Callback(hObject, eventdata, handles)
% hObject    handle to nmlpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nmlpt as text
%        str2double(get(hObject,'String')) returns contents of nmlpt as a double


% --- Executes during object creation, after setting all properties.
function nmlpt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nmlpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ngb_Callback(hObject, eventdata, handles)
% hObject    handle to ngb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ngb as text
%        str2double(get(hObject,'String')) returns contents of ngb as a double


% --- Executes during object creation, after setting all properties.
function ngb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ngb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function nlpt_Callback(hObject, eventdata, handles)
% hObject    handle to nlpt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nlpt as text
%        str2double(get(hObject,'String')) returns contents of nlpt as a double


% --- Executes during object creation, after setting all properties.
function nlpt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nlpt (see GCBO)
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
save a a
save b b
save c c


function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load a
load b
load c
format bank
prds=get(handles.prd,'string');
prd=str2num(prds);
ncs=get(handles.nc,'string');
nc=str2num(ncs);
ehpts=get(handles.ehpt,'string');
ehpt=str2num(ehpts);
nbs=get(handles.nb,'string');
nb=str2num(nbs);
prbs=get(handles.prb,'string');
prb=str2num(prbs);
nmhpts=get(handles.nmhpt,'string');
nmhpt=str2num(nmhpts);
nnzls=get(handles.nnzl,'string');
nnzl=str2num(nnzls);
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
nts=get(handles.nmhpt,'string');
nt=str2num(nts);
prns=get(handles.nnzl,'string');
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
alphas=get(handles.alpha,'string');
alpha=str2num(alphas);
nmlpts=get(handles.nmlpt,'string');
nmlpt=str2num(nmlpts);
ngbs=get(handles.ngb,'string');
ngb=str2num(ngbs);
nlpts=get(handles.nlpt,'string');
nlpt=str2num(nlpts);
nprops=get(handles.nprop,'string');
nprop=str2num(nprops);
R=((cp*(g-1))/g);
Raf=((cpaf*(gaf-1))/gaf);
if a==1
      vetorprop
    uiwait
load mini
load int
load maxi
format bank
 [v0 pt0 Tt0 pt2 Tt2 pt3 Tt3 pt4 f pt45 Tt45 pt5 Tt5 Tt9 pt9 m9 p9 T9 v9  spthrttl TSFC nth np no spthrpropRspthrttl]=turboprop(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nmhpt,nlpt,nmlpt,ehpt,ngb,nprop,nnzl,Raf,mini);
alphav=mini:int:maxi;
for alpha=alphav(2):int:maxi
     [v01 pt01 Tt01 pt21 Tt21 pt31 Tt31 pt41 f1 pt451 Tt451 pt51 Tt51 Tt91 pt91 m91 p91 T91 v91  spthrttl1 TSFC1 nth1 np1 no1 spthrpropRspthrttl1]=turboprop1(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nmhpt,nlpt,nmlpt,ehpt,ngb,nprop,nnzl,Raf,alpha);
    v0=[v0 v01];
    pt0=[pt0 pt01];
    Tt0=[Tt0 Tt01];
    pt2=[pt2 pt21];
    Tt2=[Tt2 Tt21];
    pt3=[pt3 pt31];
    Tt3=[Tt3 Tt31];
    pt4=[pt4 pt41];
    f=[f f1];
    pt45=[pt45 pt451];
    Tt45=[Tt45 Tt451];
    pt5=[pt5 pt51];
    Tt5=[Tt5 Tt51];
    Tt9=[Tt9 Tt91];
    pt9=[pt9 pt91];
    m9=[m9 m91];
    p9=[p9 p91];
    T9=[T9 T91];
    v9=[v9 v91];
    spthrttl=[spthrttl spthrttl1];
    TSFC=[ TSFC  TSFC1];
    nth=[nth nth1];
    np=[np np1];
    no=[no no1];
    spthrpropRspthrttl=[spthrpropRspthrttl spthrpropRspthrttl1];
end
save alphav alphav
save spthrttl spthrttl
save TSFC TSFC
save nth nth
save np np
save no no
save spthrpropRspthrttl spthrpropRspthrttl
elseif b==1
 vetorprop
    uiwait
load mini
load int
load maxi
format bank
 [v0 pt0 Tt0 pt2 Tt2 pt3 Tt3 pt4 f pt45 Tt45 pt5 Tt5 Tt9 pt9 m9 p9 T9 v9  spthrttl TSFC nth np no spthrpropRspthrttl]=turboprop(R,g,T0,m0,p0,cp,prd,mini,nc,cpaf,Tt4,LHV,nb,prb,gaf,nmhpt,nlpt,nmlpt,ehpt,ngb,nprop,nnzl,Raf,alpha);
prcv=mini:int:maxi;
for prc=prcv(2):int:maxi
     [v01 pt01 Tt01 pt21 Tt21 pt31 Tt31 pt41 f1 pt451 Tt451 pt51 Tt51 Tt91 pt91 m91 p91 T91 v91  spthrttl1 TSFC1 nth1 np1 no1 spthrpropRspthrttl1]=turboprop1(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nmhpt,nlpt,nmlpt,ehpt,ngb,nprop,nnzl,Raf,alpha);
    v0=[v0 v01];
    pt0=[pt0 pt01];
    Tt0=[Tt0 Tt01];
    pt2=[pt2 pt21];
    Tt2=[Tt2 Tt21];
    pt3=[pt3 pt31];
    Tt3=[Tt3 Tt31];
    pt4=[pt4 pt41];
    f=[f f1];
    pt45=[pt45 pt451];
    Tt45=[Tt45 Tt451];
    pt5=[pt5 pt51];
    Tt5=[Tt5 Tt51];
    Tt9=[Tt9 Tt91];
    pt9=[pt9 pt91];
    m9=[m9 m91];
    p9=[p9 p91];
    T9=[T9 T91];
    v9=[v9 v91];
    spthrttl=[spthrttl spthrttl1];
    TSFC=[ TSFC  TSFC1];
    nth=[nth nth1];
    np=[np np1];
    no=[no no1];
    spthrpropRspthrttl=[spthrpropRspthrttl spthrpropRspthrttl1];
end
save prcv prcv
save spthrttl spthrttl
save TSFC TSFC
save nth nth
save np np
save no no
save spthrpropRspthrttl spthrpropRspthrttl   
elseif c==1
     vetorprop
    uiwait
load mini
load int
load maxi
format bank
 [v0 pt0 Tt0 pt2 Tt2 pt3 Tt3 pt4 f pt45 Tt45 pt5 Tt5 Tt9 pt9 m9 p9 T9 v9  spthrttl TSFC nth np no spthrpropRspthrttl]=turboprop(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,mini,LHV,nb,prb,gaf,nmhpt,nlpt,nmlpt,ehpt,ngb,nprop,nnzl,Raf,alpha);
Tt4v=mini:int:maxi;
for Tt4=Tt4v(2):int:maxi
     [v01 pt01 Tt01 pt21 Tt21 pt31 Tt31 pt41 f1 pt451 Tt451 pt51 Tt51 Tt91 pt91 m91 p91 T91 v91  spthrttl1 TSFC1 nth1 np1 no1 spthrpropRspthrttl1]=turboprop1(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nmhpt,nlpt,nmlpt,ehpt,ngb,nprop,nnzl,Raf,alpha);
    v0=[v0 v01];
    pt0=[pt0 pt01];
    Tt0=[Tt0 Tt01];
    pt2=[pt2 pt21];
    Tt2=[Tt2 Tt21];
    pt3=[pt3 pt31];
    Tt3=[Tt3 Tt31];
    pt4=[pt4 pt41];
    f=[f f1];
    pt45=[pt45 pt451];
    Tt45=[Tt45 Tt451];
    pt5=[pt5 pt51];
    Tt5=[Tt5 Tt51];
    Tt9=[Tt9 Tt91];
    pt9=[pt9 pt91];
    m9=[m9 m91];
    p9=[p9 p91];
    T9=[T9 T91];
    v9=[v9 v91];
    spthrttl=[spthrttl spthrttl1];
    TSFC=[ TSFC  TSFC1];
    nth=[nth nth1];
    np=[np np1];
    no=[no no1];
    spthrpropRspthrttl=[spthrpropRspthrttl spthrpropRspthrttl1];
end
save Tt4v Tt4v
save spthrttl spthrttl
save TSFC TSFC
save nth nth
save np np
save no no
save spthrpropRspthrttl spthrpropRspthrttl   
    
end

% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close('cnturboprop')


% --- Executes on button press in mn.
function mn_Callback(hObject, eventdata, handles)
% hObject    handle to mn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menu
close('cnturboprop');


% --- Executes on button press in bptsfc.
function bptsfc_Callback(hObject, eventdata, handles)
% hObject    handle to bptsfc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load a
load b
load c
if a==1
load alphav
load TSFC
plot(alphav,TSFC)
xlabel('Power Split')
 ylabel('TSFC (mg/s/N)')
elseif b==1
 load prcv
load TSFC
plot(prcv,TSFC)
xlabel('Compressor Total Pressure Ratio')
 ylabel('TSFC (mg/s/N)')
 elseif c==1
 load Tt4v
load TSFC
plot(Tt4v,TSFC)
xlabel('Turbine Inlet Total Temperature (K)')
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
if a==1
load alphav
load np
load spthrpropRspthrttl
plot(alphav,np,alphav,spthrpropRspthrttl)
xlabel('Power Split')
legend('Propulsive Efficiency','Ratio of Propeller Thrust to Total Thrust')
elseif b==1
   load prcv
load np
load spthrpropRspthrttl
plot(prcv,np,prcv,spthrpropRspthrttl)
xlabel('Compressor Total Pressure Ratio')
legend('Propulsive Efficiency','Ratio of Propeller Thrust to Total Thrust') 
elseif c==1
   load Tt4v
load np
load spthrpropRspthrttl
plot(Tt4v,np,Tt4v,spthrpropRspthrttl)
xlabel('Turbine Inlet Total Temperature (K)')
legend('Propulsive Efficiency','Ratio of Propeller Thrust to Total Thrust') 
end

% --- Executes on button press in bpsnnsthr.
function bpsnnsthr_Callback(hObject, eventdata, handles)
% hObject    handle to bpsnnsthr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load a
load b
load c
if a==1
load alphav
load spthrttl
plot(alphav,spthrttl)
xlabel('Power Split')
 ylabel('specific thrust (Ns/Kg)')
elseif b==1
   load prcv
load spthrttl
plot(prcv,spthrttl)
xlabel('Compressor Total Pressure Ratio')
 ylabel('specific thrust (Ns/Kg)') 
 elseif c==1
   load Tt4v
load spthrttl
plot(Tt4v,spthrttl)
xlabel('Turbine Inlet Total Temperature (K)')
 ylabel('specific thrust (Ns/Kg)') 
end
