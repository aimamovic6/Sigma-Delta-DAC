# Sigma-Delta-DAC
This repository hosts the development of a sigma-delta digital-to-analog converter (DAC) implementation on FPGA, integrated with a 
pipeline prototype of digital signal processing (DSP) from GNU Radio. 

## Theory

The S-D DACs uses less analog circuitry at the expense of more digital circuitry compared to the Nyquist rate DACs. This is done 
using the concepts of oversampling and noise shaping. The figure below shows a block diagram of a S-D DAC.
The digital parts of the S- D DAC are the IF and the digital S-D modulator, while the analog parts are the M -bit
internal DAC, and the analog LPF.

 <img src="https://github.com/aimamovic6/Sigma-Delta-DAC-/assets/109389744/ea2aa415-4dee-48ee-8f36-0e2d75c55b67" width="700">

### Interpolation filter
The IF is an essential part of the S-D DAC and can have a big impact on the overall power
consumption and performance of the DAC. The cascaded integrator-comb (CIC) filter is a subclass of
linear phase FIR filters for decimation and interpolation, which uses no multiplication and
limited storage. Figure below shows the basic structure of the CIC IF.

 <img src="https://github.com/aimamovic6/Sigma-Delta-DAC-/assets/109389744/04943f96-6a15-42f2-ad37-6d8d1da6ca7e" width="450">

### S-D modulator
The delta sigma modulator is the core of delta sigma converters. The average level of the produced bitstream represents the input signal level. 
A simple digital first order delta sigma modulator block diagram looks like this:

 <img src="https://github.com/aimamovic6/Sigma-Delta-DAC-/assets/109389744/d285277f-2699-48ee-9136-eaf40f3b27d0" width="450">

### Lowpass Filter
The bitstream signal can be viewed as having its information predominantly situated within the lower frequency band, while containing substantial noise in higher frequencies.
The low pass filter at the output is needed to average out the signal of the bitstream. 

# GNU Radio Prototype
