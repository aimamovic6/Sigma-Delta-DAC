module InterpolatingFilter(
    input clk,                       
    input reset,                     
    input [N-1:0] dataIn,            
    output reg [N-1:0] dataOut       
);

parameter N = 8;                     
parameter TAPS = 4;                  
reg [N-1:0] shiftRegister[TAPS-1:0]; 
integer i;


wire [N-1:0] coefficients[TAPS-1:0] = {8'd1, 8'd3, 8'd3, 8'd1}; 

always @(posedge clk or posedge reset) begin
    if (reset) begin
        
        for(i = 0; i < TAPS; i = i + 1) begin
            shiftRegister[i] <= 0;
        end
        dataOut <= 0;
    end
    else begin
        
        for(i = TAPS-1; i > 0; i = i - 1) begin
            shiftRegister[i] <= shiftRegister[i-1];
        end
        shiftRegister[0] <= dataIn;

        
        dataOut <= 0; 
        for(i = 0; i < TAPS; i = i + 1) begin
            dataOut <= dataOut + shiftRegister[i] * coefficients[i];
        end
    end
end

endmodule
