module interpolatingFilter(

    input         clk,
    input         clk_enable,
    input         reset,
    input  signed [15:0] input_data,
    output signed [15:0] output_data,
    output        ce_out
);
    // Intermediate signals to connect filters
    wire signed [20:0] output_halfBandFirst;
    wire signed [19:0] output_halfBandSecond;
    wire signed [17:0] output_inverseSinc;
    wire signed [18:0] output_cic1;
    wire signed [17:0] output_cic2;
    wire signed [16:0] output_cic3;
    wire              ce_halfBandFirst;
    wire              ce_halfBandSecond;
    wire              ce_inverseSinc;
    wire              ce_cic1;
    wire              ce_cic2;
    wire              ce_cic3;
    wire              ce_cic4;

    // Instantiate each filter module
    //halfBandFirst filter1 (
        //.clk(clk),
        //.clk_enable(ce_halfBandSecond),
        //.reset(reset),
        //.filter_in(input_data),
        //.filter_out(output_halfBandFirst),
        //.ce_out(ce_halfBandFirst)
    //);

    //halfBandSecond filter2 (
        //.clk(clk),
        //.clk_enable(ce_inverseSinc),
        //.reset(reset),
        //.filter_in(input_data),
        //.filter_out(output_halfBandSecond),
        //.ce_out(ce_halfBandSecond)
    //);

    inverseSinc filter3 (
        .clk(clk),
        .clk_enable(ce_cic1),
        .reset(reset),
        .filter_in(input_data),
        .filter_out(output_inverseSinc),
        .ce_out(ce_inverseSinc)
    );

    cic1 filter4 (
        .clk(clk),
        .clk_enable(ce_cic2),
        .reset(reset),
        .filter_in(output_inverseSinc),
        .filter_out(output_cic1),
        .ce_out(ce_cic1)
    );

    cic2 filter5 (
        .clk(clk),
        .clk_enable(ce_cic3),
        .reset(reset),
        .filter_in(output_cic1),
        .filter_out(output_cic2),
        .ce_out(ce_cic2)
    );

    cic3 filter6 (
        .clk(clk),
        .clk_enable(ce_cic4),
        .reset(reset),
        .filter_in(output_cic2),
        .filter_out(output_cic3),
        .ce_out(ce_cic3)
    );

    cic4 filter7 (
        .clk(clk),
        .clk_enable(clk_enable),
        .reset(reset),
        .filter_in(output_cic3),
        .filter_out(output_data),
        .ce_out(ce_cic4)
    );

    assign ce_out = ce_halfBandFirst;

endmodule
