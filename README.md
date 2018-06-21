# microphoneSelfNoise

Generates an instance of microphone selfnoise. See example. The noise is generated from a statistical analysis of a number of noise spectra extracted from a number of anechoic recordings. The noise files that this was extract from is included. there is a *.mat file that (selfnoise.mat) contains all the required variables.

The sampling frequency is 44.1 kHz, but you can specify something different and the function will resample the output. Also outputted is the spectrum that was generated in case you need to save this. If a spectrum is provded to the function then it will generate noise from that input and not generate a new random spectrum.
