%% INITIALISATION

function varargout = FLIM_analysis(varargin)
% FLIM_ANALYSIS MATLAB code for FLIM_analysis.fig
%      FLIM_ANALYSIS, by itself, creates a new FLIM_ANALYSIS or raises the existing
%      singleton*.
%
%      H = FLIM_ANALYSIS returns the handle to a new FLIM_ANALYSIS or the handle to
%      the existing singleton*.
%
%      FLIM_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FLIM_ANALYSIS.M with the given input arguments.
%
%      FLIM_ANALYSIS('Property','Value',...) creates a new FLIM_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FLIM_analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FLIM_analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FLIM_analysis

% Last Modified by GUIDE v2.5 01-Jul-2013 13:28:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FLIM_analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @FLIM_analysis_OutputFcn, ...
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



%% OPENING

% --- Executes just before FLIM_analysis is made visible.
function FLIM_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FLIM_analysis (see VARARGIN)

% Choose default command line output for FLIM_analysis
handles.output = hObject;

movegui('center');

set(handles.axes1,'Visible','off');
set(handles.axes2,'Visible','off');
set(handles.axes3,'Visible','off');
set(handles.load_detection_ok,'Visible','off');
set(handles.load_intensity_ok,'Visible','off');
set(handles.load_lifetime_ok,'Visible','off');
set(handles.set_results_location_ok,'Visible','off');
set(handles.load_previous_analysis_ok,'Visible','off');
set(handles.select_roi_ok,'Visible','off');
set(handles.use_detection_mask_ok,'Visible','off');
set(handles.channel_setup_panel,'Visible','off');
set(handles.detection_panel,'Visible','off');
set(handles.filtering_panel,'Visible','off');
set(handles.background_panel,'Visible','off');
set(handles.distribution_panel,'Visible','off');
set(handles.profile_panel,'Visible','off');
set(handles.scale_panel,'Visible','off');
set(handles.segmentation_method,'Enable','off');
set(handles.text14,'Enable','off');
set(handles.select_background_ok,'Visible','off');
set(handles.use_background_ok,'Visible','off');
set(handles.lifetime_background_mean,'Enable','off');
set(handles.lifetime_background_median,'Enable','off');
set(handles.segmentation_value_slider,'Enable','off');
set(handles.load_previous_analysis,'Enable','off');
set(handles.use_detection_mask,'Enable','off');
set(handles.show_roi,'Enable','off');
set(handles.show_mask,'Enable','off');
set(handles.use_detection_mask_ok,'Visible','off');
set(handles.line_selection,'Enable','off');
set(handles.save,'Enable','off');
set(handles.analyse,'Enable','off');
set(handles.erase_line,'Enable','off');
set(handles.save_profile_image_eps,'Enable','off');
set(handles.save_profile_image_tif,'Enable','off');
set(handles.save_profile_data_csv,'Enable','off');
set(handles.save_profile_graph_eps,'Enable','off');
set(handles.plot_distribution,'Enable','off');
set(handles.save_distribution,'Enable','off');
set(handles.lifetime_analysis_mean,'Enable','off');
set(handles.lifetime_analysis_median,'Enable','off');
set(handles.analyse_background,'Enable','off');
set(handles.save_background,'Enable','off');
set(handles.select_background,'Enable','off');
set(handles.use_background,'Enable','off');
set(handles.lifetime_background_mean,'Enable','off');
set(handles.lifetime_background_median,'Enable','off');
set(handles.save_montage,'Enable','off');
set(handles.erase_line,'Enable','off');


handles.analysis_type = 'mean';
handles.background_analysis_type = 'mean';
handles.min_lifetime = 2000;
handles.max_lifetime = 3500;
handles.ids = 0;
handles.bin_number = 20;

% Update handles structure
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = FLIM_analysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



%% FILE SETUP PANEL

% --- Executes on button press in load_detection.
function load_detection_Callback(hObject, eventdata, handles)
% hObject    handle to load_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Browse the files from user
[handles.detection_image_name path]=uigetfile({'*.tif';'*.tiff';'*.jpg';'*.bmp';'*.jpeg';'*.png'}, 'Load Image File');
detection_image=[path handles.detection_image_name];
handles.file_detection=detection_image;
if (handles.detection_image_name==0)
    warndlg('You did not select a compatible file') ; % no file selected
end
[fpath, fname, fext]=fileparts(handles.detection_image_name);
validex=({'.tif';'.tiff';'.jpg';'.bmp';'.jpeg';'.png'});
found=0;
for x=1:length(validex)
    if strcmpi(fext,validex{x})
        found=1;
        set(handles.axes1,'Visible','on');
        set(handles.channel_setup_panel,'Visible','on');
        handles.detection_image=imread(detection_image);
        handles.detection_i=imread(detection_image);
        axes(handles.axes1); cla; imshow(handles.detection_image,[]);
        set(handles.detection_name,'String',handles.detection_image_name);
        guidata(hObject,handles);
        
        break
        
    end
end
if found==0
    errordlg('Selected file does not match available extensions. Please select file from available extensions [ .jpg, .jpeg, .bmp, .png, .tif, .tiff] ','Image Format Error');
end

% Display the "OK" to confirm loading.

set(handles.load_detection_ok,'Visible','on');

% --- Executes on button press in load_intensity.
function load_intensity_Callback(hObject, eventdata, handles)
% hObject    handle to load_intensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Browse the files from user
[handles.intensity_image_name path]=uigetfile({'*.tiff';'*.tif';'*.jpg';'*.bmp';'*.jpeg';'*.png'}, 'Load Image File');
intensity_image=[path handles.intensity_image_name];
handles.file_intensity=intensity_image;
if (handles.intensity_image_name==0)
    warndlg('You did not select a compatible file') ; % no file selected
