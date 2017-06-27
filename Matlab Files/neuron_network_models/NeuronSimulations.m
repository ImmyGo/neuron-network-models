function varargout = NeuronSimulations(varargin)
% NEURONSIMULATIONS MATLAB code for NeuronSimulations.fig
%      NEURONSIMULATIONS, by itself, creates a new NEURONSIMULATIONS or raises the existing
%      singleton*.
%
%      H = NEURONSIMULATIONS returns the handle to a new NEURONSIMULATIONS or the handle to
%      the existing singleton*.
%
%      NEURONSIMULATIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEURONSIMULATIONS.M with the given input arguments.
%
%      NEURONSIMULATIONS('Property','Value',...) creates a new NEURONSIMULATIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NeuronSimulations_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NeuronSimulations_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NeuronSimulations

% Last Modified by GUIDE v2.5 14-Mar-2016 18:31:42


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GUI INITIALISATION SECION
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NeuronSimulations_OpeningFcn, ...
                   'gui_OutputFcn',  @NeuronSimulations_OutputFcn, ...
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


% --- Executes just before NeuronSimulations is made visible.
function NeuronSimulations_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NeuronSimulations (see VARARGIN)
% Choose default command line output for NeuronSimulations
handles.output = hObject;

% Set initial values for handles
handles.izhikModel = 1;
handles.tauModel = 0;
handles.exponModel = 0;
handles.couplingOne = 1;
handles.couplingTwo = 0;
handles.couplingThree = 0;
handles.couplingFour = 0;
handles.excitNeurons = 30;
handles.inhibiNeurons = 20;
handles.resetPotential = -65;
handles.ureset = 8;
handles.spikeThreshold = 30;
handles.izhikA = 0.02;
handles.izhikB = 0.2;
handles.currentIn = 14;
handles.simulaTime = 100;
handles.simulaStep = 0.1;
handles.memTimeConstant = 58;
handles.memTimeInhibi = 15;
handles.coupling = 1.0;
handles.timeone = 0;
handles.timetwo = handles.simulaTime;
handles.synapticPlasticity = 0;

% Parameters = to be fed to neuron network model
handles.parameters = [handles.excitNeurons, handles.inhibiNeurons, ...
                      handles.resetPotential, handles.ureset, handles.spikeThreshold, ...
                      handles.izhikA, handles.izhikB, handles.currentIn, ...
                      handles.simulaTime, handles.simulaStep, handles.memTimeConstant, ...
                      handles.memTimeInhibi, handles.coupling, ...
                      handles.timeone, handles.timetwo];
handles.textBoxes = [handles.excitatory, handles.inhibitory,  handles.reset_potential, ...
                     handles.u_reset, handles.threshold, handles.izhik_a, ...
                     handles.izhik_b, handles.injected_current, handles.simul_time, ...
                     handles.simul_step, handles.mem_time_constant, ...
                     handles.time_constant_inhib, ...
                     handles.coupling_strength, handles.time_one, handles.time_two];

handles.membraneCapacitance = 281;
handles.leakConductance = 30;
handles.leakReversal = -70.6; 
handles.spikeThresholdExp = -50.4;
handles.slopeFactor = 2;
handles.adapTimeConstant = 144;
handles.spikeAdaptation = 80.5;
handles.subthreshAdaptation = 4;

% Separate parameter list for exponential model
handles.ExpInFparameters = [handles.excitNeurons, handles.inhibiNeurons, ...
                            handles.simulaTime, handles.simulaStep, ...
                            handles.membraneCapacitance, handles.leakConductance, ...
                            handles.leakReversal, handles.spikeThresholdExp, ...
                            handles.slopeFactor, handles.adapTimeConstant, ...
                            handles.spikeAdaptation, handles.subthreshAdaptation, ...
                            handles.coupling];
