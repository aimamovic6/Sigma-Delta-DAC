module sigma_delta_modulator (
    input wire clk,             // 128x 
    input wire reset,           
    input wire signed [15:0] in, // 16-bit input from the interpolating filter
    output reg out             // 1-bit PDM output
);

    
    reg signed [17:0] integrator1; 
    reg signed [17:0] integrator2;
    reg signed [15:0] diff1;
    reg signed [15:0] diff2;
    reg signed [17:0] comparator;

    // Second order modulation
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            integrator1 <= 0;
            integrator2 <= 0;
            diff1 <= 0;
            diff2 <= 0;
            comparator <= 0;
            out <= 0;
        end else begin     
            diff1 <= in - (out ? 16'h7FFF : 16'h8000); // 1-bit DAC feedback difference

            integrator1 <= integrator1 + diff1;

            diff2 <= integrator1 - (out ? 16'h7FFF : 16'h8000); // 1-bit DAC feedback difference for second stage

            integrator2 <= integrator2 + diff2;

            out <= (integrator2[17] == 1'b0) ? 1'b1 : 1'b0; // Output '1' if MSB of integrator2 is '0', otherwise '0'
        end
    end

endmodule
