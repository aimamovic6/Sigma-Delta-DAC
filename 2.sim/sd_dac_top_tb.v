`timescale 1ns/1ps

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

    // Inputs to the DUT
    reg clk;
    reg reset;

    // Outputs from the DUT
    wire output_pdm_p;

    // Instantiate the DUT (Device Under Test)
    sd_dac_top uut (
        .clk(clk),
        .reset(reset),
        .output_pdm_p(output_pdm_p)
    );

    // Clock generation
    always #50 clk = ~clk; // 10 MHz clock period = 100 ns, so toggle every 50 ns for 10 MHz

    // Test sequence
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 0;  // Start with reset enabled

        // Apply reset for 200 ns, then release
        #200;
        reset = 1;

        // Run the simulation for some time (e.g., 10 ms)
        #4000000;  // 10 ms = 10,000,000 ns

        // Finish the simulation
        $finish;
    end



endmodule