end
[fpath, fname, fext]=fileparts(handles.intensity_image_name);
validex=({'.tiff';'.tif';'.jpg';'.bmp';'.jpeg';'.png'});
found=0;

for x=1:length(validex)
    if strcmpi(fext,validex{x})
        found=1;
        set(handles.axes1,'Visible','on');
        set(handles.channel_setup_panel,'Visible','on');
        
        handles.intensity_image=imread(intensity_image);
        handles.intensity_i=imread(intensity_image);
        axes(handles.axes1); cla; imshow(handles.intensity_image,[]);
        set(handles.intensity_name,'String',handles.intensity_image_name);
        guidata(hObject,handles);
        
        break
        
    end
end
if found==0
    errordlg('Selected file does not match available extensions. Please select file from available extensions [ .jpg, .jpeg, .bmp, .png, .tif, .tiff] ','Image Format Error');
end

% Display the "OK" to confirm loading.

set(handles.load_intensity_ok,'Visible','on');

% --- Executes on button press in load_lifetime.
function load_lifetime_Callback(hObject, eventdata, handles)
% hObject    handle to load_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Browse the files from user
[handles.lifetime_image_name path]=uigetfile({'*.tiff';'*.tif';'*.jpg';'*.bmp';'*.jpeg';'*.png'}, 'Load Image File');
lifetime_image=[path handles.lifetime_image_name];
handles.file_lifetime=lifetime_image;
if (handles.lifetime_image_name==0)
    warndlg('You did not select a compatible file') ; % no file selected
end
[fpath, fname, fext]=fileparts(handles.lifetime_image_name);
validex=({'.tiff';'.tif';'.jpg';'.bmp';'.jpeg';'.png'});
found=0;
for x=1:length(validex)
    if strcmpi(fext,validex{x})
        found=1;
        set(handles.axes1,'Visible','on');
        set(handles.channel_setup_panel,'Visible','on');
        
        handles.lifetime_image=imread(lifetime_image);
        handles.lifetime_i=imread(lifetime_image);
        axes(handles.axes1); cla; imshow(handles.lifetime_image,[]);
        set(handles.lifetime_name,'String',handles.lifetime_image_name);
        set(handles.default_name,'String',handles.lifetime_image_name);
        guidata(hObject,handles);
        
        break
        
    end
end
if found==0
    errordlg('Selected file does not match available extensions. Please select file from available extensions [ .jpg, .jpeg, .bmp, .png, .tif, .tiff] ','Image Format Error');
end

% Display the "OK" to confirm loading.

set(handles.load_lifetime_ok,'Visible','on');

% Display the next panel (detection)

set(handles.detection_panel,'Visible','on');

% --- Executes on button press in set_results_location.
function set_results_location_Callback(hObject, eventdata, handles)
% hObject    handle to set_results_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

current_location = which('FLIM_analysis');
[current_location,~,~] = fileparts(current_location);

handles.current_folder = current_location;

pathname_results = uigetdir('~/Desktop/','Directory to store outputs');
timestamp = datestr(now, 'ddmmyyyy_HHMMSS');
results_folder = ['FLIM_analysis_' timestamp];
mkdir(pathname_results,results_folder);
path_results = [pathname_results '/' results_folder];
addpath(path_results);
handles.results_folder = path_results;

% Display the "OK" to confirm loading.

set(handles.set_results_location_ok,'Visible','on');

% Update handles structure
guidata(hObject, handles);

function default_name_Callback(hObject, eventdata, handles)
% hObject    handle to default_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.default_name = get(hObject,'String');

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function default_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to default_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in load_previous_analysis.
function load_previous_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to load_previous_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in reset_all.
function reset_all_Callback(hObject, eventdata, handles)
% hObject    handle to reset_all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1); cla(handles.axes1); set(handles.axes1,'Visible','off');
axes(handles.axes2); cla(handles.axes2); set(handles.axes2,'Visible','off');
axes(handles.axes3); cla(handles.axes3); set(handles.axes3,'Visible','off');
set(handles.load_detection_ok,'Visible','off');
set(handles.load_intensity_ok,'Visible','off');
set(handles.load_lifetime_ok,'Visible','off');
set(handles.set_results_location_ok,'Visible','off');
set(handles.load_previous_analysis_ok,'Visible','off');
set(handles.select_roi_ok,'Visible','off');
set(handles.use_detection_mask_ok,'Visible','off');
set(handles.channel_setup_panel,'Visible','off');
set(handles.detection_panel,'Visible','off');
set(handles.filtering_panel,'Visible','off');
set(handles.background_panel,'Visible','off');
set(handles.distribution_panel,'Visible','off');
set(handles.profile_panel,'Visible','off');
set(handles.scale_panel,'Visible','off');

set(handles.default_name,'String','Default results name')

guidata(hObject,handles);



%% CHANNEL SETUP PANEL

function detection_name_Callback(hObject, eventdata, handles)
% hObject    handle to detection_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function detection_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to detection_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in show_detection.
function show_detection_Callback(hObject, eventdata, handles)
% hObject    handle to show_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1); cla; imshow(handles.detection_image,[]);

function intensity_name_Callback(hObject, eventdata, handles)
% hObject    handle to intensity_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function intensity_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intensity_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in show_intensity.
function show_intensity_Callback(hObject, eventdata, handles)
% hObject    handle to show_intensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1); cla; imshow(handles.intensity_image,[]);

function lifetime_name_Callback(hObject, eventdata, handles)
% hObject    handle to lifetime_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function lifetime_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lifetime_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in show_lifetime.
function show_lifetime_Callback(hObject, eventdata, handles)
% hObject    handle to show_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1); cla; imshow(handles.lifetime_image,[]);

% --- Executes on button press in show_roi.
function show_roi_Callback(hObject, eventdata, handles)
% hObject    handle to show_roi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1); cla; imshow((handles.roi_cell == 0),[]);

