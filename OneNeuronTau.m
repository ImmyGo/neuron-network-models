%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Some simulations:

% Excitatory Neurons
% OneNeuronTau(-65,30,100,1,58) regular spiking


% Simple Model Using Membrane Time Constant
function OneNeuronTau(vreset, vthresh, time, timestep, tau)

v_reset = vreset;                %reset membrane potential
v_thresh = vthresh;               %spike threshold

simulation_time = time;        %in ms
simulation_step = timestep;        %in ms
simulation_freq = round(simulation_time/simulation_step);

tau_exc = tau;                %membrane time constant

tsingle = 0*ones(1, simulation_freq); % 0 * (1 x n) array of ones
vsingle = v_reset;


% forward Euler method
for i = 1 : simulation_freq-1
    vsingle(i+1) = vsingle(i) + simulation_step * ((vsingle(i).^2) / tau_exc);

    if vsingle(i+1) >= v_thresh % then spike
        vsingle(i) = v_thresh;  % padding the spike amplitude
        vsingle(i+1) = v_reset;  % voltage reset
    end
    tsingle(i+1) = tsingle(i) + simulation_step;
end

% Plot
plot(tsingle, vsingle, 'k', 'linewidth', 2);
title('Single Neuron Behaviour Tau Model')
xlabel('Time / s') % x-axis label
ylabel('Voltage / mV') % y-axis label

end