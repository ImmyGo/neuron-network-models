% Generates an nxn coupling matrix to use for network connections
% where n = number of neurons
% A(i,j) = 1 if there is a link from neuron i to neuron j
% Implemented as a backwards link (-1) from neuron j to neuron i

function [Acoup] = NetworkCoupling(n_neurons, coupling_type)

Acoup = zeros(n_neurons);

switch coupling_type
    case 1      % Simple Laplacian, neurons connected in straight line
        for row = 1:n_neurons
            for col = 1:n_neurons 
                if row == col
                    Acoup(row,col) = 0;
                end
                if row-col == 1
                    Acoup(row,col) = -1;
                end
            end
        end
    case 2      % Neuron connected to two neighbours either side
        for row = 1:n_neurons
            for col = 1:n_neurons 
                if row == col
                    Acoup(row,col) = 0;
                end
                if row-col == 1
                    Acoup(row,col) = -1;
                end
                if row-col == 2
                    Acoup(row,col) = -1;
                end
                if row-col == 3
                    Acoup(row,col) = -1;
                end
            end
        end
    case 3      % Neurons randomly connected
        for col = 1:n_neurons
            for row = 1:n_neurons 
                y = rand;
                if y < .2       % prevents the network overloading
                    Acoup(row, col) = -1;
                end
                if row == col
                    Acoup(row,col) = 0;
                end
            end
        end
    case 44     % first four neurons into the 5th, feeding next four into the 10th etc.
        for row = 1:n_neurons
            for col = 1:n_neurons 
                if mod(row, 5) ~= 0
                    if mod(col, 5) == 0 && col-row < 5 && col-row > 0
                        Acoup(row,col) = 1;
                    end
                end
                if mod(row, 5) == 0 && col-row == 1
                    Acoup(row,col) = 1;
                end
            end
        end
    case 4     % first four neurons into the 5th, feeding next four into the 10th etc.
        for row = 1:n_neurons
            for col = 1:n_neurons 
                if mod(col, 5) ~= 0
                    if mod(row, 5) == 0 && row-col < 5 && row-col > 0
                        Acoup(row,col) = -1;
                    end
                end
                if mod(col, 5) == 0 && row-col == 1
                    Acoup(row,col) = -1;
                end
            end
        end
end

end