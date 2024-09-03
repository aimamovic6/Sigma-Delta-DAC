module sine_wave_generator(
    input clk,            // Clock input (44.1 kHz)
    input reset,          // Reset input
    output reg signed [15:0] sine_out // 16-bit signed sine wave output
);

    reg [5:0] index; // 6-bit index for the LUT (0 to 43)

    // Lookup table for one period of a 1 kHz sine wave sampled at 44.1 kHz
    reg signed [15:0] sine_LUT [0:43];

initial begin
        sine_LUT[0]  = 0;
        sine_LUT[1]  = 4663;
        sine_LUT[2]  = 9232;
        sine_LUT[3]  = 13612;
        sine_LUT[4]  = 17715;
        sine_LUT[5]  = 21458;
        sine_LUT[6]  = 24764;
        sine_LUT[7]  = 27565;
        sine_LUT[8]  = 29806;
        sine_LUT[9]  = 31440;
        sine_LUT[10] = 32433;
        sine_LUT[11] = 32767;
        sine_LUT[12] = 32433;
        sine_LUT[13] = 31440;
        sine_LUT[14] = 29806;
        sine_LUT[15] = 27565;
        sine_LUT[16] = 24764;
        sine_LUT[17] = 21458;
        sine_LUT[18] = 17715;
        sine_LUT[19] = 13612;
        sine_LUT[20] = 9232;
        sine_LUT[21] = 4663;
        sine_LUT[22] = 0;
        sine_LUT[23] = -4663;
        sine_LUT[24] = -9232;
        sine_LUT[25] = -13612;
        sine_LUT[26] = -17715;
        sine_LUT[27] = -21458;
        sine_LUT[28] = -24764;
        sine_LUT[29] = -27565;
        sine_LUT[30] = -29806;
        sine_LUT[31] = -31440;
        sine_LUT[32] = -32433;
        sine_LUT[33] = -32767;
        sine_LUT[34] = -32433;
        sine_LUT[35] = -31440;
        sine_LUT[36] = -29806;
        sine_LUT[37] = -27565;
        sine_LUT[38] = -24764;
        sine_LUT[39] = -21458;
        sine_LUT[40] = -17715;
        sine_LUT[41] = -13612;
        sine_LUT[42] = -9232;
        sine_LUT[43] = -4663;
    end
    // Process to update the sine wave output
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            index <= 0;
            sine_out <= 0;
        end else begin
            sine_out <= sine_LUT[index]; // Assign the sine wave value from LUT
            index <= (index == 43) ? 0 : index + 1; // Increment index or reset to 0
        end
    end
endmodule
