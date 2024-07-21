module interpolatingFilter(

    input         clk,
    input         clk_enable,
    input         reset,
    input  signed [15:0] input_data,
    output signed [15:0] output_data,
    output        ce_out
);

    wire signed [20:0] output_halfBandFirst;
    wire signed [19:0] output_halfBandSecond;
    wire signed [17:0] output_invSincSpec;
    wire signed [18:0] output_cic1;
    wire signed [17:0] output_cic2;
    wire signed [16:0] output_cic3;
    //wire              ce_halfBandFirst;
    wire              ce_halfBandSecond;
    wire              ce_invSincSpec;
    wire              ce_cic1;
    wire              ce_cic2;
    wire              ce_cic3;
    wire              ce_cic4;

    //halfBandFirst filter1 (
        //.clk(clk),
        //.clk_enable(ce_halfBandSecond),
        //.reset(reset),
        //.filter_in(input_data),
        //.filter_out(output_halfBandFirst),
        //.ce_out(ce_halfBandFirst)
    //);
    assign output_halfBandFirst = input_data;
    halfBandSecond filter2 (
        .clk(clk),
        .clk_enable(ce_invSincSpec),
        .reset(reset),
        .filter_in(output_halfBandFirst),
        .filter_out(output_halfBandSecond),
        .ce_out(ce_halfBandSecond)
    );
    //assign output_halfBandSecond = filter_in;
    invSincSpec filter3 (
        .clk(clk),
        .clk_enable(ce_cic1),
        .reset(reset),
        .filter_in(output_halfBandSecond),
        .filter_out(output_invSincSpec),
        .ce_out(ce_invSincSpec)
    );
    //assign output_invSincSpec = filter_in;
    cic1 filter4 (
        .clk(clk),
        .clk_enable(ce_cic2),
        .reset(reset),
        .filter_in(output_invSincSpec),
        .filter_out(output_cic1),
        .ce_out(ce_cic1)
    );
   // assign output_cic1 = filter_in;
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

    assign ce_out = ce_invSincSpec;

endmodule
