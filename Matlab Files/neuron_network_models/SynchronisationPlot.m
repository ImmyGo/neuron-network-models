function varargout = SynchronisationPlot(varargin)
% SYNCHRONISATIONPLOT MATLAB code for SynchronisationPlot.fig
%      SYNCHRONISATIONPLOT, by itself, creates a new SYNCHRONISATIONPLOT or raises the existing
%      singleton*.
%
%      H = SYNCHRONISATIONPLOT returns the handle to a new SYNCHRONISATIONPLOT or the handle to
%      the existing singleton*.
%
%      SYNCHRONISATIONPLOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SYNCHRONISATIONPLOT.M with the given input arguments.
%
%      SYNCHRONISATIONPLOT('Property','Value',...) creates a new SYNCHRONISATIONPLOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SynchronisationPlot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SynchronisationPlot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SynchronisationPlot

% Last Modified by GUIDE v2.5 10-Mar-2016 10:40:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SynchronisationPlot_OpeningFcn, ...
                   'gui_OutputFcn',  @SynchronisationPlot_OutputFcn, ...
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


% --- Executes just before SynchronisationPlot is made visible.
function SynchronisationPlot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SynchronisationPlot (see VARARGIN)

% Choose default command line output for SynchronisationPlot
handles.output = hObject;
%handles.time = getappdata(0, 'time');
system = getappdata(0,'system');
time = getappdata(0,'time');
[syncresult] = Synchronisation(system);
setappdata(0, 'syncresult', syncresult);

% Update handles structure
guidata(hObject, handles);

createPlot(syncresult, time, handles);
levelofsync_CreateFcn(hObject, syncresult, handles)


% Plot result from synchronisation function
% --- Outputs from this function are returned to the command line.
function varargout = SynchronisationPlot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function createPlot(result, time, handles)
% plot
axes(handles.synchronisation);
plot(time, result(1,:));

ylabel('Avg difference between potential of any two neurons in network') % x-axis label
xlabel('Time / ms') % y-axis label
title(['Level Of Synchronisation']);


% Levelofsync represents lim t-> inf ||xi(t) - xj(t)||
% infinity here is the last but one timestep in simulation
function levelofsync_CreateFcn(hObject, result, handles)
% hObject    handle to levelofsync (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% take last element of result vector to be the syncronisation value
if isempty(result)
    return
end
% Take last but one timestep
sync = result(end-1);
set(handles.levelofsync, 'String', num2str(sync,'%.8f'));
guidata(hObject, handles);
