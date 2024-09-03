// -------------------------------------------------------------
//
// Module: halfBandSecond
// Generated by MATLAB(R) 23.2 and Filter Design HDL Coder 23.2.
// Generated on: 2024-05-02 14:30:42
// -------------------------------------------------------------

// -------------------------------------------------------------
// HDL Code Generation Options:
//
// FIRAdderStyle: tree
// OptimizeForHDL: on
// TargetDirectory: D:\fax\zavrsni\halfBandSecond
// AddPipelineRegisters: on
// Name: halfBandSecond
// TargetLanguage: Verilog
// TestBenchName: halfband2_tb
// TestBenchStimulus: step chirp 
// TestBenchUserStimulus:  User data, length 200
// LoopUnrolling: on

// Filter Specifications:
//
// Sample Rate          : 176.4 kHz
// Response             : Halfband
// Specification        : N,TW
// Interpolation Factor : 2
// Multirate Type       : Interpolator
// Transition Width     : 44.05 kHz
// Type                 : Lowpass
// Filter Order         : 22
// -------------------------------------------------------------

// -------------------------------------------------------------
// HDL Implementation    : Fully parallel
// Folding Factor        : 1
// -------------------------------------------------------------
// Filter Settings:
//
// Discrete-Time FIR Multirate Filter (real)
// -----------------------------------------
// Filter Structure      : Direct-Form FIR Polyphase Interpolator
// Interpolation Factor  : 2
// Polyphase Length      : 12
// Filter Length         : 23
// Stable                : Yes
// Linear Phase          : Yes (Type 1)
//
// Arithmetic            : fixed
// Numerator             : s20,18 -> [-2 2)
// -------------------------------------------------------------
`timescale 1 ns / 1 ns

module halfBandSecond
               (
                clk,
                clk_enable,
                reset,
                filter_in,
                filter_out,
                ce_out
                );

  input   clk; 
  input   clk_enable; 
  input   reset; 
  input   signed [20:0] filter_in; //sfix21_En15
  output  signed [19:0] filter_out; //sfix20_En15
  output  ce_out; 

////////////////////////////////////////////////////////////////
//Module Architecture: halfBandSecond
////////////////////////////////////////////////////////////////
  // Local Functions
  // Type Definitions
  // Constants
  parameter signed [19:0] coeffphase1_7 = 20'b00100111100110110101; //sfix20_En18
  parameter signed [19:0] coeffphase1_8 = 20'b11110101100000001111; //sfix20_En18
  parameter signed [19:0] coeffphase1_9 = 20'b00000011111010011110; //sfix20_En18
  parameter signed [19:0] coeffphase1_10 = 20'b11111110101100101010; //sfix20_En18
  parameter signed [19:0] coeffphase1_11 = 20'b00000000010100101001; //sfix20_En18
  parameter signed [19:0] coeffphase1_12 = 20'b11111111111101001001; //sfix20_En18

  parameter signed [19:0] coeffphase2_6 = 20'b01000000000000000000; //sfix20_En18

  // Signals
  reg  [1:0] cur_count; // ufix2
  wire phase_1; // boolean
  reg  signed [20:0] delay_pipeline [0:11] ; // sfix21_En15
  
   wire signed [41:0] product; // sfix38_En35
   wire signed [41:0] product_1; // sfix38_En35
   wire signed [41:0] product_2; // sfix38_En35
   wire signed [41:0] product_3; // sfix38_En35
   wire signed [41:0] product_4; // sfix38_En35
   wire signed [41:0] product_5; // sfix38_En35
   wire signed [41:0] product_6; // sfix38_En35
   wire signed [44:0] sumvector1 [0:5] ; // sfix45_En33
 
   wire signed [21:0] add_temp; // sfix42_En33
   wire signed [21:0] add_temp_1; // sfix42_En33
   wire signed [21:0] add_temp_2; // sfix42_En33
   wire signed [21:0] add_temp_3; // sfix42_En33
   wire signed [21:0] add_temp_4; // sfix42_En33
   wire signed [21:0] add_temp_5; // sfix42_En33  
  
  reg  signed [44:0] sumdelay_pipeline1 [0:5] ; // sfix45_En33
  wire signed [44:0] sumvector2 [0:2] ; // sfix45_En33
  wire signed [44:0] add_signext_12; // sfix45_En33
  wire signed [44:0] add_signext_13; // sfix45_En33
  wire signed [45:0] add_temp_6; // sfix46_En33
  wire signed [44:0] add_signext_14; // sfix45_En33
  wire signed [44:0] add_signext_15; // sfix45_En33
  wire signed [45:0] add_temp_7; // sfix46_En33
  wire signed [44:0] add_signext_16; // sfix45_En33
  wire signed [44:0] add_signext_17; // sfix45_En33
  wire signed [45:0] add_temp_8; // sfix46_En33
  reg  signed [44:0] sumdelay_pipeline2 [0:2] ; // sfix45_En33
  wire signed [44:0] sumvector3 [0:1] ; // sfix45_En33
  wire signed [44:0] add_signext_18; // sfix45_En33
  wire signed [44:0] add_signext_19; // sfix45_En33
  wire signed [45:0] add_temp_9; // sfix46_En33
  reg  signed [44:0] sumdelay_pipeline3 [0:1] ; // sfix45_En33
  wire signed [44:0] sum4; // sfix45_En33
  wire signed [44:0] add_signext_20; // sfix45_En33
  wire signed [44:0] add_signext_21; // sfix45_En33
  wire signed [45:0] add_temp_10; // sfix46_En33
  wire signed [19:0] output_typeconvert; // sfix20_En15
  reg  signed [19:0] output_register; // sfix20_En15

  // Block Statements
  always @ (posedge clk or posedge reset)
    begin: ce_output
      if (reset == 1'b1) begin
        cur_count <= 2'b00;
      end
      else begin
        if (clk_enable == 1'b1) begin
          if (cur_count >= 2'b01) begin
            cur_count <= 2'b00;
          end
          else begin
            cur_count <= cur_count + 2'b01;
          end
        end
      end
    end // ce_output

  assign  phase_1 = (cur_count == 2'b01 && clk_enable == 1'b1) ? 1'b1 : 1'b0;

  //   ---------------- Delay Registers ----------------

  always @( posedge clk or posedge reset)
    begin: Delay_Pipeline_process
      if (reset == 1'b1) begin
        delay_pipeline[0] <= 0;
        delay_pipeline[1] <= 0;
        delay_pipeline[2] <= 0;
        delay_pipeline[3] <= 0;
        delay_pipeline[4] <= 0;
        delay_pipeline[5] <= 0;
        delay_pipeline[6] <= 0;
        delay_pipeline[7] <= 0;
        delay_pipeline[8] <= 0;
        delay_pipeline[9] <= 0;
        delay_pipeline[10] <= 0;
        delay_pipeline[11] <= 0;
      end
      else begin
        if (phase_1 == 1'b1) begin
          delay_pipeline[0] <= filter_in;
          delay_pipeline[1] <= delay_pipeline[0];
          delay_pipeline[2] <= delay_pipeline[1];
          delay_pipeline[3] <= delay_pipeline[2];
          delay_pipeline[4] <= delay_pipeline[3];
          delay_pipeline[5] <= delay_pipeline[4];
          delay_pipeline[6] <= delay_pipeline[5];
          delay_pipeline[7] <= delay_pipeline[6];
          delay_pipeline[8] <= delay_pipeline[7];
          delay_pipeline[9] <= delay_pipeline[8];
          delay_pipeline[10] <= delay_pipeline[9];
          delay_pipeline[11] <= delay_pipeline[10];
        end
      end
    end // Delay_Pipeline_process


   assign add_temp = delay_pipeline[0] + delay_pipeline[11];
   assign add_temp_1 = delay_pipeline[1] + delay_pipeline[10];
   assign add_temp_2 = delay_pipeline[2] + delay_pipeline[9];
   assign add_temp_3 = delay_pipeline[3] + delay_pipeline[8];
   assign add_temp_4 = delay_pipeline[4] + delay_pipeline[7];
   assign add_temp_5 = delay_pipeline[5] + delay_pipeline[6];
   
   assign product = (cur_count == 2'b00) ? add_temp * coeffphase1_12 : 0;  
   assign product_1 = (cur_count == 2'b00) ? add_temp_1 * coeffphase1_11 : 0;
   assign product_2 = (cur_count == 2'b00) ? add_temp_2 * coeffphase1_10 : 0;
   assign product_3 = (cur_count == 2'b00) ? add_temp_3 * coeffphase1_9 : 0;  
   assign product_4 = (cur_count == 2'b00) ? add_temp_4 * coeffphase1_8 : 0;  
   assign product_5 = (cur_count == 2'b00) ? add_temp_5 * coeffphase1_7 : coeffphase2_6 * delay_pipeline[5];

  assign sumvector1[0] = $signed({{3{product[41]}}, product});
  assign sumvector1[1] = $signed({{3{product_1[41]}}, product_1});													  
  assign sumvector1[2] = $signed({{3{product_2[41]}}, product_2});													  
  assign sumvector1[3] = $signed({{3{product_3[41]}}, product_3});													  
  assign sumvector1[4] = $signed({{3{product_4[41]}}, product_4});													  
  assign sumvector1[5] = $signed({{3{product_5[41]}}, product_5});

  always @ (posedge clk or posedge reset)
    begin: sumdelay_pipeline_process1
      if (reset == 1'b1) begin
        sumdelay_pipeline1[0] <= 0;
        sumdelay_pipeline1[1] <= 0;
        sumdelay_pipeline1[2] <= 0;
        sumdelay_pipeline1[3] <= 0;
        sumdelay_pipeline1[4] <= 0;
        sumdelay_pipeline1[5] <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          sumdelay_pipeline1[0] <= sumvector1[0];
          sumdelay_pipeline1[1] <= sumvector1[1];
          sumdelay_pipeline1[2] <= sumvector1[2];
          sumdelay_pipeline1[3] <= sumvector1[3];
          sumdelay_pipeline1[4] <= sumvector1[4];
          sumdelay_pipeline1[5] <= sumvector1[5];
        end
      end
    end // sumdelay_pipeline_process1

  assign add_signext_12 = sumdelay_pipeline1[0];
  assign add_signext_13 = sumdelay_pipeline1[1];
  assign add_temp_6 = add_signext_12 + add_signext_13;
  assign sumvector2[0] = ((add_temp_6[45] == 1'b0 & add_temp_6[44] != 1'b0) || (add_temp_6[45] == 1'b0 && add_temp_6[44:0] == 45'b011111111111111111111111111111111111111111111) // special case0
) ? 45'b011111111111111111111111111111111111111111111 : 
      (add_temp_6[45] == 1'b1 && add_temp_6[44] != 1'b1) ? 45'b100000000000000000000000000000000000000000000 : add_temp_6[44:0];

  assign add_signext_14 = sumdelay_pipeline1[2];
  assign add_signext_15 = sumdelay_pipeline1[3];
  assign add_temp_7 = add_signext_14 + add_signext_15;
  assign sumvector2[1] = ((add_temp_7[45] == 1'b0 & add_temp_7[44] != 1'b0) || (add_temp_7[45] == 1'b0 && add_temp_7[44:0] == 45'b011111111111111111111111111111111111111111111) // special case0
) ? 45'b011111111111111111111111111111111111111111111 : 
      (add_temp_7[45] == 1'b1 && add_temp_7[44] != 1'b1) ? 45'b100000000000000000000000000000000000000000000 : add_temp_7[44:0];

  assign add_signext_16 = sumdelay_pipeline1[4];
  assign add_signext_17 = sumdelay_pipeline1[5];
  assign add_temp_8 = add_signext_16 + add_signext_17;
  assign sumvector2[2] = ((add_temp_8[45] == 1'b0 & add_temp_8[44] != 1'b0) || (add_temp_8[45] == 1'b0 && add_temp_8[44:0] == 45'b011111111111111111111111111111111111111111111) // special case0
) ? 45'b011111111111111111111111111111111111111111111 : 
      (add_temp_8[45] == 1'b1 && add_temp_8[44] != 1'b1) ? 45'b100000000000000000000000000000000000000000000 : add_temp_8[44:0];

  always @ (posedge clk or posedge reset)
    begin: sumdelay_pipeline_process2
      if (reset == 1'b1) begin
        sumdelay_pipeline2[0] <= 0;
        sumdelay_pipeline2[1] <= 0;
        sumdelay_pipeline2[2] <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          sumdelay_pipeline2[0] <= sumvector2[0];
          sumdelay_pipeline2[1] <= sumvector2[1];
          sumdelay_pipeline2[2] <= sumvector2[2];
        end
      end
    end // sumdelay_pipeline_process2

  assign add_signext_18 = sumdelay_pipeline2[0];
  assign add_signext_19 = sumdelay_pipeline2[1];
  assign add_temp_9 = add_signext_18 + add_signext_19;
  assign sumvector3[0] = ((add_temp_9[45] == 1'b0 & add_temp_9[44] != 1'b0) || (add_temp_9[45] == 1'b0 && add_temp_9[44:0] == 45'b011111111111111111111111111111111111111111111) // special case0
) ? 45'b011111111111111111111111111111111111111111111 : 
      (add_temp_9[45] == 1'b1 && add_temp_9[44] != 1'b1) ? 45'b100000000000000000000000000000000000000000000 : add_temp_9[44:0];

  assign sumvector3[1] = sumdelay_pipeline2[2];

  always @ (posedge clk or posedge reset)
    begin: sumdelay_pipeline_process3
      if (reset == 1'b1) begin
        sumdelay_pipeline3[0] <= 0;
        sumdelay_pipeline3[1] <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          sumdelay_pipeline3[0] <= sumvector3[0];
          sumdelay_pipeline3[1] <= sumvector3[1];
        end
      end
    end // sumdelay_pipeline_process3

  assign add_signext_20 = sumdelay_pipeline3[0];
  assign add_signext_21 = sumdelay_pipeline3[1];
  assign add_temp_10 = add_signext_20 + add_signext_21;
  assign sum4 = ((add_temp_10[45] == 1'b0 & add_temp_10[44] != 1'b0) || (add_temp_10[45] == 1'b0 && add_temp_10[44:0] == 45'b011111111111111111111111111111111111111111111) // special case0
) ? 45'b011111111111111111111111111111111111111111111 : 
      (add_temp_10[45] == 1'b1 && add_temp_10[44] != 1'b1) ? 45'b100000000000000000000000000000000000000000000 : add_temp_10[44:0];

  assign output_typeconvert = ((sum4[44] == 1'b0 & sum4[43:37] != 7'b0000000) || (sum4[44] == 1'b0 && sum4[37:18] == 20'b01111111111111111111) // special case0
) ? 20'b01111111111111111111 : 
      (sum4[44] == 1'b1 && sum4[43:37] != 7'b1111111) ? 20'b10000000000000000000 : (sum4[37:0] + {sum4[18], {17{~sum4[18]}}})>>>18;

  always @ (posedge clk or posedge reset)
    begin: Output_Register_process
      if (reset == 1'b1) begin
        output_register <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          output_register <= output_typeconvert;
        end
      end
    end // Output_Register_process

  // Assignment Statements
  assign ce_out = phase_1;
  assign filter_out = output_register;
endmodule  // halfBandSecond
