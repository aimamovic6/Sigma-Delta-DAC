//module sine_wave_generator(
    //input clk,            // Clock input (44.1 kHz)
    //input reset,          // Reset input
    //output reg signed [19:0] sine_out // 16-bit signed sine wave output
//);

    //reg [5:0] index; // 6-bit index for the LUT (0 to 43)

    //// Lookup table for one period of a 1 kHz sine wave sampled at 44.1 kHz
    //reg signed [19:0] sine_LUT [0:43];

////initial begin
        ////sine_LUT[0]  = 0;
        ////sine_LUT[1]  = 4663;
        ////sine_LUT[2]  = 9232;
        ////sine_LUT[3]  = 13612;
        ////sine_LUT[4]  = 17715;
        ////sine_LUT[5]  = 21458;
        ////sine_LUT[6]  = 24764;
        ////sine_LUT[7]  = 27565;
        ////sine_LUT[8]  = 29806;
        ////sine_LUT[9]  = 31440;
        ////sine_LUT[10] = 32433;
        ////sine_LUT[11] = 32767;
        ////sine_LUT[12] = 32433;
        ////sine_LUT[13] = 31440;
        ////sine_LUT[14] = 29806;
        ////sine_LUT[15] = 27565;
        ////sine_LUT[16] = 24764;
        ////sine_LUT[17] = 21458;
        ////sine_LUT[18] = 17715;
        ////sine_LUT[19] = 13612;
        ////sine_LUT[20] = 9232;
        ////sine_LUT[21] = 4663;
        ////sine_LUT[22] = 0;
        ////sine_LUT[23] = -4663;
        ////sine_LUT[24] = -9232;
        ////sine_LUT[25] = -13612;
        ////sine_LUT[26] = -17715;
        ////sine_LUT[27] = -21458;
        ////sine_LUT[28] = -24764;
        ////sine_LUT[29] = -27565;
        ////sine_LUT[30] = -29806;
        ////sine_LUT[31] = -31440;
        ////sine_LUT[32] = -32433;
        ////sine_LUT[33] = -32767;
        ////sine_LUT[34] = -32433;
        ////sine_LUT[35] = -31440;
        ////sine_LUT[36] = -29806;
        ////sine_LUT[37] = -27565;
        ////sine_LUT[38] = -24764;
        ////sine_LUT[39] = -21458;
        ////sine_LUT[40] = -17715;
        ////sine_LUT[41] = -13612;
        ////sine_LUT[42] = -9232;
        ////sine_LUT[43] = -4663;
    ////end


    //// Process to update the sine wave output
    //always @(posedge clk or posedge reset) begin
        //if (reset) begin
            //index <= 0;
            //sine_out <= 0;
        //end else begin
            //sine_out <= sine_LUT[index]; // Assign the sine wave value from LUT
            //index <= (index == 43) ? 0 : index + 1; // Increment index or reset to 0
        //end
    //end
//endmodule