handles.ExpInFtextBoxes = [handles.excitatory, handles.inhibitory, handles.simul_time, ...
                           handles.simul_step, handles.membrane_capacitance, ...
                           handles.leak_conductance, handles.leak_reversal, ...
                           handles.spike_threshold_exp, handles.slope_factor, ...
                           handles.adap_time_const, handles.spike_adaptation, ...
                           handles.subthresh_adaptation, ...
                           handles.coupling_strength];

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NeuronSimulations wait for user response (see UIRESUME)
% uiwait(handles.NeuronSimulations);


% --- Outputs from this function are returned to the command line.
function varargout = NeuronSimulations_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function NeuronSimulations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NeuronSimulations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GUI RADIO BUTTONS
% --- Executes on button press in synaptic_plasticity.
function synaptic_plasticity_Callback(hObject, eventdata, handles)
% hObject    handle to synaptic_plasticity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of synaptic_plasticity
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.synapticPlasticity = 1;
else
	handles.synapticPlasticity = 0; 
end
guidata(gcbo,handles);

% --- Radio Button For Selection of Neuron Model
% --- Executes on button press in izhikevich_model.
function izhikevich_model_Callback(hObject, eventdata, handles)
% hObject    handle to izhikevich_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of izhikevich_model
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.izhikModel = 1;
    handles.exponModel = 0;
    handles.tauModel = 0;
end
guidata(gcbo,handles);

% --- Executes during object creation, after setting all properties.
function izhikevich_model_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coupling_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));

% --- Executes on button press in tau_model.
function tau_model_Callback(hObject, eventdata, handles)
% hObject    handle to tau_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tau_model
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.tauModel = 1;
	handles.izhikModel = 0;
	handles.exponModel = 0;
end
guidata(gcbo,handles);

% --- Executes during object creation, after setting all properties.
function tau_model_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coupling_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));

% --- Executes on button press in exponential_model.
function exponential_model_Callback(hObject, eventdata, handles)
% hObject    handle to exponential_model (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of exponential_model
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.exponModel = 1;
	handles.izhikModel = 0;
	handles.tauModel = 0;
end
guidata(gcbo,handles);

% --- Executes during object creation, after setting all properties.
function exponential_model_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coupling_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));


% --- Radio Button For Selection of Netowrk Coupling
% --- Executes on button press in coupling_one.
function coupling_one_Callback(hObject, eventdata, handles)
% hObject    handle to coupling_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of coupling_one
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.couplingOne = 1;
	handles.couplingTwo = 0;
	handles.couplingThree = 0;
	handles.couplingFour = 0;
end
guidata(gcbo,handles);

% --- Executes during object creation, after setting all properties.
function coupling_one_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coupling_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));

% --- Executes on button press in coupling_two.
function coupling_two_Callback(hObject, eventdata, handles)
% hObject    handle to coupling_two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of coupling_two
% Hint: get(hObject,'Value') returns toggle state of coupling_one
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.couplingOne = 0;
	handles.couplingTwo = 1;
	handles.couplingThree = 0;
	handles.couplingFour = 0;
end
guidata(gcbo,handles);

% --- Executes during object creation, after setting all properties.
function coupling_two_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coupling_two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));

% --- Executes on button press in coupling_three.
function coupling_three_Callback(hObject, eventdata, handles)
% hObject    handle to coupling_three (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of coupling_three
% Hint: get(hObject,'Value') returns toggle state of coupling_one
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.couplingOne = 0;
	handles.couplingTwo = 0;
	handles.couplingThree = 1;
	handles.couplingFour = 0;
end
guidata(gcbo,handles);

% --- Executes during object creation, after setting all properties.
function coupling_three_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coupling_three (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));

