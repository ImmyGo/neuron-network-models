%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Models a network of integrate and fire neurons
% Stores result in an array = System, which gives behaviour of each neuron
% over simulation
% System[n, t] = potential of neuron n at time t
%
% This extended model calculates each link between two neurons dynamically
% using a synaptic weights model. The more spikes fired by a neuron feeding
% into the synapse, the stronger the link made by the synapse becomes.

function [time , system, neuronarray] = NeuronNetworkInFwithPlasticity(parameters, Acoup, neurons_to_display)
%% Function Parameters
n_neurons_exc = parameters(1);              %number of excitatory neurons
n_neurons_inh = parameters(2);              %number of inhibitory neurons
n_neurons = n_neurons_exc + n_neurons_inh;

v_reset = parameters(3);                    %reset membrane potential
u_reset = parameters(4);                    %reset of recovery u
v_thresh = parameters(5);                   %spike threshold
a = parameters(6);
b = parameters(7);
I = parameters(8);

simulation_time = parameters(9);            %in ms
simulation_step = parameters(10);           %in ms
simulation_freq = round(simulation_time/simulation_step);

tau_exc = parameters(11);                   %membrane time constant excitatory
tau_inh = parameters(12);                   %membrane time constant inhibitory
connect_prob = parameters(13);              %connection probability
coupling = parameters(14);
 
%% Setting the initial conditions for the network

v0 = zeros(1, n_neurons*2);                 %row vector of initial v,u for all neurons
% Assign initial state of each neuron in network
for j=1:n_neurons
    v0(2*(j-1)+1:2*j) = [v_reset, b*v_reset];
end
    
%% States matrix -> states of variables u and v

S = zeros(2, n_neurons);
for j = 1:n_neurons
    S(:,j)= v0(2*(j-1)+1:2*j);
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
firing_info = zeros(n_neurons, simulation_freq);

for T = 1 : simulation_freq-1
    for j=1:n_neurons
        v = S(1,j);
        u = S(2,j);
    
        % Synapse calculations
        % get list of all incoming neurons
        incoming_neurons = [];
        for x = 1:n_neurons
            if Acoup(j,x) == -1
                incoming_neurons(end+1) = x;
            end
        end

        % Synaptic weights
        % randomly drawn from a Gaussian distribution with mean 1.62mV and standard deviation 0.5mV.
        % column vector size = no. incoming neurons
        W = 1.62 + 0.5*randn(1, numel(incoming_neurons));

        % calculate sum of dirac(T - tk(f))
        % where tk(f) = time of fth spike on kth presynaptic neuron 
        I_input = 0;
        for x = 1:numel(incoming_neurons)
            sum = 0;
            for t = 1:T  % for all time up untill now
                if firing_info(incoming_neurons(x), t) == 1
                    % using exponential alpha function, not dirac delta.
                    sum = sum + exp(-(T-t)/5);
                end
            end
            % Use synaptic weights to calculate total current in to neuron
            I_input = I_input + W(x)*sum;
        end
    
        v = v + simulation_step * ((0.04 * v * v) + (5 * v) + 140 - u + I) + I_input;
        u = u + simulation_step * (a * (b * v - u)); % u dot = a(bv - u)

        if v >= v_thresh % then spike
            %v(T) = v_thresh;  % padding the spike amplitude
            v = v_reset;  % voltage reset
            u = u + u_reset;
            firing_info(j, T) = 1;
        end
    
        S(1,j) = v;
        S(2,j) = u;
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