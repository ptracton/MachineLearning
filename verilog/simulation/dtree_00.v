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
   reg [31:0] input2;

   reg [31:0] daq_read;
   reg [31:0] cpu_read;
   reg [31:0] debug_reg;

   initial begin
      daq_read = 0;
      input0 = 0;
      input1 = 0;
      input2 = 0;

      $display("DTREE 00 TEST CASE");
      @(negedge `WB_RST);
      repeat (100) @(posedge `WB_CLK);

      // Splits
      `CPU_WRITE_FILE_CONFIG(1, `WB_RAM1,       `WB_RAM1+(4*6), `WB_RAM1, `WB_RAM1, `B_CONTROL_DATA_SIZE_WORD);

      // Sensor 0
      `CPU_WRITE_FILE_CONFIG(2, `WB_RAM2,       `WB_RAM2+(4*4), `WB_RAM2, `WB_RAM2, `B_CONTROL_DATA_SIZE_WORD);

      // Sensor 1
      `CPU_WRITE_FILE_CONFIG(3, `WB_RAM3,       `WB_RAM3+(4*4), `WB_RAM3, `WB_RAM3, `B_CONTROL_DATA_SIZE_WORD);

      repeat (500) @(posedge `WB_CLK);

      `TEST_COMPLETE;
   end // initial begin

endmodule // test
