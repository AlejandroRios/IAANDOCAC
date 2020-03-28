function varargout = CNTurbojet(varargin)
% CNTURBOJET MATLAB code for CNTurbojet.fig
%      CNTURBOJET, by itself, creates a new CNTURBOJET or raises the existing
%      singleton*.
%
%      H = CNTURBOJET returns the handle to a new CNTURBOJET or the handle to
%      the existing singleton*.
%
%      CNTURBOJET('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CNTURBOJET.M with the given input arguments.
%
%      CNTURBOJET('Property','Value',...) creates a new CNTURBOJET or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CNTurbojet_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CNTurbojet_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CNTurbojet

% Last Modified by GUIDE v2.5 20-Jun-2015 05:59:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CNTurbojet_OpeningFcn, ...
                   'gui_OutputFcn',  @CNTurbojet_OutputFcn, ...
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


% --- Executes just before CNTurbojet is made visible.
function CNTurbojet_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CNTurbojet (see VARARGIN)

% Choose default command line output for CNTurbojet
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CNTurbojet wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CNTurbojet_OutputFcn(hObject, eventdata, handles) 
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



function nt_Callback(hObject, eventdata, handles)
% hObject    handle to nt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nt as text
%        str2double(get(hObject,'String')) returns contents of nt as a double


% --- Executes during object creation, after setting all properties.
function nt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nt (see GCBO)
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
% --- Executes when selected object is changed in uipanel6.
function uipanel6_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel6 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
a=get(handles.radioprc, 'Value');
b=get(handles.radiott4, 'Value');
c=get(handles.radiom, 'Value');
save a a
save b b
save c c

% --- Executes on button press in pushbutton1.
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
nbs=get(handles.nb,'string');
nb=str2num(nbs);
prbs=get(handles.prb,'string');
prb=str2num(prbs);
nts=get(handles.nt,'string');
nt=str2num(nts);
prns=get(handles.prn,'string');
prn=str2num(prns);
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
nts=get(handles.nt,'string');
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
R=((cp*(g-1))/g);
Raf=((cpaf*(gaf-1))/gaf);
if a==1
    
    vetortbj
    uiwait
load mini
load int
load maxi
format bank
[v0 pt0 Tt0 pt2 Tt2 pt3 Tt3 pt4 f pt5 Tt5 Tt9 pt9 m9 p9 T9 v9 A9Rm0 veff spthr TSFC nth np no st]=analysis(R,g,T0,m0,p0,cp,prd,mini,nc,cpaf,Tt4,LHV,nb,prb,gaf,nt,prn,Raf);
prcv=mini:int:maxi;
for prc=prcv(2):int:maxi
    [v01 pt01 Tt01 pt21 Tt21 pt31 Tt31 pt41 f1 pt51 Tt51 Tt91 pt91 m91 p91 T91 v91 A9Rm01 veff1 spthr1 TSFC1 nth1 np1 no1 st1]=analysis1(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nt,prn,Raf);
    v0=[v0 v01];
    pt0=[pt0 pt01];
    Tt0=[Tt0 Tt01];
    pt2=[pt2 pt21];
    Tt2=[Tt2 Tt21];
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
    spthr=[spthr spthr1];
    TSFC=[TSFC TSFC1];
    nth=[nth nth1];
    np=[np np1];
    no=[no no1];
end
save prcv prcv
guidata(hObject,handles)
save nth nth
guidata(hObject,handles)
save f f
guidata(hObject,handles)
save v9 v9
guidata(hObject,handles)
save TSFC TSFC
guidata(hObject,handles)
save spthr spthr
guidata(hObject,handles)
elseif b==1
  vetortbj
    uiwait
load mini
load int
load maxi
[v0 pt0 Tt0 pt2 Tt2 pt3 Tt3 pt4 f pt5 Tt5 Tt9 pt9 m9 p9 T9 v9 A9Rm0 veff spthr TSFC nth np no st]=analysis(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,mini,LHV,nb,prb,gaf,nt,prn,Raf);
Tt4v=mini:int:maxi;
for Tt4=Tt4v(2):int:maxi
   [v01 pt01 Tt01 pt21 Tt21 pt31 Tt31 pt41 f1 pt51 Tt51 Tt91 pt91 m91 p91 T91 v91 A9Rm01 veff1 spthr1 TSFC1 nth1 np1 no1 st1]=analysis1(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nt,prn,Raf);
    v0=[v0 v01];
    pt0=[pt0 pt01];
    Tt0=[Tt0 Tt01];
    pt2=[pt2 pt21];
    Tt2=[Tt2 Tt21];
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
    spthr=[spthr spthr1];
    TSFC=[TSFC TSFC1];
    nth=[nth nth1];
    np=[np np1];
    no=[no no1];
end
save Tt4v Tt4v
guidata(hObject,handles)
save nth nth
guidata(hObject,handles)
save f f
guidata(hObject,handles)
save v9 v9
guidata(hObject,handles)
save TSFC TSFC
guidata(hObject,handles)
save spthr spthr
guidata(hObject,handles)
elseif c==1 
    vetortbj
    uiwait
load mini
load int
load maxi
[v0 pt0 Tt0 pt2 Tt2 pt3 Tt3 pt4 f pt5 Tt5 Tt9 pt9 m9 p9 T9 v9 A9Rm0 veff spthr TSFC nth np no st]=analysis(R,g,T0,mini,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nt,prn,Raf);
m0v=mini:int:maxi;
for m0=m0v(2):int:maxi
   [v01 pt01 Tt01 pt21 Tt21 pt31 Tt31 pt41 f1 pt51 Tt51 Tt91 pt91 m91 p91 T91 v91 A9Rm01 veff1 spthr1 TSFC1 nth1 np1 no1 st1]=analysis1(R,g,T0,m0,p0,cp,prd,prc,nc,cpaf,Tt4,LHV,nb,prb,gaf,nt,prn,Raf);
    v0=[v0 v01];
    pt0=[pt0 pt01];
    Tt0=[Tt0 Tt01];
    pt2=[pt2 pt21];
    Tt2=[Tt2 Tt21];
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
    spthr=[spthr spthr1];
    TSFC=[TSFC TSFC1];
    nth=[nth nth1];
    np=[np np1];
    no=[no no1];
end
save m0v m0v
guidata(hObject,handles)
save nth nth
guidata(hObject,handles)
save f f
guidata(hObject,handles)
save v9 v9
guidata(hObject,handles)
save TSFC TSFC
guidata(hObject,handles)
save spthr spthr
guidata(hObject,handles)
end


    


% --- Executes on button press in Exit.
function Exit_Callback(hObject, eventdata, handles)
% hObject    handle to Exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close('CNTurbojet')


% --- Executes on button press in mn.
function mn_Callback(hObject, eventdata, handles)
% hObject    handle to mn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
menu
close('CNTurbojet');


% --- Executes on button press in prcv0nth.
function prcv0nth_Callback(hObject, eventdata, handles)
% hObject    handle to prcv0nth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load a
load b
load c
if a==1
load prcv
load nth
plot(prcv,nth)
 xlabel('Compressor Total Pressure Ratio')
 ylabel('Thermal Efficiency')
elseif b==1
  load Tt4v
load nth
plot(Tt4v,nth)
 xlabel('Turbine inlet Tempreture (K)')
 ylabel('Thermal Efficiency')
else 
    load m0v
load nth
plot(m0v,nth)
 xlabel('Freestream Mach Number')
 ylabel('Thermal Efficiency')
end

% --- Executes on button press in f0tsfc.
function f0tsfc_Callback(hObject, eventdata, handles)
% hObject    handle to f0tsfc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load a
load b
load c
if a==1
load prcv
load TSFC
plot(prcv,TSFC)
xlabel('Compressor Total Pressure Ratio')
 ylabel('TSFC')
elseif b==1
    load Tt4v
load TSFC
plot(Tt4v,TSFC)
xlabel('Turbine inlet Tempreture (K)')
 ylabel('TSFC')
else
  load m0v
load TSFC
plot(m0v,TSFC)
 xlabel('Freestream Mach Number')
 ylabel('TSFC')  
end

% --- Executes on button press in prcv0f.
function prcv0f_Callback(hObject, eventdata, handles)
% hObject    handle to prcv0f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load a
load b
load c
if a==1
load f
load prcv
plot(prcv,f)
xlabel('Compressor Total Pressure Ratio')
ylabel('Fuel to air ratio')
elseif b==1
 load f
load Tt4v
plot(Tt4v,f)
xlabel('Turbine inlet Tempreture (K)')
ylabel('Fuel to air ratio')   
else
  load f
load m0v
plot(m0v,f)
xlabel('Freestream Mach Number')
ylabel('Fuel to air ratio')     
end


% --- Executes on button press in spth.
function spth_Callback(hObject, eventdata, handles)
% hObject    handle to spth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load a
load b
load c
if a==1
load spthr
load prcv
plot(prcv,spthr)
xlabel('Compressor Total Pressure Ratio')
ylabel('Specific Thrust')
elseif b==1
 load spthr
load Tt4v
plot(Tt4v,spthr)
xlabel('Turbine inlet Tempreture (K)')
ylabel('Specific Thrust')  
elseif c==1
  load spthr
load m0v
plot(m0v,spthr)
xlabel('Freestream Mach Number')
ylabel('Specific Thrust')   
end


% --- Executes during object deletion, before destroying properties.
function nt_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to nt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
