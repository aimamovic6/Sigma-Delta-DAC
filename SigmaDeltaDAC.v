module SigmaDeltaDAC(
    input clk,                 
    input reset,                
    input [7:0] dataIn,         
    output dacOut               
);


parameter FILTER_N = 8;        
parameter TAPS = 4;            


parameter SDM_N = 8;         


wire [FILTER_N-1:0] filteredData;


InterpolatingFilter #(
    .N(FILTER_N),
    .TAPS(TAPS)
) interpolatingFilter (
    .clk(clk),
    .reset(reset),
    .dataIn(dataIn),
    .dataOut(filteredData)
);


SigmaDeltaModulator #(
    .N(SDM_N)
) sigmaDeltaModulator (
    .clk(clk),
    .reset(reset),
    .dataIn(filteredData),
    .dacOut(dacOut)
);

endmodule
