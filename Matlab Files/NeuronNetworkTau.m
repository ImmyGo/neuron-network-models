%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Models a network of simply modeled neurons
% Stores result in an array = System, which gives behaviour of each neuron
% over simulation
% System[n, t] = potential of neuron n at time t

function [time , system, neuronarray] = NeuronNetworkTau(parameters, Acoup, neurons_to_display)
%% Function Parameters
n_neurons_exc = parameters(1);              %number of excitatory neurons
n_neurons_inh = parameters(2);              %number of inhibitory neurons
n_neurons = n_neurons_exc + n_neurons_inh;

v_reset = parameters(3);                    %reset membrane potential
v_thresh = parameters(5);                   %spike threshold
I = parameters(8);

simulation_time = parameters(9);            %in ms
simulation_step = parameters(10);           %in ms
simulation_freq = round(simulation_time/simulation_step);

tau_exc = parameters(11);                   %membrane time constant excitatory
tau_inh = parameters(12);                   %membrane time constant inhibitory
coupling = parameters(13);
 
%% Setting the initial conditions for the network

v0 = zeros(1, n_neurons);                   %row vector of initial v,u for all neurons
% Assign initial state of each neuron in network
for j=1:n_neurons
    v0(j) = [v_reset];
end
    
%% States matrix -> states of variables u and v

S = zeros(1, n_neurons);
for j = 1:n_neurons
    S(j)= v0(j);
end


%% The interconnection matrix

% Acoup = zeros(n_neurons);
% for col = 1:n_neurons
%     for row = 1:n_neurons 
%         if row == col
%             Acoup(row,col) = 1;
%         end
%         if abs(row-col) == 1
%             Acoup(row,col) = -1;
%         end
%     end
% end
%load CouplingMatrix


% Coupling strength
c = coupling;

%% Testing models

% Array of 4 neurons
neuronarray = [1,2,3,4];
membrane = zeros(simulation_freq, 2);
% Array of 1 neuron
singleneuron = [1];
membranesingle = zeros(simulation_freq, 2);
% Separate excitatory and inhibitory neuron arrays
exNeurons = [1,2,3];
inNeurons = [4,5];
exMembrane = zeros(simulation_freq, 2);
inMembrane = zeros(simulation_freq, 2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time = 0*ones(1, simulation_freq);
system = zeros(n_neurons, simulation_freq);

for T = 1 : simulation_freq-1
    % Separate calculation for inhibitory and exchibitory neurons
    for j=1:n_neurons_exc
        v = S(j);
        v = v +((v.^2) / tau_exc)*simulation_step + c*Acoup(j,:)*S(1,:)';
        if v >= v_thresh % then spike
            v = v_reset;  % voltage reset
        end
        S(j) = v;
        system(j, T) = v; 
    end
  
    for j=n_neurons_exc+1:n_neurons_inh
        v = S(j);
        v = v +((v.^2) / tau_inh)*simulation_step + c*Acoup(j,:)*S(1,:)';
        if v >= v_thresh % then spike
            v = v_reset;  % voltage reset
        end
        S(j) = v;
        system(j, T) = v;    
    end
    time(T+1) = time(T) + simulation_step;
end


% Plot all neurons graph
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

ylabel('Voltage / mV') % x-axis label
xlabel('Time / ms') % y-axis label
end