% --- Executes on button press in show_mask.
function show_mask_Callback(hObject, eventdata, handles)
% hObject    handle to show_mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1); cla; imshow(handles.detection_mask,[]);



%% DETECTION PANEL

% --- Executes on selection change in tool_selection_roi.
function tool_selection_roi_Callback(hObject, eventdata, handles)
% hObject    handle to tool_selection_roi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selection = get(hObject,'Value');

switch selection
    case 1
        handles.cell_ROI_tool = 'impoly';
    case 2
        handles.cell_ROI_tool = 'impoly';
    case 3
        handles.cell_ROI_tool = 'imfreehand';
end

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function tool_selection_roi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tool_selection_roi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in select_roi.
function select_roi_Callback(hObject, eventdata, handles)
% hObject    handle to select_roi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

roi = eval(handles.cell_ROI_tool);
wait(roi);

handles.roi_cell = createMask(roi);
handles.roi_cell = (handles.roi_cell == 0);
handles.detection_image = roifilt2(0, handles.detection_image, handles.roi_cell);
handles.intensity_image = roifilt2(0, handles.intensity_image, handles.roi_cell);
handles.lifetime_image = roifilt2(0, handles.lifetime_image, handles.roi_cell);

% Display the green "OK"

set(handles.select_roi_ok,'Visible','on');

% Activate the rest of the panel

set(handles.segmentation_method,'Enable','on');
set(handles.text14,'Enable','on');
set(handles.segmentation_value_slider,'Enable','on');
set(handles.show_roi,'Enable','on');

% Update handles structure
guidata(hObject, handles);

% --- Executes on selection change in segmentation_method.
function segmentation_method_Callback(hObject, eventdata, handles)
% hObject    handle to segmentation_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

selection = get(hObject,'Value');
switch selection
    
    case 1
        handles.detection_mask = im2bw(handles.detection_image,0.5);
        axes(handles.axes1); cla; imshow(handles.intensity_image,[]);
        axes(handles.axes2); cla; imshow(handles.detection_mask);
        set(handles.use_detection_mask,'Enable','on');
        
    case 2
        handles.detection_mask = im2bw(handles.detection_image,0.5);
        axes(handles.axes1); cla; imshow(handles.intensity_image,[]);
        axes(handles.axes2); cla; imshow(handles.detection_mask);
        set(handles.use_detection_mask,'Enable','on');

    case 3
        se = strel('diamond', 2);
        Ie = imerode(handles.intensity_image, se);
        Iobr = imreconstruct(Ie, handles.intensity_image);
        Iobrd = imdilate(Iobr, se);
        Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
        Iobrcbr = imcomplement(Iobrcbr);
        handles.detection_mask = imregionalmax(Iobrcbr,8);
        axes(handles.axes1); cla; imshow(handles.intensity_image,[]);
        axes(handles.axes2); cla; imshow(handles.detection_mask);

    case 4
        se = strel('diamond', 2);
        Ie = imerode(handles.intensity_image, se);
        Iobr = imreconstruct(Ie, handles.intensity_image);
        Iobrd = imdilate(Iobr, se);
        Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
        Iobrcbr = imcomplement(Iobrcbr);
        handles.detection_mask = imregionalmax(Iobrcbr,8);
        axes(handles.axes1); cla; imshow(handles.intensity_image,[]);
        axes(handles.axes2); cla; imshow(handles.detection_mask);
        
end

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function segmentation_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to segmentation_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function segmentation_value_slider_Callback(hObject, eventdata, handles)
% hObject    handle to segmentation_value_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

% threshold_value = get(hObject,'Value');
% handles.detection_mask = im2bw(handles.detection_image,threshold_value);
% axes(handles.axes1); cla; imshow(handles.intensity_image,[]);
% axes(handles.axes2); cla; imshow(handles.detection_mask,[]);
% set(handles.use_detection_mask,'Enable','on');

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function segmentation_value_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to segmentation_value_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in use_detection_mask.
function use_detection_mask_Callback(hObject, eventdata, handles)
% hObject    handle to use_detection_mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.intensity_perimeters = imoverlay(mat2gray(handles.intensity_image), bwperim(handles.detection_mask), [0 1 0]);

measurements_intensity = regionprops(handles.detection_mask, handles.intensity_image, 'all');
measurements_lifetime = regionprops(handles.detection_mask, handles.lifetime_image, 'all');

for iteration = 1:size(measurements_intensity)
    measurements_intensity(iteration).MedianIntensity = median(double(measurements_intensity(iteration).PixelValues));
    measurements_lifetime(iteration).MedianIntensity = median(double(measurements_lifetime(iteration).PixelValues));
    measurements_intensity(iteration).StdevIntensity = std(double(measurements_intensity(iteration).PixelValues));
    measurements_lifetime(iteration).StdevIntensity = std(double(measurements_lifetime(iteration).PixelValues));
end

clear iteration

handles.lifetime_perimeters = imoverlay(mat2gray(handles.lifetime_image), bwperim(handles.detection_mask), [0 1 0]);
axes(handles.axes1); cla; imshow(handles.intensity_perimeters);
axes(handles.axes2); cla; imshow(handles.lifetime_perimeters);

% Save the measurements into the handles structures

handles.measurements_intensity = measurements_intensity;
handles.measurements_lifetime = measurements_lifetime;

% Display the green "OK" and the next panel

set(handles.use_detection_mask_ok,'Visible','on');
set(handles.show_mask,'Enable','on');
set(handles.filtering_panel,'Visible','on');

% Update handles structure
guidata(hObject, handles);



%% FILTER / ANALYSIS PANEL

function min_intensity_Callback(hObject, eventdata, handles)
% hObject    handle to min_intensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min_intensity as text
%        str2double(get(hObject,'String')) returns contents of min_intensity as a double

handles.min_intensity = str2double(get(hObject,'String'));

