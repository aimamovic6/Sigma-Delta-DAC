// -------------------------------------------------------------
//
// Module: cic1
// Generated by MATLAB(R) 23.2 and Filter Design HDL Coder 23.2.
// Generated on: 2024-12-02 22:27:23
// -------------------------------------------------------------

// -------------------------------------------------------------
// HDL Code Generation Options:
//
// OptimizeForHDL: on
// AddPipelineRegisters: on
// Name: cic1
// TargetLanguage: Verilog
// TestBenchName: cic1_tb
// TestBenchStimulus: noise 
// LoopUnrolling: on

// Filter Specifications:
//
// Sample Rate          : 705.6 kHz
// Response             : CIC
// Specification        : Fp,Ast
// Interpolation Factor : 2
// Multirate Type       : Interpolator
// Passband Edge        : 22.05 kHz
// Stopband Atten.      : 60 dB
// Differential Delay   : 1
// -------------------------------------------------------------

// -------------------------------------------------------------
// HDL Implementation    : Fully parallel
// -------------------------------------------------------------
// Filter Settings:
//
// Discrete-Time FIR Multirate Filter (real)
// -----------------------------------------
// Filter Structure      : Cascaded Integrator-Comb Interpolator
// Interpolation Factor  : 2
// Differential Delay    : 1
// Number of Sections    : 3
// Stable                : Yes
// Linear Phase          : Yes (Type 2)
//
// -------------------------------------------------------------




