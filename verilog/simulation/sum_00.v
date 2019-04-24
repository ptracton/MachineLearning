//                              -*- Mode: Verilog -*-
// Filename        : basic_00.v
// Description     : Basic Function Test Case
// Author          : Phil Tracton
// Created On      : Mon Apr 15 17:10:49 2019
// Last Modified By: Phil Tracton
// Last Modified On: Mon Apr 15 17:10:49 2019
// Update Count    : 0
// Status          : Unknown, Use with caution!
module test_case (/*AUTOARG*/ ) ;
`include "dsp_includes.vh"

   //
   // Test Configuration
   // These parameters need to be set for each test case
   //
   parameter simulation_name = "sum_00";
   parameter number_of_tests = 89;

   integer i;
   reg [31:0] input0;
   reg [31:0] input1;
   reg [31:0] input3;

   reg [31:0] daq_read;
   reg [31:0] cpu_read;
   reg [31:0] debug_reg;

   initial begin
      daq_read = 0;
      input0 = 0;
      input1 = 0;
      input3 = 0;

      $display("Basic Sum Case");
      @(negedge `WB_RST);
      repeat (100) @(posedge `WB_CLK);

      // File 1 is input data to sum
      //                    FILE  START    END             RD        WR        CONTROL
      `CPU_WRITE_FILE_CONFIG(1, `WB_RAM2, `WB_RAM2+(4*8), `WB_RAM2, `WB_RAM2, `B_CONTROL_DATA_SIZE_WORD);
      // File 2 is the output file
      `CPU_WRITE_FILE_CONFIG(2, `WB_RAM3, `WB_RAM3+(4*8), `WB_RAM3, `WB_RAM3, `B_CONTROL_DATA_SIZE_WORD);

      repeat (500) @(posedge `WB_CLK);

      $display("\n\nLoading 32 bit data via DAQ @d", $time);
      for (i=0; i< 5; i=i+1) begin
         `DAQ_WRITES_FILE(1,  32'h0+i);  //16 bit writes
      end

      input0[`F_DSP_SLAVE_EQUATION_NUMBER] = `B_DSP_EQUATION_SUM;
      input0[`F_DSP_SLAVE_DATA_SIZE] = `B_CONTROL_DATA_SIZE_WORD;
      input0[`F_DSP_SLAVE_DATA_SIGNED] = 0;
      input0[`F_DSP_SLAVE_EQUATION_START] = 1;
      input1[`F_DSP_SLAVE_INPUT_FILE0] = 1;
      input3[`F_DSP_SLAVE_OUTPUT_FILE0] = 2;

      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT1_OFFSET,   4'hF, input1);
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT3_OFFSET,   4'hF, input3);
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT0_OFFSET,   4'hF, input0);

      repeat (2000) @(posedge `WB_CLK);

      $display("\n\nLoading 32 bit data via DAQ @d", $time);
      for (i=20; i< 25; i=i+1) begin
         `DAQ_WRITES_FILE(1,  32'h0+i);  //16 bit writes
      end
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT0_OFFSET,   4'hF, input0);
      repeat (2000) @(posedge `WB_CLK);

      `TEST_COMPLETE;
   end

endmodule // test_case