% Update handles structure

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function min_intensity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_intensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function max_intensity_Callback(hObject, eventdata, handles)
% hObject    handle to max_intensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_intensity as text
%        str2double(get(hObject,'String')) returns contents of max_intensity as a double
handles.max_intensity = str2double(get(hObject,'String'));

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function max_intensity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_intensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in apply_min_max_intensity.
function apply_min_max_intensity_Callback(hObject, eventdata, handles)
% hObject    handle to apply_min_max_intensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

indexed_thresholded_values = find([handles.measurements_intensity.MeanIntensity]>=handles.min_intensity & [handles.measurements_intensity.MeanIntensity]<=handles.max_intensity);

handles.measurements_mask_subset = ismember(bwlabel(handles.detection_mask), indexed_thresholded_values);

handles.intensity_perimeters = imoverlay(mat2gray(handles.intensity_image), bwperim(handles.measurements_mask_subset), [0 1 0]);
handles.lifetime_perimeters = imoverlay(mat2gray(handles.lifetime_image), bwperim(handles.measurements_mask_subset), [0 1 0]);

axes(handles.axes1); cla;
imshow(handles.intensity_perimeters);
axes(handles.axes2); cla;
imshow(handles.lifetime_perimeters);

set(handles.lifetime_analysis_mean,'Enable','on');
set(handles.lifetime_analysis_median,'Enable','on');

% Update handles structure
guidata(hObject, handles);

% --- Executes when selected object is changed in analysis_main_switch_panel.
function analysis_main_switch_panel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in analysis_main_switch_panel 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'lifetime_analysis_mean'
        handles.analysis_type = 'mean';
        set(handles.analyse,'Enable','on');

    case 'lifetime_analysis_median'
        handles.analysis_type = 'median';
        set(handles.analyse,'Enable','on');

end

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in analyse.
function analyse_Callback(hObject, eventdata, handles)
% hObject    handle to analyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.measurements_intensity_subset = regionprops(handles.measurements_mask_subset, handles.intensity_image, 'all');
handles.measurements_lifetime_subset = regionprops(handles.measurements_mask_subset, handles.lifetime_image, 'all');
handles.labelled_matrix = labelmatrix(bwconncomp(handles.measurements_mask_subset,8));

colour_coded_image = nan(size(handles.labelled_matrix)); % Pre-allocation for speed

for iteration = 1:size(handles.measurements_intensity_subset,1)
    handles.measurements_intensity_subset(iteration).MedianIntensity = median(double(handles.measurements_intensity_subset(iteration).PixelValues));
    handles.measurements_lifetime_subset(iteration).MedianIntensity = median(double(handles.measurements_lifetime_subset(iteration).PixelValues));
    handles.measurements_intensity_subset(iteration).StdevIntensity = std(double(handles.measurements_intensity_subset(iteration).PixelValues));
    handles.measurements_lifetime_subset(iteration).StdevIntensity = std(double(handles.measurements_lifetime_subset(iteration).PixelValues));
end

switch handles.analysis_type
    case 'mean'
        for k=1:size(handles.measurements_lifetime_subset,1)
            colour_coded_image(handles.labelled_matrix==k) = handles.measurements_lifetime_subset(k).MeanIntensity;
        end
    case 'median'
        for k=1:size(handles.measurements_lifetime_subset,1)
            colour_coded_image(handles.labelled_matrix==k) = handles.measurements_lifetime_subset(k).MedianIntensity;
        end
end

% Plot the colour coded image

axes(handles.axes2); cla;
imshow(colour_coded_image);
caxis([handles.min_lifetime handles.max_lifetime]);
colormap('jet');
pos = get(gca,'position');
colorbar('position',[0.58 0.72 0.01 0.2],'Xcolor',[1 1 1],'Ycolor',[1 1 1]);
set(gca,'position',[pos(1) pos(2) pos(3) pos(4)]);

fontSize = 8; labelShiftX = -10; ids = handles.ids;

if ids==1;
    for k = 1 : size(handles.measurements_intensity_subset)
        ObjectCentroid = handles.measurements_intensity_subset(k).WeightedCentroid;
        text(ObjectCentroid(1) + labelShiftX, ObjectCentroid(2), num2str(k), 'FontSize', fontSize, 'FontWeight', 'Bold', 'Color',[0.9 .9 .9]);
    end    
end

freezeColors

analysis.data_matrix_intensity = nan(size(handles.measurements_intensity_subset)); % Pre-allocation for speed
analysis.data_matrix_lifetime = nan(size(handles.measurements_lifetime_subset)); % Pre-allocation for speed

for iteration = 1:size(handles.measurements_intensity_subset,1)
    analysis.data_matrix_intensity(iteration) = handles.measurements_intensity_subset(iteration).MeanIntensity;
    switch handles.analysis_type
        case 'mean'
            analysis.data_matrix_lifetime(iteration) = handles.measurements_lifetime_subset(iteration).MeanIntensity;
        case 'median'
            analysis.data_matrix_lifetime(iteration) = handles.measurements_lifetime_subset(iteration).MedianIntensity;
    end
end

analysis.average_intensity = mean(analysis.data_matrix_intensity(:));
analysis.average_lifetime = mean(analysis.data_matrix_lifetime(:));
analysis.stdev_intensity = std(analysis.data_matrix_intensity(:));
analysis.stdev_lifetime = std(analysis.data_matrix_lifetime(:));

axes(handles.axes3); cla;
hist(analysis.data_matrix_intensity,handles.bin_number)

% Store stuff in the handles structure

handles.colour_coded_image = colour_coded_image;
handles.analysis = analysis;

% Display the next step

set(handles.save,'Enable','on');
set(handles.scale_panel,'Visible','on');
set(handles.distribution_panel,'Visible','on');
set(handles.background_panel,'Visible','on');
set(handles.profile_panel,'Visible','on');
set(handles.axes3,'Visible','on');
set(handles.text19, 'Enable','on');
set(handles.plot_distribution, 'Enable','on');

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Exporting in CSV files

