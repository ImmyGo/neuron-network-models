%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Some simulations:
% OneNeuronExpInf(500, 0.01, 500, 281, 30, -70.6, -50.4, 1, 144, 80.5, 4, -50.4)
% OneNeuronExpInf(500, 0.01, 1000, 281, 30, -70.6, -50.4, 1, 144, 80.5, 4, -50.4)
% OneNeuronExpInf(800, 0.01, 1500, 281, 30, -60, -50.4, 1, 720, 80.5, 80, -47.4)
% OneNeuronExpInf(500, 0.01, 500, 281, 30, -60, -50.4, 1, 720, 80.5, 80, -50.4)

% Exponential Integrate and fire model
function OneNeuronExpInf(time, step, current, C, gL, EL, VT, DeltaT, tauw, b, a, Vr)

mem_capacitance = C;                
leak_conductance = gL; 
leak_reversal = EL;             
v_thresh = VT;
slope_factor = DeltaT;
adap_time_const = tauw;
spike_adaptation = b;
subthresh_adaptation = a;

Vpeak = 20;
Vr = Vr;

simulation_time = time;
simulation_step = step;
simulation_freq = round(simulation_time/simulation_step);
% Initial conditions
tsingle = 0*ones(1, simulation_freq);
vsingle = leak_reversal*ones(1, simulation_freq);
usingle = 0*vsingle;

% Input current - it is quite flexible;
% constant current - set the specific constant value
I = current * ones(1, simulation_freq); 


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

% Plot
plot(tsingle, vsingle, 'k', 'linewidth', 2);
title('Single Neuron Behaviour Exponential Model')
xlabel('Time / s') % x-axis label
ylabel('Voltage / mV') % y-axis label

end