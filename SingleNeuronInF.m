%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Some simulations:

% Excitatory Neurons
% SingleNeuron(100,0.01,0.02,0.2,-65,8,14) regular spiking
% SingleNeuron(100,0.01,0.02,0.2,-55,4,14) intrinscally bursting
% SingleNeuron(100,0.01,0.02,0.2,-50,2,14) chattering

% Inhibitory Neurons
% SingleNeuron(100,0.01,0.1,0.2,-65,2,14) fast spiking
% SingleNeuron(100,0.01,0.02,0.25,-65,2,14) low threshold spiking

% Izhikevich Integrate and fire model
function [vsingle, tsingle] = SingleNeuronInF(parameters)

v_reset = parameters(3);                %reset membrane potential
u_reset = parameters(4); 
v_thresh = parameters(5);               %spike threshold
a = parameters(6);
b = parameters(7);
I = parameters(8);

simulation_time = parameters(9);        %in ms
simulation_step = parameters(10);       %in ms
simulation_freq = round(simulation_time/simulation_step);

tau_exc = parameters(11);               %membrane time constant
tau_inh = parameters(12);

tsingle = 0*ones(1, simulation_freq); % 0 * (1 x n) array of ones
vsingle = v_reset;
u = b*vsingle;


% forward Euler method
for i = 1 : simulation_freq-1
    vsingle(i+1) = vsingle(i) + simulation_step * ((0.04 * vsingle(i) * vsingle(i)) + (5 * vsingle(i)) + 140 - u(i) + I); % v dot = b + 0.04 v squared + 5 v - u + I 
    u(i+1) = u(i) + simulation_step * (a * (b * vsingle(i) - u(i))); % u dot = a(bv - u)
  
    if vsingle(i+1) >= v_thresh           % then spike
        vsingle(i) = v_thresh;              % padding the spike amplitude
        vsingle(i+1) = v_reset;             % voltage reset
        u(i+1) = u(i+1) + u_reset;
    end
    tsingle(i+1) = tsingle(i) + simulation_step;
end

% Plot
%plot(tsingle, vsingle, 'k', 'linewidth', 2);
%title('Single Neuron Behaviour Izhikevich Model')
%xlabel('Time / s') % x-axis label
%ylabel('Voltage / mV') % y-axis label

end