function varargout = create_contrasts(varargin)
% CREATE_CONTRASTS MATLAB code for create_contrasts.fig
%      CREATE_CONTRASTS, by itself, creates a new CREATE_CONTRASTS or raises the existing
%      singleton*.
%
%      H = CREATE_CONTRASTS returns the handle to a new CREATE_CONTRASTS or the handle to
%      the existing singleton*.
%
%      CREATE_CONTRASTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CREATE_CONTRASTS.M with the given input arguments.
%
%      CREATE_CONTRASTS('Property','Value',...) creates a new CREATE_CONTRASTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before create_contrasts_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to create_contrasts_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help create_contrasts

% Last Modified by GUIDE v2.5 15-Oct-2015 14:37:11

% Begin initialization code - DO NOT EDIT

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @create_contrasts_OpeningFcn, ...
                   'gui_OutputFcn',  @create_contrasts_OutputFcn, ...
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


% --- Executes just before create_contrasts is made visible.
function create_contrasts_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to create_contrasts (see VARARGIN)

% Choose default command line output for create_contrasts
handles.output = hObject;

if ~isempty(varargin)
    tmp_contrasts = varargin{1,1};
    contrasts = {};
    for i=1:length(tmp_contrasts)
        contrasts{end+1} = tmp_contrasts{1,i}{1,1};
    end

    set(handles.conlist,'String',contrasts)
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes create_contrasts wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = create_contrasts_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'list_contrasts')
    varargout{1} = handles.list_contrasts;
else
    varargout{1} = [];
end

delete(handles.figure1)


% Get default command line output from handles structure

% --- Executes on selection change in conlist.
function conlist_Callback(hObject, eventdata, handles)
% hObject    handle to conlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns conlist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from conlist


% --- Executes during object creation, after setting all properties.
function conlist_CreateFcn(hObject, eventdata, handles, varargin)
% hObject    handle to conlist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if ~isfield(handles,'list_contrasts')
    handles.list_contrasts = {};
    handles.list_contrasts2display = {};
end
if ~isempty(get(handles.input,'String'))
    
    defaultans = {get(handles.input,'String')};
    tmp_input = inputdlg('Enter contrast name: ','',1,defaultans);
    if ~isempty(tmp_input)
        handles.list_contrasts{1,end+1} = get(handles.input,'String');
        handles.list_contrasts{2,end} = tmp_input{1,1};
        
        handles.list_contrasts2display{end+1} = ...
            [get(handles.input,'String') ' : ' tmp_input{1,1}];
        
        qstring = 'Do you want the opposite contrast: ';
        options.Default = 'No';
        options.Interpreter = 'tex';
        choice = questdlg(qstring,'Boundary Condition',...
                'Yes','No',options);
        switch choice
            case 'Yes'
                handles.list_contrasts{1,end+1} = ['- ' get(handles.input,'String')];
                handles.list_contrasts{2,end} = ['-' tmp_input{1,1}];
                handles.list_contrasts2display{end+1} = ...
               ['- ' get(handles.input,'String') ' : ' '-' tmp_input{1,1}];
                
            case 'No'

        end
        set(handles.allContrasts,'String',handles.list_contrasts2display);
        Clear_Callback(hObject, eventdata, handles)
    else
        Clear_Callback(hObject, eventdata, handles)
    end
    set(handles.title_list,'String',strcat(num2str(length(handles.list_contrasts2display)),' Contrasts to compute : name'))
    guidata(hObject,handles);
end

 
% --- Executes on button press in Clear.
function Clear_Callback(hObject, eventdata, handles)
% hObject    handle to Clear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.input,'String','')


