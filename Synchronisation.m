%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculates synchronisation rate in Neural Network using
% ||xi(t) - xj(t)||
% creates array of the average difference between two neurons for every
% time step in the simulation

function [result] = Synchronisation(system)

n_neurons = size(system, 1);
n_time_steps = size(system, 2);
result = zeros(1, n_time_steps);

% Evaluate level of synchronisation at every time point in the network
for t = 1 : n_time_steps
    resultT = 0;
    % compare every pair of neurons
    for i = 1 : n_neurons
        % syncVal is the difference between the two neurons
        for j = i+1 : n_neurons
            % Euclidean norm of neuron i - neuron j
            currentVal = sqrt((system(i, t) - system(j, t)).^2);
            resultT = resultT + currentVal;
        end
    end
    % divide total of all differences by no. distinct pairings of neurons
    nneurons_choose_2 = factorial(n_neurons) / (2 * factorial(n_neurons - 2));
    resultT = resultT / nneurons_choose_2;
    % so result(t) will be average dist between any two neurons at time t
    result(t) = resultT;
end

%g = sprintf('%d ', result);
%fprintf('Overal synch result = %s\n', g)
%plot(result)

end