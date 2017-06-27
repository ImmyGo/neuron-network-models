# neuron-network-models
Models of firing neurons in the brain with dynamic coupling to produce complex network synchronisation


This project presents Matlab code to simulate the following cases:
1. One firing neuron cell, using three different models.
2. A network of x number of firing neurons, coupled together using a static coupling matrix.
3. A network of x number of firing neurons, coupled together using a dynamic coupling function based on a model of the synapse between neuron cells.


In the **single_neuron_models directory** are individual programs that run to model behaviour of a single firing neuron
Each program has some example runs listed at the top.

  +  OneNeuronTau.m : A simple model based on the Tau constant
  +  OneNeuronIzhInF.m : Izkevich's famous integrate-and-fire neuron model
  +  OneNeuronExpInF.m  :A more complex exponential neuron model

In the **neuron_network_models** directory run the program 'Neuron Simulations' to bring up a GUI that allows configuration and display of the neuron network.

  +  NeuronSimulations.m : A GUI that brings together all the different models and behaviours
  +  NeuronNetworkTau.m : Models a network of 'Tau firing' neurons connected together with a coupling matrix. The state of each neuron through time is calculated using the forward Euler method.
  +  NeuronNetworkInF.m : Models a network of 'Integrate-and-fire firing' neurons 
  +  NeuronNetworkExp.m : Models a network of 'Exponential model firing' neurons 

There are also a number of programs that help construct the network models
  +  NetworkCoupling.m : Constructs a few different coupling matrices - straight line network / nearest neighbour network / random coupling
  +  Synchronisation.m : Calculates level of synchronisation between all pairs of neuron in network at every time point in simulation, and takes average
  +  *plot.m : helper method to plot figures in GUI
  +  *.fig : figures for displaying result of Matlab programs

The final file
  +  NeuronNetworkInFwithPlasticity.m : Models a network of integrate and fire neurons, however this extended model calculates each link between two neurons dynamically using a synaptic weights model. The more spikes fired by a neuron feeding into the synapse, the stronger the link made by the synapse becomes.


The Docs folder contains sample run configurations and results in a Demo.doc

