function varargout = SingleNeuronPlot(varargin)
% SINGLENEURONPLOT MATLAB code for SingleNeuronPlot.fig
%      SINGLENEURONPLOT, by itself, creates a new SINGLENEURONPLOT or raises the existing
%      singleton*.
%
%      H = SINGLENEURONPLOT returns the handle to a new SINGLENEURONPLOT or the handle to
%      the existing singleton*.
%
%      SINGLENEURONPLOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SINGLENEURONPLOT.M with the given input arguments.
%
%      SINGLENEURONPLOT('Property','Value',...) creates a new SINGLENEURONPLOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SingleNeuronPlot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SingleNeuronPlot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SingleNeuronPlot

% Last Modified by GUIDE v2.5 03-Mar-2016 13:57:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SingleNeuronPlot_OpeningFcn, ...
                   'gui_OutputFcn',  @SingleNeuronPlot_OutputFcn, ...
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


% --- Executes just before SingleNeuronPlot is made visible.
function SingleNeuronPlot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SingleNeuronPlot (see VARARGIN)

% Choose default command line output for SingleNeuronPlot
handles.output = hObject;

handles.vsingle = getappdata(0, 'vsingle');
handles.tsingle = getappdata(0, 'tsingle');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SingleNeuronPlot wait for user response (see UIRESUME)
% uiwait(handles.figure1);
createPlot(handles.vsingle, handles.tsingle, handles);


% --- Outputs from this function are returned to the command line.
function varargout = SingleNeuronPlot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function createPlot(vsingle, tsingle, handles)
% plot
axes(handles.oneneuron);
plot(vsingle, tsingle);

ylabel('Voltage / mV') % x-axis label
xlabel('Time / ms') % y-axis label
title(['Single Neuron behaviour as configured (without any network connection)']);
