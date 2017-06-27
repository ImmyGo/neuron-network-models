function varargout = Neurons1to4Plot(varargin)
% NEURONS1TO4PLOT MATLAB code for Neurons1to4Plot.fig
%      NEURONS1TO4PLOT, by itself, creates a new NEURONS1TO4PLOT or raises the existing
%      singleton*.
%
%      H = NEURONS1TO4PLOT returns the handle to a new NEURONS1TO4PLOT or the handle to
%      the existing singleton*.
%
%      NEURONS1TO4PLOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEURONS1TO4PLOT.M with the given input arguments.
%
%      NEURONS1TO4PLOT('Property','Value',...) creates a new NEURONS1TO4PLOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Neurons1to4Plot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Neurons1to4Plot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Neurons1to4Plot

% Last Modified by GUIDE v2.5 04-Mar-2016 14:36:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Neurons1to4Plot_OpeningFcn, ...
                   'gui_OutputFcn',  @Neurons1to4Plot_OutputFcn, ...
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


% --- Executes just before Neurons1to4Plot is made visible.
function Neurons1to4Plot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Neurons1to4Plot (see VARARGIN)

% Choose default command line output for Neurons1to4Plot
handles.output = hObject;
handles.time = getappdata(0, 'time');
handles.system = getappdata(0, 'system');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Neurons1to4Plot wait for user response (see UIRESUME)
% uiwait(handles.figure1);
createPlot(handles.time, handles.system, handles);


% --- Outputs from this function are returned to the command line.
function varargout = Neurons1to4Plot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% Create plot of first four neurons in network
function createPlot(time, system, handles)

axes(handles.neuron1);
plot(time, system(1, :), 'r');
title(['Neuron Number 1']);
ylabel('Voltage / mV') % x-axis label
xlabel('Time / ms') % y-axis label

axes(handles.neuron2);
plot(time, system(2, :), 'k');
title(['Neuron Number 2']);
ylabel('Voltage / mV') % x-axis label
xlabel('Time / ms') % y-axis label

axes(handles.neuron3);
plot(time, system(3, :), 'b');
title(['Neuron Number 3']);
ylabel('Voltage / mV') % x-axis label
xlabel('Time / ms') % y-axis label

axes(handles.neuron4);
plot(time, system(4, :), 'm');
title(['Neuron Number 4']);
ylabel('Voltage / mV') % x-axis label
xlabel('Time / ms') % y-axis label