data_format_main_title = '\r \n %s \r \n \n';
data_format_subtitle = '\r \n %s, \r \n';
data_format_conditions_title = repmat('%s,',1,2);
data_format_conditions_title = data_format_conditions_title(1:end-1);
data_format_conditions_title = strcat(data_format_conditions_title,'\r \n');
data_format_numbers = repmat('%6.4f,',1,1);
data_format_numbers = data_format_numbers(1:end-1);
data_format_numbers = strcat('%3.0f,',data_format_numbers,'\r');
first_column = (1:1:size(handles.analysis.data_matrix_intensity,1))';

handles.analysis.data_matrix_intensity = horzcat(first_column,handles.analysis.data_matrix_intensity);
handles.analysis.data_matrix_lifetime = horzcat(first_column,handles.analysis.data_matrix_lifetime);
clear first_column

cd(handles.results_folder)

timestamp = datestr(now, 'ddmmyyyy_HHMMSS');
name_extension = [handles.default_name  '_' handles.analysis_type '_analysis_' timestamp '.csv'];

file_created = fopen(name_extension,'w');

fprintf(file_created, data_format_main_title, 'Mean intensities of the objects detected in this image');
fclose(file_created);
clear file_created

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_conditions_title, 'Object ID');
fprintf(file_edited, data_format_conditions_title, handles.intensity_image_name);
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, '\r \n');
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_numbers, handles.analysis.data_matrix_intensity');
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_subtitle, 'Mean (of the different objects identified)');
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_conditions_title, ' ');
fprintf(file_edited, '%6.4f,', handles.analysis.average_intensity);
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_subtitle, 'Standard deviation');
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_conditions_title, ' ');
fprintf(file_edited, '%6.4f,', handles.analysis.stdev_intensity);
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
switch handles.analysis_type
    case 'mean'
        fprintf(file_edited, data_format_main_title, 'Mean lifetimes of the objects detected in this image');
    case 'median';
        fprintf(file_edited, data_format_main_title, 'Median lifetimes of the objects detected in this image');
end
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_conditions_title, 'Object ID');
fprintf(file_edited, data_format_conditions_title, handles.lifetime_image_name);
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, '\r \n');
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_numbers, handles.analysis.data_matrix_lifetime');
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_subtitle, 'Mean (of the different objects identified)');
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_conditions_title, ' ');
fprintf(file_edited, '%6.4f,', handles.analysis.average_lifetime);
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_subtitle, 'Standard deviation');
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_conditions_title, ' ');
fprintf(file_edited, '%6.4f,', handles.analysis.stdev_lifetime);
fclose(file_edited);
clear file_edited

cd(handles.current_folder)

% Update handles structure
guidata(hObject, handles);



%% LIFETIME SCALE PANEL

function min_lifetime_Callback(hObject, eventdata, handles)
% hObject    handle to min_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.min_lifetime = str2double(get(hObject,'String'));

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function min_lifetime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function max_lifetime_Callback(hObject, eventdata, handles)
% hObject    handle to max_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.max_lifetime = str2double(get(hObject,'String'));

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function max_lifetime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in display_ids.
function display_ids_Callback(hObject, eventdata, handles)
% hObject    handle to display_ids (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of display_ids
ids = get(hObject,'Value');
handles.ids = ids;

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in save_colour_coded_eps.
function save_colour_coded_eps_Callback(hObject, eventdata, handles)
% hObject    handle to save_colour_coded_eps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h=figure;
set(h,'PaperPositionMode','auto')
imshow(handles.colour_coded_image);
colormap('jet');
colorbar('OuterPosition',[0.1 0.7 0.06 0.25],'Xcolor',[1 1 1],'Ycolor',[1 1 1]); caxis([handles.min_lifetime handles.max_lifetime]);

fontSize = 8; labelShiftX = -10; ids = handles.ids;

if ids==1;
    
    for k = 1 : size(handles.measurements_lifetime_subset)
        ObjectCentroid = handles.measurements_lifetime_subset(k).WeightedCentroid;
        text(ObjectCentroid(1) + labelShiftX, ObjectCentroid(2), num2str(k), 'FontSize', fontSize, 'FontWeight', 'Bold', 'Color',[0.9 .9 .9]);
    end
    
end

freezeColors

cd(handles.results_folder)

timestamp = datestr(now, 'ddmmyyyy_HHMMSS');
name_extension = [handles.default_name  '_' handles.analysis_type '_lifetime_' timestamp];
print (h,'-depsc','-loose',name_extension);

cd(handles.current_folder)

close(h);

% --- Executes on button press in save_colour_coded_tiff.
function save_colour_coded_tiff_Callback(hObject, eventdata, handles)
% hObject    handle to save_colour_coded_tiff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h=figure;
set(h,'PaperPositionMode','auto')
imshow(handles.colour_coded_image);
colormap('jet');
colorbar('OuterPosition',[0.1 0.7 0.06 0.25],'Xcolor',[1 1 1],'Ycolor',[1 1 1]);
caxis([handles.min_lifetime handles.max_lifetime]);

fontSize = 8; labelShiftX = -10; ids = handles.ids;

if ids==1;
    
    for k = 1 : size(handles.measurements_lifetime_subset)
        ObjectCentroid = handles.measurements_lifetime_subset(k).WeightedCentroid;
        text(ObjectCentroid(1) + labelShiftX, ObjectCentroid(2), num2str(k), 'FontSize', fontSize, 'FontWeight', 'Bold', 'Color',[0.9 .9 .9]);
    end
    
end

freezeColors

cd(handles.results_folder)

timestamp = datestr(now, 'ddmmyyyy_HHMMSS');
name_extension = [handles.default_name  '_' handles.analysis_type '_lifetime_' timestamp];
print(h,'-dtiff','-r300',name_extension);

cd(handles.current_folder)

close(h);

% --- Executes on button press in select_montage.
function select_montage_Callback(hObject, eventdata, handles)
% hObject    handle to select_montage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes2);
user_rectangle = imrect;
wait(user_rectangle);
handles.pos_user_rectangle = getPosition(user_rectangle); % [xmin ymin width height]
delete(user_rectangle);

