module clk_divider(
    input clk_in,     // 128x44.1 kHz input clock (5.6448 MHz)
    input reset,      // Reset signal
    output reg clk_out // Divided clock output (44.1 kHz)
);

    reg [6:0] counter; // 7-bit counter to count up to 128

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            counter <= 7'd0;
            clk_out <= 1'b0;
        end else if (counter == 7'd63) begin
            counter <= 7'd0;
            clk_out <= ~clk_out; // Toggle clock output every 128 cycles
        end else begin
            counter <= counter + 7'd1;
        end
    end
endmodule
