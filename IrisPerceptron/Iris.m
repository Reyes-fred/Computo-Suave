function varargout = Iris(varargin)
% IRIS M-file for Iris.fig
%      IRIS, by itself, creates a new IRIS or raises the existing
%      singleton*.
%
%      H = IRIS returns the handle to a new IRIS or the handle to
%      the existing singleton*.
%
%      IRIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IRIS.M with the given input arguments.
%
%      IRIS('Property','Value',...) creates a new IRIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Iris_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Iris_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Iris

% Last Modified by GUIDE v2.5 23-Jun-2010 10:54:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Iris_OpeningFcn, ...
                   'gui_OutputFcn',  @Iris_OutputFcn, ...
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


% --- Executes just before Iris is made visible.
function Iris_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Iris (see VARARGIN)

% Choose default command line output for Iris
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Iris wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Iris_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnEntrenar.
function btnEntrenar_Callback(hObject, eventdata, handles)
% hObject    handle to btnEntrenar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
% global w1;
% global w2;

irisData = dlmread('iris.data');
x=irisData(1 : 150, 1 : 4);

sd=zeros(150,3);
for i=1:50
    sd(i, 1)=1;
end
for i=51:100
    sd(i, 2)=1;
end
for i=101:150
    sd(i, 3)=1;
end

w1= rand(4,3);
w2= rand(3,3);
ia=0.27;

for n=1:10000
    for s=0:1:8
        for e=1+s:10:150            
            for l=1:3
                ent=x(e,: )*w1(:, l);
                s1(l)=1/(1+exp(ent*(-1)));
            end            
            for l=1:3
                ent=s1*w2(:,l);
                s2(l)=1/(1+exp(ent*(-1)));
            end
            for l=1:3
                error(l)=sd(e,l)-s2(l);
            end
            for l=1:3
                lamdak(l)=s2(l)*(1-s2(l))*error(l);
                for r=1:3
                    w2(r,l)=w2(r,l)+(ia*s1(r))*lamdak(l);
                end
            end
            for l=1:3
                lamda=0;
                for r=1:3
                    lamda=lamda+w2(r,l)*lamdak(r);
                end
                lamda=s1(l)*(1-s1(l))*lamda;
                for r=1:4
                    w1(r, l)=w1(r, l)+(ia*x(e,r)*lamda);
                end 
            end 
        end
    end
end
handles.w1 = w1;
handles.w2 = w2;
guidata(hObject, handles);
h = msgbox('Entrenamiento finalizado');


function txtSepalL_Callback(hObject, eventdata, handles)
% hObject    handle to txtSepalL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSepalL as text
%        str2double(get(hObject,'String')) returns contents of txtSepalL as a double


% --- Executes during object creation, after setting all properties.
function txtSepalL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSepalL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtSepalW_Callback(hObject, eventdata, handles)
% hObject    handle to txtSepalW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtSepalW as text
%        str2double(get(hObject,'String')) returns contents of txtSepalW as a double


% --- Executes during object creation, after setting all properties.
function txtSepalW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtSepalW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtPetalL_Callback(hObject, eventdata, handles)
% hObject    handle to txtPetalL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPetalL as text
%        str2double(get(hObject,'String')) returns contents of txtPetalL as a double


% --- Executes during object creation, after setting all properties.
function txtPetalL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPetalL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtPetalW_Callback(hObject, eventdata, handles)
% hObject    handle to txtPetalW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtPetalW as text
%        str2double(get(hObject,'String')) returns contents of txtPetalW as a double


% --- Executes during object creation, after setting all properties.
function txtPetalW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtPetalW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnReconocer.
function btnReconocer_Callback(hObject, eventdata, handles)
% hObject    handle to btnReconocer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
w1 = handles.w1;
w2 = handles.w2;

p=zeros(1,4);
temp=get(handles.txtSepalL,'String');
p(1)=str2double(temp);
temp=get(handles.txtSepalW,'String');
p(2)=str2double(temp);
temp=get(handles.txtPetalL,'String');
p(3)=str2double(temp);
temp=get(handles.txtPetalW,'String');
p(4)=str2double(temp);
for i = 1:1:3
    ent = p * w1(:,i);
    sal1(i) = 1 / (1 + exp(-1*ent));
end
for i = 1:1:3
    ent = sal1 * w2(:,i);
    sal2(i) = round( 1 / (1 + exp(-1*ent)));
end

if sal2==[1 0 0]
    h=msgbox('Su flor es Iris Setosa');
end

if sal2==[0 1 0]
    h=msgbox('Su flor es Iris Versicolor');
end

if sal2==[0 0 1]
    h=msgbox('Su flor es Iris Virginica');
end
