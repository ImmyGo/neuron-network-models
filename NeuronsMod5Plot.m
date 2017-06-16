function varargout = NeuronsMod5Plot(varargin)
% NEURONSMOD5PLOT MATLAB code for NeuronsMod5Plot.fig
%      NEURONSMOD5PLOT, by itself, creates a new NEURONSMOD5PLOT or raises the existing
%      singleton*.
%
%      H = NEURONSMOD5PLOT returns the handle to a new NEURONSMOD5PLOT or the handle to
%      the existing singleton*.
%
%      NEURONSMOD5PLOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEURONSMOD5PLOT.M with the given input arguments.
%
%      NEURONSMOD5PLOT('Property','Value',...) creates a new NEURONSMOD5PLOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NeuronsMod5Plot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NeuronsMod5Plot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NeuronsMod5Plot

% Last Modified by GUIDE v2.5 14-Mar-2016 13:15:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NeuronsMod5Plot_OpeningFcn, ...
                   'gui_OutputFcn',  @NeuronsMod5Plot_OutputFcn, ...
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


% --- Executes just before NeuronsMod5Plot is made visible.
function NeuronsMod5Plot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NeuronsMod5Plot (see VARARGIN)

% Choose default command line output for NeuronsMod5Plot
handles.output = hObject;
handles.time = getappdata(0, 'time');
handles.system = getappdata(0, 'system');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NeuronsMod5Plot wait for user response (see UIRESUME)
% uiwait(handles.figure1);

createPlot(handles.time, handles.system, handles);



% --- Outputs from this function are returned to the command line.
function varargout = NeuronsMod5Plot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% Create plot of every 5th neuron in network (up to 20)
function createPlot(time, system, handles)

axes(handles.neuron5);
plot(time, system(5, :), 'r');
title(['Neuron Number 5']);
ylabel('Voltage / mV') % x-axis label
xlabel('Time / ms') % y-axis label

axes(handles.neuron10);
plot(time, system(10, :), 'k');
title(['Neuron Number 10']);
ylabel('Voltage / mV') % x-axis label
xlabel('Time / ms') % y-axis label

axes(handles.neuron15);
plot(time, system(15, :), 'b');
title(['Neuron Number 15']);
ylabel('Voltage / mV') % x-axis label
xlabel('Time / ms') % y-axis label

axes(handles.neuron20);
plot(time, system(20, :), 'm');
title(['Neuron Number 20']);
ylabel('Voltage / mV') % x-axis label
xlabel('Time / ms') % y-axis label
