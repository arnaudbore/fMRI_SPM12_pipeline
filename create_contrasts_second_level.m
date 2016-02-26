function varargout = create_contrasts_second_level(varargin)
% CREATE_CONTRASTS_SECOND_LEVEL MATLAB code for create_contrasts_second_level.fig
%      CREATE_CONTRASTS_SECOND_LEVEL, by itself, creates a new CREATE_CONTRASTS_SECOND_LEVEL or raises the existing
%      singleton*.
%
%      H = CREATE_CONTRASTS_SECOND_LEVEL returns the handle to a new CREATE_CONTRASTS_SECOND_LEVEL or the handle to
%      the existing singleton*.
%
%      CREATE_CONTRASTS_SECOND_LEVEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CREATE_CONTRASTS_SECOND_LEVEL.M with the given input arguments.
%
%      CREATE_CONTRASTS_SECOND_LEVEL('Property','Value',...) creates a new CREATE_CONTRASTS_SECOND_LEVEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before create_contrasts_second_level_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to create_contrasts_second_level_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help create_contrasts_second_level

% Last Modified by GUIDE v2.5 06-Oct-2015 09:44:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @create_contrasts_second_level_OpeningFcn, ...
                   'gui_OutputFcn',  @create_contrasts_second_level_OutputFcn, ...
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


% --- Executes just before create_contrasts_second_level is made visible.
function create_contrasts_second_level_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to create_contrasts_second_level (see VARARGIN)

% Choose default command line output for create_contrasts_second_level
handles.output = hObject;

tmp_contrasts = varargin{1,1};
contrasts = {};
for i=1:length(tmp_contrasts)
    contrasts{end+1} = tmp_contrasts{1,i};
end

set(handles.listContrasts,'String',contrasts)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes create_contrasts_second_level wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = create_contrasts_second_level_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
if isfield(handles,'listContrastsToDisplay')
    varargout{1} = handles.listContrastsToDisplay;
else
    varargout{1} = [];
end

delete(handles.figure1)


% --- Executes on selection change in listContrasts.
function listContrasts_Callback(hObject, eventdata, handles)
% hObject    handle to listContrasts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listContrasts contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listContrasts


% --- Executes during object creation, after setting all properties.
function listContrasts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listContrasts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add.
function add_Callback(hObject, eventdata, handles)
% hObject    handle to add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

contrasts_list = get(handles.listContrasts,'String');
index_selected = get(handles.listContrasts,'Value');


if ~isfield(handles,'listContrastsToDisplay')
    handles.listContrastsToDisplay = {};
end
% Item selected in list box
if isempty(handles.listContrastsToDisplay) || ~any(ismember({handles.listContrastsToDisplay{1,:}},contrasts_list{index_selected})) 
    defaultans = {contrasts_list{index_selected}};
    tmp_input = inputdlg('Enter contrast name: ','',1,defaultans);
    
    if ~isempty(tmp_input)
        handles.listContrastsToDisplay{1,end+1} = contrasts_list{index_selected};
        handles.listContrastsToDisplay{2,end} = tmp_input{1,1};
    end
end

set(handles.listContrastsFinal,'String',{handles.listContrastsToDisplay{1,:}})
% Update handles structure
guidata(hObject, handles);


% --- Executes on selection change in listContrastsFinal.
function listContrastsFinal_Callback(hObject, eventdata, handles)
% hObject    handle to listContrastsFinal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listContrastsFinal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listContrastsFinal


% --- Executes during object creation, after setting all properties.
function listContrastsFinal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listContrastsFinal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in quit.
function quit_Callback(hObject, eventdata, handles)
% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiresume(handles.figure1)

% --- Executes on button press in remove.
function remove_Callback(hObject, eventdata, handles)
% hObject    handle to remove (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
index_selected = get(handles.listContrastsFinal,'Value');
if index_selected==size(handles.listContrastsToDisplay,2)
    set(handles.listContrastsFinal,'Value',1);
end
handles.listContrastsToDisplay(:,index_selected) = [];
set(handles.listContrastsFinal,'String',{handles.listContrastsToDisplay{1,:}});

% Update handles structure
guidata(hObject, handles);

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(hObject, 'waitstatus'), 'waiting')
% The GUI is still in UIWAIT, us UIRESUME
    uiresume(hObject);
else
% The GUI is no longer waiting, just close it
    delete(hObject);
end
