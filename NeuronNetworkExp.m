%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Models a network of exponential integrate and fire neurons
% Stores result in an array = System, which gives behaviour of each neuron
% over simulation
% System[n, t] = potential of neuron n at time t

function [time , system, neuronarray] = NeuronNetworkExp(parameters, Acoup, neurons_to_display)
%% Function Parameters
n_neurons_exc = parameters(1);              %number of excitatory neurons
n_neurons_inh = parameters(2);              %number of inhibitory neurons
n_neurons = n_neurons_exc + n_neurons_inh;

simulation_time = parameters(3);            %in ms
simulation_step = parameters(4);            %in ms
simulation_freq = round(simulation_time/simulation_step);

mem_capacitance = parameters(5);           
leak_conductance = parameters(6);           
leak_reversal = parameters(7);              
v_thresh = parameters(8);
slope_factor = parameters(9);
adap_time_const = parameters(10);
spike_adaptation = parameters(11);
subthresh_adaptation = parameters(12);

coupling = parameters(13);                  %coupling strength

Vpeak = 20;
Vr = leak_reversal;
I = 1500;                                   %constant input current
%% Setting the initial conditions for the network

v0 = zeros(1, n_neurons*2);                 %row vector of initial v,u for all neurons
% Assign initial state of each neuron in network
for j=1:n_neurons
    v0(2*(j-1)+1:2*j) = [leak_reversal, 0];
end
    
%% States matrix -> states of variables u and v

S = zeros(2, n_neurons);
for j = 1:n_neurons
   S(:,j)= v0(2*(j-1)+1:2*j);
end

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
    for j=1:n_neurons
        v = S(1,j);
        u = S(2,j);
    
        v = v + simulation_step * 1/mem_capacitance * ( -leak_conductance*(v - leak_reversal) + leak_conductance*slope_factor * exp(v-v_thresh/slope_factor) - u + I)+ c*Acoup(j,:)*S(1,:)';
        u = u + simulation_step * 1/adap_time_const * (subthresh_adaptation*(v - leak_reversal) - u);

        if v >= Vpeak % then spike
            if T > 1
                system(j, T-1) = Vpeak; 
            end
            v = Vr;  % voltage reset
            u = u + spike_adaptation;
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