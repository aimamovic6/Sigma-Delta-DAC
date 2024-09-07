module sigma_delta_modulator (
    input wire clk,              // Clock signal
    input wire rst_n,            // Active-low reset
    input wire signed [15:0] in, // 16-bit input from the interpolating filter
    output out               // 1-bit PDM output
);

    // Internal signals
    reg signed [17:0] integrator1, integrator2;
    wire signed [15:0] diff1, diff2;
    wire signed [17:0] acc1, acc2;
    reg out_bit;

    // Calculations for differences and accumulations
    assign diff1 = in - (out ? 16'h7FFF : 16'h8000);
    assign acc1 = integrator1 + diff1;
    assign diff2 = acc1 - (out ? 16'h7FFF : 16'h8000);
    assign acc2 = integrator2 + diff2;


    // Sequential logic for integrating and output generation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            // Reset all registers to zero
            integrator1 <= 0;
            integrator2 <= 0;
            out_bit <= 0;
        end else begin
            // Update integrators with calculated values
            integrator1 <= acc1;
            integrator2 <= acc2;

            // Update output bit
            out_bit <= ~acc2[17]; // Output '1' if MSB of acc2 is '0', otherwise '0'
        end
    end

    assign out = out_bit;
endmodule


