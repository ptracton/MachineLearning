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
   parameter number_of_tests = 7;

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
      `DAQ_WRITES_FILE(1, 100);
      `DAQ_WRITES_FILE(1,  0);

      `DAQ_WRITES_FILE(1, 200);
      `DAQ_WRITES_FILE(1,  1<<31 | 2);

      `DAQ_WRITES_FILE(1, 300);
      `DAQ_WRITES_FILE(1,  1<<31 | 3);

      // Sensor 0
      `CPU_WRITE_FILE_CONFIG(2, `WB_RAM2,       `WB_RAM2+(4*4), `WB_RAM2, `WB_RAM2, `B_CONTROL_DATA_SIZE_WORD);
      `DAQ_WRITES_FILE(2, 50);
      `DAQ_WRITES_FILE(2, 60);
      `DAQ_WRITES_FILE(2, 150);
      `DAQ_WRITES_FILE(2, 160);

      // Sensor 1
      `CPU_WRITE_FILE_CONFIG(3, `WB_RAM3,       `WB_RAM3+(4*4), `WB_RAM3, `WB_RAM3, `B_CONTROL_DATA_SIZE_WORD);
      `DAQ_WRITES_FILE(3,  55);
      `DAQ_WRITES_FILE(3, 255);
      `DAQ_WRITES_FILE(3, 265);
      `DAQ_WRITES_FILE(3, 355);

      // Output File DTREE
      `CPU_WRITE_FILE_CONFIG(4, `WB_RAM3+16,       `WB_RAM3+16+(4*8), `WB_RAM3+16, `WB_RAM3+16, `B_CONTROL_DATA_SIZE_WORD);
      // Output File SUM
      `CPU_WRITE_FILE_CONFIG(5, `WB_RAM3+16+(4*8), `WB_RAM3+16+(4*9), `WB_RAM3+16+(4*8), `WB_RAM3+16+(4*8), `B_CONTROL_DATA_SIZE_WORD);

      input0[`F_DSP_SLAVE_EQUATION_NUMBER] = `B_DSP_EQUATION_DTREE;
      input0[`F_DSP_SLAVE_EQUATION_START] = 1;
      input1[`F_DSP_SLAVE_INPUT_FILE0] = 1;
      input1[`F_DSP_SLAVE_INPUT_FILE1] = 2;
      input1[`F_DSP_SLAVE_INPUT_FILE2] = 3;
      input3[`F_DSP_SLAVE_OUTPUT_FILE0] = 4;

      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT1_OFFSET,   4'hF, input1);
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT3_OFFSET,   4'hF, input3);
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT0_OFFSET,   4'hF, input0);

      @(posedge `DSP_EQUATION_DTREE.equation_done);
      repeat (300) @(posedge `WB_CLK);


      input0[`F_DSP_SLAVE_EQUATION_NUMBER] = 0;
      input0[`F_DSP_SLAVE_EQUATION_START] = 0;
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT0_OFFSET,   4'hF, input0);
      repeat (300) @(posedge `WB_CLK);

      input0[`F_DSP_SLAVE_EQUATION_NUMBER] = `B_DSP_EQUATION_DTREE;
      input0[`F_DSP_SLAVE_EQUATION_START] = 1;
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT0_OFFSET,   4'hF, input0);

      @(posedge `DSP_EQUATION_DTREE.equation_done);
      repeat (300) @(posedge `WB_CLK);

      input0[`F_DSP_SLAVE_EQUATION_NUMBER] = 0;
      input0[`F_DSP_SLAVE_EQUATION_START] = 0;
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT0_OFFSET,   4'hF, input0);
      repeat (300) @(posedge `WB_CLK);


      input0[`F_DSP_SLAVE_EQUATION_NUMBER] = `B_DSP_EQUATION_DTREE;
      input0[`F_DSP_SLAVE_EQUATION_START] = 1;
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT0_OFFSET,   4'hF, input0);
      @(posedge `DSP_EQUATION_DTREE.equation_done);
      repeat (300) @(posedge `WB_CLK);

      input0[`F_DSP_SLAVE_EQUATION_NUMBER] = 0;
      input0[`F_DSP_SLAVE_EQUATION_START] = 0;
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT0_OFFSET,   4'hF, input0);
      repeat (300) @(posedge `WB_CLK);


      input0[`F_DSP_SLAVE_EQUATION_NUMBER] = `B_DSP_EQUATION_DTREE;
      input0[`F_DSP_SLAVE_EQUATION_START] = 1;
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT0_OFFSET,   4'hF, input0);

      @(posedge `DSP_EQUATION_DTREE.equation_done);
      repeat (300) @(posedge `WB_CLK);

      input0[`F_DSP_SLAVE_EQUATION_NUMBER] = 0;
      input0[`F_DSP_SLAVE_EQUATION_START] = 0;
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT0_OFFSET,   4'hF, input0);

      `TEST_COMPARE("DTREE00 Results",0,0);

      // Check results
      `CPU_READS(`WB_RAM3+16, 4'hF, 2, cpu_read);
      `CPU_READS(`WB_RAM3+20, 4'hF, 0, cpu_read);
      `CPU_READS(`WB_RAM3+24, 4'hF, 3, cpu_read);
      `CPU_READS(`WB_RAM3+28, 4'hF, 0, cpu_read);

      `TEST_COMPARE("Sum the tree",0,0);

      input0[`F_DSP_SLAVE_EQUATION_NUMBER] = `B_DSP_EQUATION_SUM;
      input0[`F_DSP_SLAVE_DATA_SIZE] = `B_CONTROL_DATA_SIZE_WORD;
      input0[`F_DSP_SLAVE_DATA_SIGNED] = 0;
      input0[`F_DSP_SLAVE_EQUATION_START] = 1;
      input1[`F_DSP_SLAVE_INPUT_FILE0] = 4;
      input3[`F_DSP_SLAVE_OUTPUT_FILE0] = 5;

      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT1_OFFSET,   4'hF, input1);
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT3_OFFSET,   4'hF, input3);
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT0_OFFSET,   4'hF, input0);

      repeat (300) @(posedge `WB_CLK);
      `CPU_READS(`WB_RAM3+16+(4*8), 4'hF, 32'h0000_0005, cpu_read);

      repeat (300) @(posedge `WB_CLK);
      `TEST_COMPLETE;
   end // initial begin

endmodule // test