% Unlock the next step

set(handles.save_montage,'Enable','on');

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in save_montage.
function save_montage_Callback(hObject, eventdata, handles)
% hObject    handle to save_montage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cropped_detection_image = imcrop(handles.detection_image, handles.pos_user_rectangle);
cropped_intensity_image = imcrop(handles.intensity_image, handles.pos_user_rectangle);
cropped_lifetime_image = imcrop(handles.lifetime_image, handles.pos_user_rectangle);
cropped_intensity_image_overlay = imcrop(handles.intensity_perimeters, handles.pos_user_rectangle);
cropped_lifetime_image_overlay = imcrop(handles.lifetime_perimeters, handles.pos_user_rectangle);
cropped_lifetime_segmented = imcrop(handles.colour_coded_image, handles.pos_user_rectangle);

h = figure;
set(gcf,'position',get(0,'screensize'),'PaperPositionMode','auto');

subaxis(2,3,1, 'Spacing', 0., 'Padding', 0.03, 'Margin', 0.03);
imshow(cropped_detection_image,[]);
colormap('gray');title('Cropped detection image','FontSize',14,'Color', [0 0 0],'FontWeight','bold','Interpreter','none');
freezeColors

subaxis(2,3,2, 'Spacing', 0., 'Padding', 0.03, 'Margin', 0.03);
imshow(cropped_intensity_image_overlay);
colormap('gray');title('Intensity overlay','FontSize',14,'Color', [0 0 0],'FontWeight','bold','Interpreter','none');
freezeColors

subaxis(2,3,3, 'Spacing', 0., 'Padding', 0.03, 'Margin', 0.03);
imshow(cropped_lifetime_image_overlay);
colormap('gray');title('Lifetime overlay','FontSize',14,'Color', [0 0 0],'FontWeight','bold','Interpreter','none');
freezeColors

subaxis(2,3,4, 'Spacing', 0., 'Padding', 0.03, 'Margin', 0.03);
imshow(cropped_intensity_image,[[handles.min_intensity handles.max_intensity]]);
pos = get(gca,'position');
colormap('jet');title('Cropped intensity image','FontSize',14,'Color', [0 0 0],'FontWeight','bold','Interpreter','none');
colorbar('location','southoutside');
set(gca,'position',[pos(1) pos(2) pos(3) pos(4)]);
freezeColors

subaxis(2,3,5, 'Spacing', 0., 'Padding', 0.03, 'Margin', 0.03);
imshow(cropped_lifetime_image,[handles.min_lifetime handles.max_lifetime]);
pos = get(gca,'position');
colormap('jet');title('Cropped lifetime image','FontSize',14,'Color', [0 0 0],'FontWeight','bold','Interpreter','none');
colorbar('location','southoutside');
set(gca,'position',[pos(1) pos(2) pos(3) pos(4)]);
freezeColors

subaxis(2,3,6, 'Spacing', 0., 'Padding', 0.03, 'Margin', 0.03);
pos = get(gca,'position');
imshow(cropped_lifetime_segmented,[handles.min_lifetime handles.max_lifetime]);
colormap('jet');title('Lifetime of objects','FontSize',14,'Color', [0 0 0],'FontWeight','bold','Interpreter','none'); colorbar('location','southoutside');
set(gca,'position',[pos(1) pos(2) pos(3) pos(4)]);
freezeColors

cd(handles.results_folder)

timestamp = datestr(now, 'ddmmyyyy_HHMMSS');
name_extension = [handles.default_name  '_' handles.analysis_type '_montage_' timestamp];
print(h,'-dtiff','-r300',name_extension);

cd(handles.current_folder)

uiwait();

% Hide again the save montage to avoid the user to change something in the
% analysis and then save another montage without having reprocessed it

set(handles.save_montage,'Enable','off');

% Update handles structure
guidata(hObject, handles);



%% DISTRIBUTION ANALYSIS PANEL

% --- Executes on selection change in distribution_parameter.
function distribution_parameter_Callback(hObject, eventdata, handles)
% hObject    handle to distribution_parameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

distribution_parameter = get(hObject,'Value');
switch distribution_parameter
    case 1
        handles.distribution_parameter = 'intensity';
    case 2
        handles.distribution_parameter = 'intensity';
    case 3
        handles.distribution_parameter = 'lifetime';
end

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function distribution_parameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to distribution_parameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function bin_number_Callback(hObject, eventdata, handles)
% hObject    handle to bin_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.bin_number = str2double(get(hObject,'String'));

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function bin_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bin_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in plot_distribution.
function plot_distribution_Callback(hObject, eventdata, handles)
% hObject    handle to plot_distribution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
switch handles.distribution_parameter
    case 'intensity'
        axes(handles.axes3); cla;
        hist(handles.analysis.data_matrix_intensity,handles.bin_number);
        set(handles.save_distribution,'Enable','on');
    case 'lifetime'
        axes(handles.axes3); cla;
        hist(handles.analysis.data_matrix_lifetime,handles.bin_number);
        set(handles.save_distribution,'Enable','on');
end

% --- Executes on button press in save_distribution.
function save_distribution_Callback(hObject, eventdata, handles)
% hObject    handle to save_distribution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=figure;
set(h,'PaperPositionMode','auto')

