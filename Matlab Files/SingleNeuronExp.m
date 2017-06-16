%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Exponential Integrate and fire model
function [vsingle, tsingle] = SingleNeuronExp(parameters)

mem_capacitance = parameters(5);        
leak_conductance = parameters(6); 
leak_reversal = parameters(7);       
v_thresh = parameters(8);
slope_factor = parameters(9);
adap_time_const = parameters(10);
spike_adaptation = parameters(11);
subthresh_adaptation = parameters(12);

Vpeak = 20;
Vr = leak_reversal;

simulation_time = parameters(3);
simulation_step = parameters(4);
simulation_freq = round(simulation_time/simulation_step);

% Initial conditions
tsingle = 0*ones(1, simulation_freq);
vsingle = leak_reversal*ones(1, simulation_freq);
usingle = 0*vsingle;

% Input current (constant)
I = 1500 * ones(1, simulation_freq); 


% forward Euler method
for i = 1 : simulation_freq-1
    vsingle(i+1) = vsingle(i) + simulation_step * 1/mem_capacitance * ( -leak_conductance*(vsingle(i) - leak_reversal) + leak_conductance*slope_factor * exp(vsingle(i)-v_thresh/slope_factor) - usingle(i) + I(i) );
    usingle(i+1) = usingle(i) + simulation_step * 1/adap_time_const * (subthresh_adaptation*(vsingle(i) - leak_reversal) - usingle(i));
    if (vsingle(i+1) >= Vpeak)
        vsingle(i) = Vpeak;
        usingle(i+1) = usingle(i+1) + spike_adaptation;
        vsingle(i+1) = Vr;
    end
    tsingle(i+1) = tsingle(i) + simulation_step;
end

end