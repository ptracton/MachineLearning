//                              -*- Mode: Verilog -*-
// Filename        : dtree_00.v
// Description     : Initial DTREE Test Case
// Author          : Philip Tracton
// Created On      : Wed May  1 20:39:48 2019
// Last Modified By: Philip Tracton
// Last Modified On: Wed May  1 20:39:48 2019
// Update Count    : 0
// Status          : Unknown, Use with caution!

module test_case (/*AUTOARG*/ ) ;
   //
   // Test Configuration
   // These parameters need to be set for each test case
   //
   parameter simulation_name = "multiply_00";
   parameter number_of_tests = 2;

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

      $display("DTREE 00 TEST CASE");
      @(negedge `WB_RST);
      repeat (100) @(posedge `WB_CLK);

      // Splits
      `CPU_WRITE_FILE_CONFIG(1, `WB_RAM1,       `WB_RAM1+(4*6), `WB_RAM1, `WB_RAM1, `B_CONTROL_DATA_SIZE_WORD);

      // Store out the tree configuration
      `DAQ_WRITES_FILE(1, 50);
      `DAQ_WRITES_FILE(1,  0);

      `DAQ_WRITES_FILE(1, 150);
      `DAQ_WRITES_FILE(1,  1<<31 | 2);

      `DAQ_WRITES_FILE(1, 250);
      `DAQ_WRITES_FILE(1,  1<<31 | 3);

      // Sensor 0
      `CPU_WRITE_FILE_CONFIG(2, `WB_RAM2,       `WB_RAM2+(4*4), `WB_RAM2, `WB_RAM2, `B_CONTROL_DATA_SIZE_WORD);
      `DAQ_WRITES_FILE(2, 51);
      `DAQ_WRITES_FILE(2, 51);
      `DAQ_WRITES_FILE(2, 49);
      `DAQ_WRITES_FILE(2, 49);

      // Sensor 1
      `CPU_WRITE_FILE_CONFIG(3, `WB_RAM3,       `WB_RAM3+(4*4), `WB_RAM3, `WB_RAM3, `B_CONTROL_DATA_SIZE_WORD);
      `DAQ_WRITES_FILE(3, 151);
      `DAQ_WRITES_FILE(3, 149);
      `DAQ_WRITES_FILE(3, 251);
      `DAQ_WRITES_FILE(3, 249);

      // Output File
      `CPU_WRITE_FILE_CONFIG(3, `WB_RAM3+16,    `WB_RAM3+16+(4*8), `WB_RAM3+16, `WB_RAM3+16, `B_CONTROL_DATA_SIZE_WORD);

      input0[`F_DSP_SLAVE_EQUATION_NUMBER] = `B_DSP_EQUATION_DTREE;
      input0[`F_DSP_SLAVE_EQUATION_START] = 1;
      input1[`F_DSP_SLAVE_INPUT_FILE0] = 1;
      input1[`F_DSP_SLAVE_INPUT_FILE1] = 2;
      input1[`F_DSP_SLAVE_INPUT_FILE2] = 3;
      input3[`F_DSP_SLAVE_OUTPUT_FILE0] = 4;

      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT1_OFFSET,   4'hF, input1);
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT3_OFFSET,   4'hF, input3);
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT0_OFFSET,   4'hF, input0);

      repeat (500) @(posedge `WB_CLK);

      `TEST_COMPLETE;
   end // initial begin

endmodule // test
