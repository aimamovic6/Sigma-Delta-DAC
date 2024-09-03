`timescale 1ns / 1ps

module sd_dac_top_tb;

  initial begin
`ifdef CCSDF
    $sdf_annotate("sd_dac_top_00.sdf", uut);
`endif
    $dumpfile("../2.sim/sd_dac_top_tb.vcd");
    $dumpvars(0, sd_dac_top_tb);
    clk   = 0;
    reset = 0;
  end



      // Clock and reset signals
    reg clk;
    reg reset;
    wire signed output_pdm;

    // Instantiate the DUT (Device Under Test)
    sd_dac_top uut (
        .clk(clk),             // Global clock input (128x44.1 kHz)
        .reset(reset),         // Reset signal
        .output_pdm(output_pdm) // 1-bit PDM output
    );

    // Clock generation (128x44.1 kHz = 5.6448 MHz)
    initial begin
        clk = 0;
        forever #88.5 clk = ~clk; // Toggle clock every 88.5ns (5.6448 MHz)
    end

    // Reset generation and simulation control
    initial begin
        // Initialize signals
        reset = 1;

        // Apply reset for a short duration
        #100 reset = 0; // De-assert reset after 100ns

        // Run the simulation for a sufficient duration
        #10_000_000
        $finish; // Stop simulation after 2ms
    end

endmodule