`timescale 1 ns / 1 ns

module cic1
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
  input   signed [17:0] filter_in; //sfix18_En16
  output  signed [18:0] filter_out; //sfix19_En17
  output  ce_out; 

////////////////////////////////////////////////////////////////
//Module Architecture: cic1
////////////////////////////////////////////////////////////////
  // Local Functions
  // Type Definitions
  // Constants
  parameter signed [17:0] zeroconst = 18'b000000000000000000; //sfix18_En15
  // Signals
  reg  [1:0] cur_count; // ufix2
  wire phase_0; // boolean
  //   
  reg  signed [17:0] input_register; // sfix18_En16
  //   -- Section 1 Signals 
  wire signed [17:0] section_in1; // sfix18_En16
  wire signed [17:0] section_cast1; // sfix18_En15
  reg  signed [17:0] diff1; // sfix18_En15
  wire signed [17:0] section_out1; // sfix18_En15
  wire signed [17:0] sub_cast; // sfix18_En15
  wire signed [17:0] sub_cast_1; // sfix18_En15
  wire signed [18:0] sub_temp; // sfix19_En15
  reg  signed [17:0] cic_pipeline1; // sfix18_En15
  //   -- Section 2 Signals 
  wire signed [17:0] section_in2; // sfix18_En15
  reg  signed [17:0] diff2; // sfix18_En15
  wire signed [17:0] section_out2; // sfix18_En15
  wire signed [17:0] sub_cast_2; // sfix18_En15
  wire signed [17:0] sub_cast_3; // sfix18_En15
  wire signed [18:0] sub_temp_1; // sfix19_En15
  reg  signed [17:0] cic_pipeline2; // sfix18_En15
  //   -- Section 3 Signals 
  wire signed [17:0] section_in3; // sfix18_En15
  reg  signed [17:0] diff3; // sfix18_En15
  wire signed [17:0] section_out3; // sfix18_En15
  wire signed [17:0] sub_cast_4; // sfix18_En15
  wire signed [17:0] sub_cast_5; // sfix18_En15
  wire signed [18:0] sub_temp_2; // sfix19_En15
  reg  signed [17:0] cic_pipeline3; // sfix18_En15
  wire signed [17:0] upsampling; // sfix18_En15
  //   -- Section 4 Signals 
  wire signed [17:0] section_in4; // sfix18_En15
  wire signed [17:0] sum1; // sfix18_En15
  reg  signed [17:0] section_out4; // sfix18_En15
  wire signed [17:0] add_cast; // sfix18_En15
  wire signed [17:0] add_cast_1; // sfix18_En15
  wire signed [18:0] add_temp; // sfix19_En15
  //   -- Section 5 Signals 
  wire signed [17:0] section_in5; // sfix18_En15
  wire signed [17:0] sum2; // sfix18_En15
  reg  signed [17:0] section_out5; // sfix18_En15
  wire signed [17:0] add_cast_2; // sfix18_En15
  wire signed [17:0] add_cast_3; // sfix18_En15
  wire signed [18:0] add_temp_1; // sfix19_En15
  //   -- Section 6 Signals 
  wire signed [17:0] section_in6; // sfix18_En15
  wire signed [17:0] sum3; // sfix18_En15
  reg  signed [17:0] section_out6; // sfix18_En15
  wire signed [17:0] add_cast_4; // sfix18_En15
  wire signed [17:0] add_cast_5; // sfix18_En15
  wire signed [18:0] add_temp_2; // sfix19_En15
  wire signed [18:0] output_typeconvert; // sfix19_En17
  //   
  reg  signed [18:0] output_register; // sfix19_En17

  // Block Statements
  //   ------------------ CE Output Generation ------------------

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

  assign  phase_0 = (cur_count == 2'b01 && clk_enable == 1'b1) ? 1'b1 : 1'b0;

  //   ------------------ Input Register ------------------

  always @ (posedge clk or posedge reset)
    begin: input_reg_process
      if (reset == 1'b1) begin
        input_register <= 0;
      end
      else begin
        if (phase_0 == 1'b1) begin
          input_register <= filter_in;
        end
      end
    end // input_reg_process

  //   ------------------ Section # 1 : Comb ------------------

  assign section_in1 = input_register;

  assign section_cast1 = $signed({{1{section_in1[17]}}, section_in1[17:1]});

  assign sub_cast = section_cast1;
  assign sub_cast_1 = diff1;
  assign sub_temp = sub_cast - sub_cast_1;
  assign section_out1 = sub_temp[17:0];

  always @ (posedge clk or posedge reset)
    begin: comb_delay_section1
      if (reset == 1'b1) begin
        diff1 <= 0;
      end
      else begin
        if (phase_0 == 1'b1) begin
          diff1 <= section_cast1;
        end
      end
    end // comb_delay_section1

  always @ (posedge clk or posedge reset)
    begin: cic_pipeline_process_section1
      if (reset == 1'b1) begin
        cic_pipeline1 <= 0;
      end
      else begin
        if (phase_0 == 1'b1) begin
          cic_pipeline1 <= section_out1;
        end
      end
    end // cic_pipeline_process_section1

  //   ------------------ Section # 2 : Comb ------------------

  assign section_in2 = cic_pipeline1;

  assign sub_cast_2 = section_in2;
  assign sub_cast_3 = diff2;
  assign sub_temp_1 = sub_cast_2 - sub_cast_3;
  assign section_out2 = sub_temp_1[17:0];

  always @ (posedge clk or posedge reset)
    begin: comb_delay_section2
      if (reset == 1'b1) begin
        diff2 <= 0;
      end
      else begin
        if (phase_0 == 1'b1) begin
          diff2 <= section_in2;
        end
      end
    end // comb_delay_section2

  always @ (posedge clk or posedge reset)
    begin: cic_pipeline_process_section2
      if (reset == 1'b1) begin
        cic_pipeline2 <= 0;
      end
      else begin
        if (phase_0 == 1'b1) begin
          cic_pipeline2 <= section_out2;
        end
      end
    end // cic_pipeline_process_section2

  //   ------------------ Section # 3 : Comb ------------------

  assign section_in3 = cic_pipeline2;

  assign sub_cast_4 = section_in3;
  assign sub_cast_5 = diff3;
  assign sub_temp_2 = sub_cast_4 - sub_cast_5;
  assign section_out3 = sub_temp_2[17:0];

  always @ (posedge clk or posedge reset)
    begin: comb_delay_section3
      if (reset == 1'b1) begin
        diff3 <= 0;
      end
      else begin
        if (phase_0 == 1'b1) begin
          diff3 <= section_in3;
        end
      end
    end // comb_delay_section3

  always @ (posedge clk or posedge reset)
    begin: cic_pipeline_process_section3
      if (reset == 1'b1) begin
        cic_pipeline3 <= 0;
      end
      else begin
        if (phase_0 == 1'b1) begin
          cic_pipeline3 <= section_out3;
        end
      end
    end // cic_pipeline_process_section3

  assign upsampling = (phase_0 == 1'b1) ? cic_pipeline3 :
                zeroconst;
  //   ------------------ Section # 4 : Integrator ------------------

  assign section_in4 = upsampling;

  assign add_cast = section_in4;
  assign add_cast_1 = section_out4;
  assign add_temp = add_cast + add_cast_1;
  assign sum1 = add_temp[17:0];

  always @ (posedge clk or posedge reset)
    begin: integrator_delay_section4
      if (reset == 1'b1) begin
        section_out4 <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          section_out4 <= sum1;
        end
      end
    end // integrator_delay_section4

  //   ------------------ Section # 5 : Integrator ------------------

  assign section_in5 = section_out4;

  assign add_cast_2 = section_in5;
  assign add_cast_3 = section_out5;
  assign add_temp_1 = add_cast_2 + add_cast_3;
  assign sum2 = add_temp_1[17:0];

  always @ (posedge clk or posedge reset)
    begin: integrator_delay_section5
      if (reset == 1'b1) begin
        section_out5 <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          section_out5 <= sum2;
        end
      end
    end // integrator_delay_section5

  //   ------------------ Section # 6 : Integrator ------------------

  assign section_in6 = section_out5;

  assign add_cast_4 = section_in6;
  assign add_cast_5 = section_out6;
  assign add_temp_2 = add_cast_4 + add_cast_5;
  assign sum3 = add_temp_2[17:0];

  always @ (posedge clk or posedge reset)
    begin: integrator_delay_section6
      if (reset == 1'b1) begin
        section_out6 <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          section_out6 <= sum3;
        end
      end
    end // integrator_delay_section6

  assign output_typeconvert = $signed({section_out6[16:0], 2'b00});

  //   ------------------ Output Register ------------------

  always @ (posedge clk or posedge reset)
    begin: output_reg_process
      if (reset == 1'b1) begin
        output_register <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          output_register <= output_typeconvert;
        end
      end
    end // output_reg_process

  // Assignment Statements
  assign ce_out = phase_0;
  assign filter_out = output_register;
endmodule  // cic1