module sine_wave_generator(
    input clk,            // Clock input (176 kHz)
    input reset,          // Reset input
    output reg signed [19:0] sine_out // 16-bit signed sine wave output
);

    reg [7:0] index; // 8-bit index for the LUT (0 to 175)

    // Lookup table for one period of a sine wave sampled at 44.1 kHz
    reg signed [19:0] sine_LUT [0:175];

    // Initialize the LUT with the new 176 samples
    initial begin
        sine_LUT[0]   = 0;
        sine_LUT[1]   = 1170;
        sine_LUT[2]   = 2338;
        sine_LUT[3]   = 3503;
        sine_LUT[4]   = 4663;
        sine_LUT[5]   = 5818;
        sine_LUT[6]   = 6965;
        sine_LUT[7]   = 8103;
        sine_LUT[8]   = 9232;
        sine_LUT[9]   = 10348;
        sine_LUT[10]  = 11451;
        sine_LUT[11]  = 12539;
        sine_LUT[12]  = 13612;
        sine_LUT[13]  = 14667;
        sine_LUT[14]  = 15704;
        sine_LUT[15]  = 16720;
        sine_LUT[16]  = 17715;
        sine_LUT[17]  = 18688;
        sine_LUT[18]  = 19637;
        sine_LUT[19]  = 20560;
        sine_LUT[20]  = 21458;
        sine_LUT[21]  = 22328;
        sine_LUT[22]  = 23170;
        sine_LUT[23]  = 23982;
        sine_LUT[24]  = 24764;
        sine_LUT[25]  = 25514;
        sine_LUT[26]  = 26231;
        sine_LUT[27]  = 26915;
        sine_LUT[28]  = 27565;
        sine_LUT[29]  = 28180;
        sine_LUT[30]  = 28759;
        sine_LUT[31]  = 29301;
        sine_LUT[32]  = 29806;
        sine_LUT[33]  = 30273;
        sine_LUT[34]  = 30701;
        sine_LUT[35]  = 31090;
        sine_LUT[36]  = 31440;
        sine_LUT[37]  = 31749;
        sine_LUT[38]  = 32018;
        sine_LUT[39]  = 32246;
        sine_LUT[40]  = 32433;
        sine_LUT[41]  = 32579;
        sine_LUT[42]  = 32684;
        sine_LUT[43]  = 32746;
        sine_LUT[44]  = 32767;
        sine_LUT[45]  = 32746;
        sine_LUT[46]  = 32684;
        sine_LUT[47]  = 32579;
        sine_LUT[48]  = 32433;
        sine_LUT[49]  = 32246;
        sine_LUT[50]  = 32018;
        sine_LUT[51]  = 31749;
        sine_LUT[52]  = 31440;
        sine_LUT[53]  = 31090;
        sine_LUT[54]  = 30701;
        sine_LUT[55]  = 30273;
        sine_LUT[56]  = 29806;
        sine_LUT[57]  = 29301;
        sine_LUT[58]  = 28759;
        sine_LUT[59]  = 28180;
        sine_LUT[60]  = 27565;
        sine_LUT[61]  = 26915;
        sine_LUT[62]  = 26231;
        sine_LUT[63]  = 25514;
        sine_LUT[64]  = 24764;
        sine_LUT[65]  = 23982;
        sine_LUT[66]  = 23170;
        sine_LUT[67]  = 22328;
        sine_LUT[68]  = 21458;
        sine_LUT[69]  = 20560;
        sine_LUT[70]  = 19637;
        sine_LUT[71]  = 18688;
        sine_LUT[72]  = 17715;
        sine_LUT[73]  = 16720;
        sine_LUT[74]  = 15704;
        sine_LUT[75]  = 14667;
        sine_LUT[76]  = 13612;
        sine_LUT[77]  = 12539;
        sine_LUT[78]  = 11451;
        sine_LUT[79]  = 10348;
        sine_LUT[80]  = 9232;
        sine_LUT[81]  = 8103;
        sine_LUT[82]  = 6965;
        sine_LUT[83]  = 5818;
        sine_LUT[84]  = 4663;
        sine_LUT[85]  = 3503;
        sine_LUT[86]  = 2338;
        sine_LUT[87]  = 1170;
        sine_LUT[88]  = 0;
        sine_LUT[89]  = -1170;
        sine_LUT[90]  = -2338;
        sine_LUT[91]  = -3503;
        sine_LUT[92]  = -4663;
        sine_LUT[93]  = -5818;
        sine_LUT[94]  = -6965;
        sine_LUT[95]  = -8103;
        sine_LUT[96]  = -9232;
        sine_LUT[97]  = -10348;
        sine_LUT[98]  = -11451;
        sine_LUT[99]  = -12539;
        sine_LUT[100] = -13612;
        sine_LUT[101] = -14667;
        sine_LUT[102] = -15704;
        sine_LUT[103] = -16720;
        sine_LUT[104] = -17715;
        sine_LUT[105] = -18688;
        sine_LUT[106] = -19637;
        sine_LUT[107] = -20560;
        sine_LUT[108] = -21458;
        sine_LUT[109] = -22328;
        sine_LUT[110] = -23170;
        sine_LUT[111] = -23982;
        sine_LUT[112] = -24764;
        sine_LUT[113] = -25514;
        sine_LUT[114] = -26231;
        sine_LUT[115] = -26915;
        sine_LUT[116] = -27565;
        sine_LUT[117] = -28180;
        sine_LUT[118] = -28759;
        sine_LUT[119] = -29301;
        sine_LUT[120] = -29806;
        sine_LUT[121] = -30273;
        sine_LUT[122] = -30701;
        sine_LUT[123] = -31090;
        sine_LUT[124] = -31440;
        sine_LUT[125] = -31749;
        sine_LUT[126] = -32018;
        sine_LUT[127] = -32246;
        sine_LUT[128] = -32433;
        sine_LUT[129] = -32579;
        sine_LUT[130] = -32684;
        sine_LUT[131] = -32746;
        sine_LUT[132] = -32767;
        sine_LUT[133] = -32746;
        sine_LUT[134] = -32684;
        sine_LUT[135] = -32579;
        sine_LUT[136] = -32433;
        sine_LUT[137] = -32246;
        sine_LUT[138] = -32018;
        sine_LUT[139] = -31749;
        sine_LUT[140] = -31440;
        sine_LUT[141] = -31090;
        sine_LUT[142] = -30701;
        sine_LUT[143] = -30273;
        sine_LUT[144] = -29806;
        sine_LUT[145] = -29301;
        sine_LUT[146] = -28759;
        sine_LUT[147] = -28180;
        sine_LUT[148] = -27565;
        sine_LUT[149] = -26915;
        sine_LUT[150] = -26231;
        sine_LUT[151] = -25514;
        sine_LUT[152] = -24764;
        sine_LUT[153] = -23982;
        sine_LUT[154] = -23170;
        sine_LUT[155] = -22328;
        sine_LUT[156] = -21458;
        sine_LUT[157] = -20560;
        sine_LUT[158] = -19637;
        sine_LUT[159] = -18688;
        sine_LUT[160] = -17715;
        sine_LUT[161] = -16720;
        sine_LUT[162] = -15704;
        sine_LUT[163] = -14667;
        sine_LUT[164] = -13612;
        sine_LUT[165] = -12539;
        sine_LUT[166] = -11451;
        sine_LUT[167] = -10348;
        sine_LUT[168] = -9232;
        sine_LUT[169] = -8103;
        sine_LUT[170] = -6965;
        sine_LUT[171] = -5818;
        sine_LUT[172] = -4663;
        sine_LUT[173] = -3503;
        sine_LUT[174] = -2338;
        sine_LUT[175] = -1170;
    end

    // Process to update the sine wave output
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            index <= 0;
            sine_out <= 0;
        end else begin
            sine_out <= sine_LUT[index]; // Assign the sine wave value from LUT
            index <= (index == 175) ? 0 : index + 1; // Increment index or reset to 0
        end
    end
endmodule
