module SigmaDeltaDAC(
    input clk,                   System clock
    input reset,                 Reset signal
    input [70] dataIn,          8-bit input digital data
    output dacOut                DAC PWM output
);

 Interpolating Filter Parameters
parameter FILTER_N = 8;         Bit width of the data for the filter
parameter TAPS = 4;             Number of taps in the filter

 Sigma-Delta Modulator Parameters
parameter SDM_N = 8;            Bit width of the input data for the modulator

 Interpolated data signal
wire [FILTER_N-10] filteredData;

 Instantiate the InterpolatingFilter
InterpolatingFilter #(
    .N(FILTER_N),
    .TAPS(TAPS)
) interpolatingFilter (
    .clk(clk),
    .reset(reset),
    .dataIn(dataIn),
    .dataOut(filteredData)
);

 Instantiate the SigmaDeltaModulator
SigmaDeltaModulator #(
    .N(SDM_N)
) sigmaDeltaModulator (
    .clk(clk),
    .reset(reset),
    .dataIn(filteredData),
    .dacOut(dacOut)
);

endmodule