switch handles.distribution_parameter
    case 'intensity'
        Xlegend = 'Intensity of objects';
        hist(handles.analysis.data_matrix_intensity,handles.bin_number);
        grid on
        title(['Distribution of ' handles.distribution_parameter 's in ' handles.default_name]);
        xlabel(Xlegend);
        ylabel('Number of objects detected');
        
    case 'lifetime'
        Xlegend = 'Lifetime of objects';
        hist(handles.analysis.data_matrix_lifetime,handles.bin_number);
        grid on
        title(['Distribution of ' handles.distribution_parameter 's in ' handles.default_name]);
        xlabel(Xlegend);
        ylabel('Number of objects detected');
end

cd(handles.results_folder)

timestamp = datestr(now, 'ddmmyyyy_HHMMSS');
name_extension = [handles.default_name  '_' handles.distribution_parameter '_distribution_' timestamp];
print (h,'-depsc','-loose',name_extension);

cd(handles.current_folder)

close(h);


%% BACKGROUND ANALYSIS PANEL

function number_background_Callback(hObject, eventdata, handles)
% hObject    handle to number_background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.number_background = str2double(get(hObject,'String'));

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function number_background_CreateFcn(hObject, eventdata, handles)
% hObject    handle to number_background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in tool_selection_background.
function tool_selection_background_Callback(hObject, eventdata, handles)
% hObject    handle to tool_selection_background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = get(hObject,'Value');

switch selection
    case 1
        handles.background_ROI_tool = 'impoly';
    case 2
        handles.background_ROI_tool = 'impoly';
    case 3
        handles.background_ROI_tool = 'imfreehand';
end

% Activate the next step

set(handles.select_background,'Enable','on');

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function tool_selection_background_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tool_selection_background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in select_background.
function select_background_Callback(hObject, eventdata, handles)
% hObject    handle to select_background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Create the empty matrices to allow storage of initial image, intensity, lifetime, ROIs, etc...

background_analysis_logical_regions = false(size(handles.intensity_image));
background_analysis_image_regions = handles.intensity_image;
background_analysis_image_regions(handles.roi_cell) = 0; % Remove what is outside the initial ROI
background_analysis_image_regions(handles.detection_mask) = 0; % Remove what is considered as the signal

axes(handles.axes2); cla(handles.axes2); set(handles.axes2,'Visible','off');
axes(handles.axes1); cla; imshow(background_analysis_image_regions,[]);
warningtext_1 = text(5,13,'Autoscaled intensity channel','FontSize',12,'Color', [.9 .9 .9]);
warningtext_2 = text(5,27,'Non overlapping areas','FontSize',12,'Color', [1 0 0],'FontWeight','bold');

% Loop to select the x number of areas

for iteration=1:handles.number_background;
    
    roi = eval(handles.background_ROI_tool);
    wait(roi);
    new_mask = createMask(roi);
    background_analysis_logical_regions(new_mask) = true;
    perim_mask = bwperim(background_analysis_logical_regions);
    overlay = imoverlay(mat2gray(background_analysis_image_regions), perim_mask, [0 0 1]);
    imshow(overlay);
    clear roi perim_mask new_mask
    
end

