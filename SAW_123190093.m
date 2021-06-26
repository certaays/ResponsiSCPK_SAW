function varargout = SAW_123190093(varargin)
% SAW_123190093 MATLAB code for SAW_123190093.fig
%      SAW_123190093, by itself, creates a new SAW_123190093 or raises the existing
%      singleton*.
%
%      H = SAW_123190093 returns the handle to a new SAW_123190093 or the handle to
%      the existing singleton*.
%
%      SAW_123190093('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAW_123190093.M with the given input arguments.
%
%      SAW_123190093('Property','Value',...) creates a new SAW_123190093 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SAW_123190093_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SAW_123190093_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SAW_123190093

% Last Modified by GUIDE v2.5 25-Jun-2021 15:09:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SAW_123190093_OpeningFcn, ...
                   'gui_OutputFcn',  @SAW_123190093_OutputFcn, ...
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


% --- Executes just before SAW_123190093 is made visible.
function SAW_123190093_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SAW_123190093 (see VARARGIN)

%deklarasi variabel global
global r
r.End = [];
% Choose default command line output for SAW_123190093
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SAW_123190093 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SAW_123190093_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%mengambil data input dari .xlsx
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = ([3:8]);
x = readmatrix('DATA RUMAH.xlsx', opts); %nilai data x 
k=[0,1,1,1,1,1]; %nilai atribut, 0 = cost/biaya, dan 1 = benefit/keuntungan
w=[0.30,0.20,0.23,0.10,0.07,0.10]; %bobot untuk masing-masing kriteria

%tahapan 1. normalisasi matriks
[m n]=size (x); %matriks m x n dengan ukuran x(input)
R=zeros (m,n); %membuat matriks kosong R
Y=zeros (m,n); %membuat matriks Y, yang merupakan titik kosong

for j=1:n,
    if k(j)==1, %statement untuk kriteria k = 1 atau benefit/keuntungan
    R(:,j)=x(:,j)./max(x(:,j));
    else %statement untuk kriteria cost/biaya
    R(:,j)=min(x(:,j))./x(:,j);
    end;
end;

%tahapan kedua, proses perangkingan
for i=1:m,
    V(i)= sum(w.*R(i,:)); %mencari nilai V
end;

[rank numb] = sort(V,'descend'); %mengurutkan nilai V yang paling di rekomendasikan

global r
for a=1:20,
    Rank = rank(a); %nilai v yang termasuk 20 besar
    nomor = numb(a); %nomor rumah
    r.End = [r.End; [a Rank nomor]];
    set(handles.uitable2, 'Data', r.End); %menampilkan hasil ke GUI
end;

% --- Executes on button press in showData.
function showData_Callback(hObject, eventdata, handles)
% hObject    handle to showData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%mengambil data dari .xlsx
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = ([1 3:8]);
data = readmatrix('DATA RUMAH.xlsx', opts);
set(handles.uitable1, 'data', data); %menampilkan data ke table GUI

% --- Executes when entered data in editable cell(s) in uitable1.
function uitable1_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in uitable1.
function uitable1_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
