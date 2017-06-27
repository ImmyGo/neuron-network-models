%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Models a network of integrate and fire neurons
% Stores result in an array = System, which gives behaviour of each neuron
% over simulation
% System[n, t] = potential of neuron n at time t

function [time , system, neuronarray] = NeuronNetworkInF(parameters, Acoup, neurons_to_display)
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
coupling = parameters(13);
 
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
% Now generated in separate file

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
%c = coupling;

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
    for j=1:n_neurons
        % make inhibitory synapses stronger
        if j <= n_neurons_inh
            c = coupling*2;
        else
            c = coupling;
        end
        v = S(1,j);
        u = S(2,j);

        v = v + simulation_step * ((0.04 * v * v) + (5 * v) + 140 - u + I) + c*Acoup(j,:)*S(1,:)'; % v dot = b + 0.04 v squared + 5 v - u + I 
        u = u + simulation_step * (a * (b * v - u)); % u dot = a(bv - u)

        if v >= v_thresh % then spike
            %v(T) = v_thresh;  % padding the spike amplitude
            v = v_reset;  % voltage reset
            u = u + u_reset;
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