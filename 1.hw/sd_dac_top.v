module sd_dac_top(
    input clk,             // Global clock input (128x44.1 kHz)
    input reset,           // Reset signal
    output output_pdm // 1-bit PDM output
);

    wire clk_44kHz, clk_176kHz ;        // Clock signal for the sine wave generator (44.1 kHz)
    wire signed [19:0] sine_wave;
    wire signed [15:0] filter_output;
    wire clk_enable;
    wire ce_out;

    wire clk270, clk180, clk90, clk0, usr_ref_out;
	wire usr_pll_lock_stdy, usr_pll_lock;

	CC_PLL #(
		.REF_CLK(10.0),      // reference input in MHz
		.OUT_CLK(5.6448),     // pll output frequency in MHz
		.PERF_MD("ECONOMY"), // LOWPOWER, ECONOMY, SPEED
		.LOW_JITTER(1),      // 0: disable, 1: enable low jitter mode
		.CI_FILTER_CONST(2), // optional CI filter constant
		.CP_FILTER_CONST(4)  // optional CP filter constant
	) pll_inst (
		.CLK_REF(clk), .CLK_FEEDBACK(1'b0), .USR_CLK_REF(1'b0),
		.USR_LOCKED_STDY_RST(1'b0), .USR_PLL_LOCKED_STDY(usr_pll_lock_stdy), .USR_PLL_LOCKED(usr_pll_lock),
		.CLK270(clk270), .CLK180(clk180), .CLK90(clk90), .CLK0(clk0), .CLK_REF_OUT(usr_ref_out)
	);

    assign clk_enable = 1'b1;


    // Clock divider instance
    clk_divider u_clk_divider(
        .clk_in(clk0),       // Global clock input
        .reset(reset),       // Reset signal
        .clk_out(clk_44kHz),
        .clk_out_1 (clk_176kHz) // Divided clock output (44.1 kHz)
    );


    // Sine wave generator instance
    sine_wave_generator u_sine_wave_generator(
        .clk(clk_176kHz),    // Use the divided clock (44.1 kHz)
        .reset(reset),
        .sine_out(sine_wave)
    );

    // Interpolating filter instance
    interpolatingFilter u_interpolatingFilter (
        .clk(clk0),          // Use the global clock (128x44.1 kHz)
        .clk_enable(clk_enable),
        .reset(reset),
        .input_data(sine_wave), // Connect sine wave to filter input
        .output_data(filter_output),
        .ce_out(ce_out)
    );


    // Sigma-delta modulator instance
    sigma_delta_modulator u_sigma_delta_modulator(
        .clk(clk0),
        .rst_n(!reset),
        .in(filter_output),
        .out(output_pdm)
    );

   // assign output_pdm = filter_output[0];

endmodule
