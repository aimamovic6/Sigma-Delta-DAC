module SigmaDeltaModulator(
    input clk,                       
    input reset,                     
    input [N-1:0] dataIn,            
    output reg dacOut                
);

parameter N = 8;                     
reg [N:0] accumulator = 0;          
reg [N-1:0] dataFeedback = 0;        

always @(posedge clk or posedge reset) begin
    if (reset) begin
        accumulator <= 0;
        dacOut <= 0;
        dataFeedback <= 0;
    end
    else begin

        accumulator <= accumulator + dataIn - dataFeedback;


        if (accumulator > (1 << (N - 1))) begin
            dacOut <= 1;
            accumulator <= accumulator - (1 << N);
        end else begin
            dacOut <= 0;
        end
        dataFeedback <= dacOut ? (1 << (N - 1)) : 0; 
    end
end

endmodule