% --- Executes on button press in coupling_four.
function coupling_four_Callback(hObject, eventdata, handles)
% hObject    handle to coupling_four (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of coupling_four
% --- Executes during object creation, after setting all properties.
if (get(hObject,'Value') == get(hObject,'Max'))
	handles.couplingOne = 0;
	handles.couplingTwo = 0;
	handles.couplingThree = 0;
	handles.couplingFour = 1;
end
guidata(gcbo,handles);

function coupling_four_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coupling_three (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- All text input parameters:
function excitatory_Callback(hObject, eventdata, handles)
% hObject    handle to excitatory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of excitatory as text
%        str2double(get(hObject,'String')) returns contents of excitatory as a double
val = get(hObject, 'String');
if (all(ismember(val, '0123456789+-.eEdD')))
    excitNeurons = str2double(get(hObject,'String'));
    handles.excitNeurons = excitNeurons;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Excitatory Neurons');
end

% --- Executes during object creation, after setting all properties.
function excitatory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to excitatory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function inhibitory_Callback(hObject, eventdata, handles)
% hObject    handle to inhibitory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inhibitory as text
%        str2double(get(hObject,'String')) returns contents of inhibitory as a double
val = get(hObject, 'String');
if (all(ismember(val, '0123456789+-.eEdD')))
    inhibiNeurons = str2double(get(hObject,'String'));
    handles.inhibiNeurons = inhibiNeurons;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Inhibitory Neurons');
end

% --- Executes during object creation, after setting all properties.
function inhibitory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inhibitory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function reset_potential_Callback(hObject, eventdata, handles)
% hObject    handle to reset_potential (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of reset_potential as text
%        str2double(get(hObject,'String')) returns contents of reset_potential as a double
val = get (hObject, 'String');
if  (all(ismember(val, '0123456789+-.eEdD')))
    resetPotential = str2double(get(hObject,'String'));
    handles.resetPotential = resetPotential;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Reset Potential');
end

% --- Executes during object creation, after setting all properties.
function reset_potential_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reset_potential (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function u_reset_Callback(hObject, eventdata, handles)
% hObject    handle to u_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of u_reset as text
%        str2double(get(hObject,'String')) returns contents of u_reset as a double
val = get (hObject, 'String');
if  (all(ismember(val, '0123456789+-.eEdD')))
    ureset = str2double(get(hObject,'String'));
    handles.ureset = ureset;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Reset Potential');
end

% --- Executes during object creation, after setting all properties.
function u_reset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to u_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function threshold_Callback(hObject, eventdata, handles)
% hObject    handle to threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of threshold as text
%        str2double(get(hObject,'String')) returns contents of threshold as a double
val = get (hObject, 'String');
if  (all(ismember(val, '0123456789+-.eEdD')))
    spikeThreshold = str2double(get(hObject,'String'));
    handles.spikeThreshold = spikeThreshold;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Spike Threshold');
end

% --- Executes during object creation, after setting all properties.
function threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function izhik_a_Callback(hObject, eventdata, handles)
% hObject    handle to izhik_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of izhik_a as text
%        str2double(get(hObject,'String')) returns contents of izhik_a as a double
val = get (hObject, 'String');
if  (all(ismember(val, '0123456789+-.eEdD')))
    izhikA = str2double(get(hObject,'String'));
    handles.izhikA = izhikA;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: izhikevich a');
end

% --- Executes during object creation, after setting all properties.
function izhik_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to izhik_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function izhik_b_Callback(hObject, eventdata, handles)
% hObject    handle to izhik_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of izhik_b as text
%        str2double(get(hObject,'String')) returns contents of izhik_b as a double
val = get (hObject, 'String');
if  (all(ismember(val, '0123456789+-.eEdD')))
    izhikB = str2double(get(hObject,'String'));
    handles.izhikB = izhikB;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: izhikevich b');
end

% --- Executes during object creation, after setting all properties.
function izhik_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to izhik_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% % Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function injected_current_Callback(hObject, eventdata, handles)
% hObject    handle to injected_current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of injected_current as text
%        str2double(get(hObject,'String')) returns contents of injected_current as a double
val = get (hObject, 'String');
if  (all(ismember(val, '0123456789+-.eEdD')))
    currentIn = str2double(get(hObject,'String'));
    handles.currentIn = currentIn;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Injected Current');
end

% --- Executes during object creation, after setting all properties.
function injected_current_CreateFcn(hObject, eventdata, handles)
% hObject    handle to injected_current (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function simul_time_Callback(hObject, ~, handles)
% hObject    handle to simul_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of simul_time as text
%        str2double(get(hObject,'String')) returns contents of simul_time as a double
val = get (hObject, 'String');
if  (all(ismember(val, '0123456789+-.eEdD')))
    simulaTime = str2double(get(hObject,'String'));
    handles.simulaTime = simulaTime;
    handles.timeTwo = simulaTime;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Simulation Time');
end

% --- Executes during object creation, after setting all properties.
function simul_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to simul_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function simul_step_Callback(hObject, eventdata, handles)
% hObject    handle to simul_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of simul_step as text
%        str2double(get(hObject,'String')) returns contents of simul_step as a double
val = get (hObject, 'String');
if  (all(ismember(val, '0123456789+-.eEdD')))
    simulaStep = str2double(get(hObject,'String'));
    handles.simulaStep = simulaStep;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Simulation Step');
end

% --- Executes during object creation, after setting all properties.
function simul_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to simul_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function mem_time_constant_Callback(hObject, eventdata, handles)
% hObject    handle to mem_time_constant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mem_time_constant as text
%        str2double(get(hObject,'String')) returns contents of mem_time_constant as a double
val = get (hObject, 'String');
if  (all(ismember(val, '0123456789+-.eEdD')))
    memTimeConstant = str2double(get(hObject,'String'));
    handles.memTimeConstant = memTimeConstant;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Time Constant');
end

% --- Executes during object creation, after setting all properties.
function mem_time_constant_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mem_time_constant (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function time_constant_inhib_Callback(hObject, eventdata, handles)
% hObject    handle to time_constant_inhib (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_constant_inhib as text
%        str2double(get(hObject,'String')) returns contents of time_constant_inhib as a double
val = get (hObject, 'String');
if  (all(ismember(val, '0123456789+-.eEdD')))
    memTimeInhibi = str2double(get(hObject,'String'));
    handles.memTimeInhibi = memTimeInhibi;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Time Constant Inhib');
end

% --- Executes during object creation, after setting all properties.
function time_constant_inhib_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_constant_inhib (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function coupling_strength_Callback(hObject, eventdata, handles)
% hObject    handle to coupling_strength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of coupling_strength as text
%        str2double(get(hObject,'String')) returns contents of coupling_strength as a double
val = get(hObject, 'String');
if (all(ismember(val, '0123456789+-.eEdD')))
    coupling = str2double(get(hObject,'String'));
    handles.coupling = coupling;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Connection Probability');
end

% --- Executes during object creation, after setting all properties.
function coupling_strength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coupling_strength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function time_one_Callback(hObject, eventdata, handles)
% hObject    handle to time_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_one as text
%        str2double(get(hObject,'String')) returns contents of time_one as a double
val = get(hObject, 'String');
if (all(ismember(val, '0123456789+-.eEdD')))
    timeone = str2double(get(hObject,'String'));
    handles.timeone = timeone;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Connection Probability');
end

% --- Executes during object creation, after setting all properties.
function time_one_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function time_two_Callback(hObject, eventdata, handles)
% hObject    handle to time_two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of time_two as text
%        str2double(get(hObject,'String')) returns contents of time_two as a double
val = get(hObject, 'String');
if (all(ismember(val, '0123456789+-.eEdD')))
    timetwo = str2double(get(hObject,'String'));
    handles.timetwo = timetwo;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Connection Probability');
end

% --- Executes during object creation, after setting all properties.
function time_two_CreateFcn(hObject, eventdata, handles)
% hObject    handle to time_two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function membrane_capacitance_Callback(hObject, eventdata, handles)
% hObject    handle to membrane_capacitance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of membrane_capacitance as text
%        str2double(get(hObject,'String')) returns contents of membrane_capacitance as a double
val = get(hObject, 'String');
if (all(ismember(val, '0123456789+-.eEdD')))
    membraneCapacitance = str2double(get(hObject,'String'));
    handles.membraneCapacitance = membraneCapacitance;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Connection Probability');
end

% --- Executes during object creation, after setting all properties.
function membrane_capacitance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to membrane_capacitance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function leak_conductance_Callback(hObject, eventdata, handles)
% hObject    handle to leak_conductance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of leak_conductance as text
%        str2double(get(hObject,'String')) returns contents of leak_conductance as a double
val = get(hObject, 'String');
if (all(ismember(val, '0123456789+-.eEdD')))
    leakConductance = str2double(get(hObject,'String'));
    handles.leakConductance = leakConductance;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Connection Probability');
end

% --- Executes during object creation, after setting all properties.
function leak_conductance_CreateFcn(hObject, eventdata, handles)
% hObject    handle to leak_conductance (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function leak_reversal_Callback(hObject, eventdata, handles)
% hObject    handle to leak_reversal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of leak_reversal as text
%        str2double(get(hObject,'String')) returns contents of leak_reversal as a double
val = get(hObject, 'String');
if (all(ismember(val, '0123456789+-.eEdD')))
    leakReversal = str2double(get(hObject,'String'));
    handles.leakReversal = leakReversal;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Connection Probability');
end

% --- Executes during object creation, after setting all properties.
function leak_reversal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to leak_reversal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function spike_threshold_exp_Callback(hObject, eventdata, handles)
% hObject    handle to spike_threshold_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of spike_threshold_exp as text
%        str2double(get(hObject,'String')) returns contents of spike_threshold_exp as a double
val = get(hObject, 'String');
if (all(ismember(val, '0123456789+-.eEdD')))
    spikeThresholdExp = str2double(get(hObject,'String'));
    handles.spikeThresholdExp = spikeThresholdExp;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Connection Probability');
end

% --- Executes during object creation, after setting all properties.
function spike_threshold_exp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to spike_threshold_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function slope_factor_Callback(hObject, eventdata, handles)
% hObject    handle to slope_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of slope_factor as text
%        str2double(get(hObject,'String')) returns contents of slope_factor as a double
val = get(hObject, 'String');
if (all(ismember(val, '0123456789+-.eEdD')))
    slopeFactor = str2double(get(hObject,'String'));
    handles.slopeFactor = slopeFactor;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Connection Probability');
end

% --- Executes during object creation, after setting all properties.
function slope_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slope_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function adap_time_const_Callback(hObject, eventdata, handles)
% hObject    handle to adap_time_const (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of adap_time_const as text
%        str2double(get(hObject,'String')) returns contents of adap_time_const as a double
val = get(hObject, 'String');
if (all(ismember(val, '0123456789+-.eEdD')))
    adapTimeConstant = str2double(get(hObject,'String'));
    handles.adapTimeConstant = adapTimeConstant;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Connection Probability');
end

% --- Executes during object creation, after setting all properties.
function adap_time_const_CreateFcn(hObject, eventdata, handles)
% hObject    handle to adap_time_const (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function spike_adaptation_Callback(hObject, eventdata, handles)
% hObject    handle to spike_adaptation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of spike_adaptation as text
%        str2double(get(hObject,'String')) returns contents of spike_adaptation as a double
val = get(hObject, 'String');
if (all(ismember(val, '0123456789+-.eEdD')))
    spikeAdaptation = str2double(get(hObject,'String'));
    handles.spikeAdaptation = spikeAdaptation;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Connection Probability');
end

% --- Executes during object creation, after setting all properties.
function spike_adaptation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to spike_adaptation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function subthresh_adaptation_Callback(hObject, eventdata, handles)
% hObject    handle to subthresh_adaptation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subthresh_adaptation as text
%        str2double(get(hObject,'String')) returns contents of subthresh_adaptation as a double
val = get(hObject, 'String');
if (all(ismember(val, '0123456789+-.eEdD')))
    subthreshAdaptation = str2double(get(hObject,'String'));
    handles.subthreshAdaptation = subthreshAdaptation;
    guidata(gcbo,handles);
else
    errordlg('Invalid Parameter: Connection Probability');
end

% --- Executes during object creation, after setting all properties.
function subthresh_adaptation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subthresh_adaptation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT CHECK
% Check text inputs are valid
function checkPass = checkValues(handles)
checkPass = 1;
for x = handles.textBoxes
    val = get(x, 'String');
    if ~(all(ismember(val, '0123456789+-.eEdD')))
        checkPass = 0;
        break
    end
end
for x = handles.ExpInFtextBoxes
    val = get(x, 'String');
    if ~(all(ismember(val, '0123456789+-.eEdD')))
        checkPass = 0;
        break
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOTS AND NETWORK GRAPHS
% --- Create the GUI plots

% Main neuron network plot
function allneurons_Create(hObject, eventdata, handles)
% hObject    handle to allneurons (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate allneurons
textValues = [];
for x = handles.textBoxes
    textValues = [textValues, str2double(get(x, 'String'))];
end
% Create coupling matrix Acoup
n_neurons = handles.excitNeurons + handles.inhibiNeurons;
if handles.couplingOne
	type = 1;
elseif handles.couplingTwo
    type = 2;
elseif handles.couplingThree
    type = 3;
elseif handles.couplingFour
    type = 4;
else
    return
end
[Acoup] = NetworkCoupling(n_neurons, type);
neurons_to_display = randi([1, n_neurons], 4, 1);
%display(neurons_to_display);
axes(handles.allneurons);
if handles.synapticPlasticity
	[time, system, neuronarray] = NeuronNetworkInFwithPlasticity(textValues, Acoup, neurons_to_display);   
elseif handles.izhikModel
    %Here we call our neuron network
	[time, system, neuronarray] = NeuronNetworkInF(textValues, Acoup, neurons_to_display);
elseif handles.tauModel
    [time, system, neuronarray] = NeuronNetworkTau(textValues, Acoup, neurons_to_display);
elseif handles.exponModel
    ExpInFtextValues = [];
    for x = handles.ExpInFtextBoxes
        ExpInFtextValues = [ExpInFtextValues, str2double(get(x, 'String'))];
    end
    [time, system, neuronarray] = NeuronNetworkExp(ExpInFtextValues, Acoup, neurons_to_display);
else
	return
end

setappdata(0, 'time', time);
setappdata(0, 'system', system);
setappdata(0, 'neurons_to_display', neurons_to_display);
setappdata(0, 'Acoup', Acoup);
allneuronstimeperiod_Create(handles, time, system, neurons_to_display);
networktopology_Create(hObject, eventdata, handles, Acoup);

Neurons1to4Plot;
if n_neurons >= 20
	NeuronsMod5Plot;
end

% --- All neurons graph, but for specific time interval specified by time1, time2
function allneuronstimeperiod_Create(handles, time, system, neurons_to_display)
% hObject    handle to allneuronstimeperiod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Plot
axes(handles.allneuronstimeperiod);
plot(time, system(neurons_to_display(1), :), 'r');
hold on;
plot(time, system(neurons_to_display(2), :), 'k');
hold on;
plot(time, system(neurons_to_display(3), :), 'b');
hold on;
plot(time, system(neurons_to_display(4), :), 'm');
title(['Neurons in Network: Neuron no ', num2str(neurons_to_display(1)), ' = Red, ' ...
       'Neuron no ', num2str(neurons_to_display(2)), ' = Black, ' ...
       'Neuron no ', num2str(neurons_to_display(3)), ' = Blue, ' ...
       'Neuron no ', num2str(neurons_to_display(4)), ' = Pink']);
xlim([handles.timeone, handles.timetwo])
ylabel('Voltage / mV') % x-axis label
xlabel('Time / ms') % y-axis label

% --- Create Picture of Network Topology
function networktopology_Create(hObject, eventdata, handles, Acoup)
% hObject    handle to networktopology (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

n_neurons = handles.excitNeurons + handles.inhibiNeurons;
coords = rand(n_neurons, 2);

xCentre = 0;
yCentre = 0;
theta = 0;
radius = 100;

for xy = 1:n_neurons
	theta = theta + (2*pi/n_neurons);
    coords(xy,1) = radius*cos(theta)+xCentre;
    coords(xy,2) = radius*sin(theta)+yCentre;
end
axes(handles.networktopology);
gplot(Acoup, coords);
axis square

% --- Plot configuration for single neuron, no network connection
function oneneuron_Create(hObject, eventdata, handles)
% hObject    handle to oneneuron (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate allneurons
textValues = [];
for x = handles.textBoxes
    textValues = [textValues, str2double(get(x, 'String'))];
end
if handles.izhikModel
    %Here we call our neuron network
    [tsingle, vsingle] = SingleNeuronInF(textValues);
elseif handles.tauModel
    [tsingle, vsingle] = SingleNeuronTau(textValues);
elseif handles.exponModel
    ExpInFtextValues = [];
    for x = handles.ExpInFtextBoxes
        ExpInFtextValues = [ExpInFtextValues, str2double(get(x, 'String'))];
    end
    [tsingle, vsingle] = SingleNeuronExp(ExpInFtextValues);
else
    return
end
setappdata(0, 'tsingle', tsingle);
setappdata(0, 'vsingle', vsingle);
SingleNeuronPlot;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GUI BUTTONS
% --- Executes on button press in submit.
function submit_Callback(hObject, eventdata, handles)
% hObject    handle to submit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
checkPass = checkValues(handles);

if (checkPass == 1)
    cla(handles.allneurons);
    %cla(handles.oneneuron);
    cla(handles.allneuronstimeperiod);
    cla(handles.networktopology);
    guidata(gcbo,handles);
    allneurons_Create(hObject, eventdata, handles);
    oneneuron_Create(hObject, eventdata, handles);
else
    errordlg('Invalid Parameter');
end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over submit.
function submit_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to submit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.allneurons);
cla(handles.allneuronstimeperiod);
%cla(handles.oneneuron);
cla(handles.networktopology);

guidata(gcbo,handles);

for x = 1:size(handles.parameters,2)
    set(handles.textBoxes(x),'String',num2str(handles.parameters(x)));
end
for x = 1:size(handles.ExpInFparameters,2)
    set(handles.ExpInFtextBoxes(x),'String',num2str(handles.ExpInFparameters(x)));
end
handles.timeone = 0;
handles.timetwo = handles.simulaTime;
handles.synapticPlasticity = 0;
handles.izhikModel = 1;
handles.tauModel = 0;
handles.exponModel = 0;
handles.couplingOne = 1;
handles.couplingTwo = 0;
handles.couplingThree = 0;
handles.couplingFour = 0;

guidata(gcbo,handles);

allneurons_Create(hObject, eventdata, handles);
oneneuron_Create(hObject, eventdata, handles);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over reset.
function reset_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in analyse.
function analyse_Callback(hObject, eventdata, handles)
% hObject    handle to analyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
neurons_to_display = getappdata(0,'neurons_to_display');
time = getappdata(0,'time');
system = getappdata(0,'system');
allneuronstimeperiod_Create(handles, time, system, neurons_to_display);

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over analyse.
function analyse_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to analyse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in synchronisation.
function synchronisation_Callback(hObject, eventdata, handles)
% hObject    handle to synchronisation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SynchronisationPlot;

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over synchronisation.
function synchronisation_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to synchronisation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in biograph.
function biograph_Callback(hObject, eventdata, handles)
% hObject    handle to biograph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Acoup = getappdata(0,'Acoup');
Bio = transpose(-Acoup);
bgraph = biograph(Bio);  % make biograph object
dolayout(bgraph);   % automatically calculate positions for nodes
view(bgraph); % what it says on the tin

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over biograph.
function biograph_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to biograph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