function input_Callback(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input as text
%        str2double(get(hObject,'String')) returns contents of input as a double


% --- Executes during object creation, after setting all properties.
function input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add.
function add_Callback(hObject, eventdata, handles)
% hObject    handle to add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = get(handles.input,'String');
index_selected = get(handles.conlist,'Value');
file_list = get(handles.conlist,'String');
% Item selected in list box
conlistChoice = file_list{index_selected};

if isempty(input)
    set(handles.input,'String',conlistChoice)
elseif ~strcmp(input(end-1:end),') ')
    set(handles.input,'String',[input,conlistChoice])
end
guidata(hObject, handles);

% --- Executes on button press in quit.
function varargout = quit_Callback(hObject, eventdata, handles)
% hObject    handle to quit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargout{1} = handles.list_contrasts;
% close(handles.figure1)
uiresume(handles.figure1)

% --- Executes during object creation, after setting all properties.
function allContrasts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to allContrasts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'Max',100);


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


% --- Executes on button press in plus.
function plus_Callback(hObject, eventdata, handles)
% hObject    handle to plus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = get(handles.input,'String');

if ~isempty(input) 
    last_chars = input(end-1:end);
    if ~strcmp(last_chars,'- ') && ~strcmp(last_chars,'+ ') ...
            && ~strcmp(last_chars,'( ')
        set(handles.input,'String',[input,' + '])
    end
end
guidata(hObject, handles);

% --- Executes on button press in minus.
function minus_Callback(hObject, eventdata, handles)
% hObject    handle to minus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = get(handles.input,'String');

if ~isempty(input) 
    last_chars = input(end-1:end);
    if ~strcmp(last_chars,'- ') && ~strcmp(last_chars,'+ ') ...
            && ~strcmp(last_chars,'( ')
        set(handles.input,'String',[input,' - '])
    end
else
    set(handles.input,'String','- ')
end
guidata(hObject, handles);

% --- Executes on button press in start_p.
function start_p_Callback(hObject, eventdata, handles)
% hObject    handle to start_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = get(handles.input,'String');

if ~isempty(input) 
    last_chars = input(end-1:end);
    if strcmp(last_chars,'- ') && ~strcmp(last_chars,'+ ')
        set(handles.input,'String',[input,' ( '])
    end
elseif isempty(input)
    set(handles.input,'String','( ')
end
guidata(hObject, handles)

% --- Executes on button press in end_p.
function end_p_Callback(hObject, eventdata, handles)
% hObject    handle to end_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
input = get(handles.input,'String');

if ~isempty(input) 
    last_chars = input(end-1:end);
    if ~strcmp(last_chars,'- ') && ~strcmp(last_chars,'+ ')
        set(handles.input,'String',[input,' ) '])
    end
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function title_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to allContrasts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in delete_contrast.
function delete_contrast_Callback(hObject, eventdata, handles)
% hObject    handle to delete_contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
index_selected = get(handles.allContrasts,'Value');
if index_selected==length(handles.list_contrasts2display)
    set(handles.allContrasts,'Value',1);
end
disp(index_selected)
handles.list_contrasts(:,index_selected) = [];
handles.list_contrasts2display(index_selected) = [];
set(handles.allContrasts,'String',handles.list_contrasts2display);
set(handles.title_list,'String',strcat(num2str(length(handles.list_contrasts2display)),' Contrasts to compute : name'))
guidata(hObject, handles);


% --------------------------------------------------------------------
function File_Callback(hObject, eventdata, handles)
% hObject    handle to File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function load_struct_Callback(hObject, eventdata, handles)
% hObject    handle to load_struct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,FilterIndex] = uigetfile('*.mat','Load structure of contrasts');
structure = load([PathName,FileName]);
if p_isValidStructureContrast(structure,get(handles.conlist,'String'));
    handles.list_contrasts2display = structure.list_contrasts2display;
    handles.list_contrasts = structure.list_contrasts;
    set(handles.allContrasts,'String',handles.list_contrasts2display);
    set(handles.title_list,'String',strcat(num2str(length(structure.list_contrasts2display)),' Contrasts to compute : name'))
    guidata(hObject,handles)
end




% --------------------------------------------------------------------
function save_struct_Callback(hObject, eventdata, handles)
% hObject    handle to save_struct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
answer = inputdlg('Save structure');
if ~isempty(answer)
    list_contrasts2display = handles.list_contrasts2display;
    list_contrasts = handles.list_contrasts;
    save([char(answer) '_struct.mat'],'list_contrasts2display','list_contrasts');
end