% Save the temporary mask in the handles structure (contains only the
% user-selected ROIs at the moment, the general ROI and the signal are
% removed from it in a later stage (see the use_background_Callback function)

handles.background_analysis_logical_regions = background_analysis_logical_regions;

% Display the green "OK" and activate the next step

set(handles.select_background_ok,'Visible','on');
set(handles.use_background,'Enable','on');

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in use_background.
function use_background_Callback(hObject, eventdata, handles)
% hObject    handle to use_background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Creation of the detailed background mask from ROI + FA mask + user selected background

handles.background_analysis_logical_regions = not(handles.detection_mask) - (handles.roi_cell) - not(handles.background_analysis_logical_regions);
handles.background_analysis_logical_regions(handles.background_analysis_logical_regions==-1)=false;
handles.background_analysis_logical_regions = logical(handles.background_analysis_logical_regions);
handles.background_overlay = imoverlay(mat2gray(handles.intensity_image), bwperim(handles.background_analysis_logical_regions), [0 0 1]);
imshow(handles.background_overlay);

% Use the fancy mask to get regionprops details from the intensity and lifetime images

handles.background_analysis_intensity = regionprops(handles.background_analysis_logical_regions, handles.intensity_image , 'all');
handles.background_analysis_lifetime = regionprops(handles.background_analysis_logical_regions, handles.lifetime_image, 'all');

for iteration = 1:handles.number_background
    
    % Calculate median and stdev for each object and save it as an additional parameter in the regionprops features
    
    handles.background_analysis_intensity(iteration).MedianIntensity = median(double(handles.background_analysis_intensity(iteration).PixelValues));
    handles.background_analysis_lifetime(iteration).MedianIntensity = median(double(handles.background_analysis_lifetime(iteration).PixelValues));
    handles.background_analysis_intensity(iteration).StdevIntensity = std(double(handles.background_analysis_intensity(iteration).PixelValues));
    handles.background_analysis_lifetime(iteration).StdevIntensity = std(double(handles.background_analysis_lifetime(iteration).PixelValues));
    
    % Display of labels for user
    
    text(handles.background_analysis_intensity(iteration).WeightedCentroid(1), handles.background_analysis_intensity(iteration).WeightedCentroid(2), num2str(iteration), 'FontSize', 16, 'FontWeight', 'Bold', 'Color',[.9 .9 .9]);
    
end

% Activate the next step

set(handles.use_background_ok,'Visible','on');
set(handles.lifetime_background_mean,'Enable','on');
set(handles.lifetime_background_median,'Enable','on');

% Update handles structure
guidata(hObject, handles);

% --- Executes when selected object is changed in analysis_background_switch_panel.
function analysis_background_switch_panel_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in analysis_background_switch_panel
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    
    case 'lifetime_background_mean'
        handles.background_analysis_type = 'mean';
        set(handles.analyse_background,'Enable','on');
        
    case 'lifetime_background_median'
        handles.background_analysis_type = 'median';
        set(handles.analyse_background,'Enable','on');
        
end

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in analyse_background.
function analyse_background_Callback(hObject, eventdata, handles)
% hObject    handle to analyse_background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

background_matrix_intensity = zeros(size(handles.number_background)); % Pre-allocation for speed
background_matrix_lifetime = zeros(size(handles.number_background)); % Pre-allocation for speed

for iteration = 1:handles.number_background % Extract mean intensity of intensity channel and mean or median intensity of lifetime channel
    background_matrix_intensity(iteration) = handles.background_analysis_intensity(iteration).MeanIntensity;
    switch handles.background_analysis_type
        case 'mean'
            background_matrix_lifetime(iteration) = handles.background_analysis_lifetime(iteration).MeanIntensity;
        case 'median'
            background_matrix_lifetime(iteration) = handles.background_analysis_lifetime(iteration).MedianIntensity;
    end
end

background_analysis.average_intensity = mean(background_matrix_intensity(:));
background_analysis.average_lifetime = mean(background_matrix_lifetime(:));
background_analysis.stdev_intensity = std(background_matrix_intensity(:));
background_analysis.stdev_lifetime = std(background_matrix_lifetime(:));

data_format_main_title = '\r \n %s \r \n \n';
data_format_subtitle = '\r \n %s, \r \n';
data_format_conditions_title = repmat('%s,',1,2);
data_format_conditions_title = data_format_conditions_title(1:end-1);
data_format_conditions_title = strcat(data_format_conditions_title,'\r \n');
data_format_numbers = repmat('%6.4f,',1,1);
data_format_numbers = data_format_numbers(1:end-1);
data_format_numbers = strcat('%3.0f,',data_format_numbers,'\r');
first_column = (1:1:handles.number_background)';
background_matrix_intensity = horzcat(first_column,background_matrix_intensity.');
background_matrix_lifetime = horzcat(first_column,background_matrix_lifetime.');
clear first_column

cd(handles.results_folder)

timestamp = datestr(now, 'ddmmyyyy_HHMMSS');
name_extension = [handles.default_name  '_' handles.background_analysis_type '_background_' timestamp '.csv'];

file_created = fopen(name_extension,'w');
fprintf(file_created, data_format_main_title, 'Mean intensities of the areas selected in this image');
fclose(file_created);
clear file_created

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_conditions_title, 'Background area ID');
fprintf(file_edited, data_format_conditions_title, handles.intensity_image_name);
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, '\r \n');
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_numbers, background_matrix_intensity');
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_subtitle, 'Mean (of the different areas selected)');
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_conditions_title, ' ');
fprintf(file_edited, '%6.4f,', background_analysis.average_intensity);
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_subtitle, 'Standard deviation');
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_conditions_title, ' ');
fprintf(file_edited, '%6.4f,', background_analysis.stdev_intensity);
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
switch handles.background_analysis_type
    case 'mean'
        fprintf(file_edited, data_format_main_title, 'Mean lifetimes of the areas selected in this image');
    case 'median';
        fprintf(file_edited, data_format_main_title, 'Median lifetimes of the areas selected in this image');
end
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_conditions_title, 'Background area ID');
fprintf(file_edited, data_format_conditions_title, handles.lifetime_image_name);
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, '\r \n');
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_numbers, background_matrix_lifetime');
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_subtitle, 'Mean (of the different areas selected)');
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_conditions_title, ' ');
fprintf(file_edited, '%6.4f,',background_analysis.average_lifetime);
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_subtitle, 'Standard deviation');
fclose(file_edited);
clear file_edited

file_edited = fopen(name_extension,'a');
fprintf(file_edited, data_format_conditions_title, ' ');
fprintf(file_edited, '%6.4f,',background_analysis.stdev_lifetime);
fclose(file_edited);
clear file_edited

cd(handles.current_folder)

set(handles.save_background,'Enable','on');

% Update handles structure
guidata(hObject, handles);

% --- Executes on button press in save_background.
function save_background_Callback(hObject, eventdata, handles)
% hObject    handle to save_background (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h=figure;
set(h,'PaperPositionMode','auto')

imshow(handles.background_overlay);

for iteration = 1:handles.number_background
    text(handles.background_analysis_intensity(iteration).WeightedCentroid(1), handles.background_analysis_intensity(iteration).WeightedCentroid(2), num2str(iteration), 'FontSize', 10, 'FontWeight', 'Bold', 'Color',[.9 .9 .9]);
end

cd(handles.results_folder)

timestamp = datestr(now, 'ddmmyyyy_HHMMSS');
name_extension = [handles.default_name  '_' handles.background_analysis_type '_background_' timestamp];
print(h,'-dtiff','-r300',name_extension);

cd(handles.current_folder)

close(h);



%% LINE PROFILE PANEL

% --- Executes on button press in line_selection.
function line_selection_Callback(hObject, eventdata, handles)
% hObject    handle to line_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in erase_line.
function erase_line_Callback(hObject, eventdata, handles)
% hObject    handle to erase_line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in save_profile_image_eps.
function save_profile_image_eps_Callback(hObject, eventdata, handles)
% hObject    handle to save_profile_image_eps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in save_profile_image_tif.
function save_profile_image_tif_Callback(hObject, eventdata, handles)
% hObject    handle to save_profile_image_tif (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in save_profile_data_csv.
function save_profile_data_csv_Callback(hObject, eventdata, handles)
% hObject    handle to save_profile_data_csv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in save_profile_graph_eps.
function save_profile_graph_eps_Callback(hObject, eventdata, handles)
% hObject    handle to save_profile_graph_eps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in checkbox_profile_intensity.
function checkbox_profile_intensity_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_profile_intensity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_profile_intensity

% --- Executes on button press in checkbox_profile_lifetime.
function checkbox_profile_lifetime_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_profile_lifetime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_profile_lifetime



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
