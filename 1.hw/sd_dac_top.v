module sd_dac_top(
    input         clk,
    input         reset,
    input  signed [15:0] input_data,
    output signed [15:0] output_data
);

    wire clk_enable;
    wire ce_out;


    assign clk_enable = 1'b1;


    interpolatingFilter u_interpolatingFilter (
        .clk(clk),
        .clk_enable(clk_enable),
        .reset(reset),
        .input_data(input_data),
        .output_data(output_data),
        .ce_out(ce_out)
    );




endmodule
