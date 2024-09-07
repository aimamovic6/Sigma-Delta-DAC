module clk_divider(
    input clk_in,     // 128x44.1 kHz input clock (5.6448 MHz)
    input reset,      // Reset signal
    output reg clk_out, // (44.1 kHz)
    output reg clk_out_1 // (176 kHz)
);

    reg [6:0] counter;
    reg [4:0] counter1;

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            counter <= 7'd0;
            clk_out <= 1'b0;
            counter1 <= 5'd0;
            clk_out_1 <= 1'b0;
        end else begin
            // 44.1 kHz output
            if (counter == 7'd63) begin
                counter <= 7'd0;
                clk_out <= ~clk_out;
            end else begin
                counter <= counter + 7'd1;
            end

            // 176 kHz output
            if (counter1 == 5'd15) begin
                counter1 <= 5'd0;
                clk_out_1 <= ~clk_out_1;
            end else begin
                counter1 <= counter1 + 5'd1;
            end
        end
    end
endmodule
