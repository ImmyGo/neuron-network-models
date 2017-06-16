%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Some simulations:

% Excitatory Neurons
% SingleNeuronTau(-65,30,100,1,60) regular spiking
% SingleNeuronTau(-65,30,100,1,64) 

% Simple Tau Model
function [vsingle, tsingle] = SingleNeuronTau(parameters)

v_reset = parameters(3);                %reset membrane potential
v_thresh = parameters(5);               %spike threshold

simulation_time = parameters(9);        %in ms
simulation_step = parameters(10);       %in ms
simulation_freq = round(simulation_time/simulation_step);

tau_exc = parameters(11);               %membrane time constant
tau_inh = parameters(12);

tsingle = 0*ones(1, simulation_freq); % 0 * (1 x n) array of ones
vsingle = v_reset;


% forward Euler method
for i = 1 : simulation_freq-1
    vsingle(i+1) = vsingle(i) + simulation_step * ((vsingle(i).^2) / tau_exc);

    if vsingle(i+1) >= v_thresh           % then spike
        vsingle(i) = v_thresh;              % padding the spike amplitude
        vsingle(i+1) = v_reset;             % voltage reset
    end
    tsingle(i+1) = tsingle(i) + simulation_step;
end

% Plot
%plot(tsingle, vsingle, 'k', 'linewidth', 2);
%title('Single Neuron Behaviour Tau Model')
%xlabel('Time / s') % x-axis label
%ylabel('Voltage / mV') % y-axis label

end