//                              -*- Mode: Verilog -*-
// Filename        : dsp_slave00.v
// Description     : Test Read/Write DSP Slave Registers
// Author          : Phil Tracton
// Created On      : Mon Apr 22 15:39:33 2019
// Last Modified By: Phil Tracton
// Last Modified On: Mon Apr 22 15:39:33 2019
// Update Count    : 0
// Status          : Unknown, Use with caution!
module test_case (/*AUTOARG*/ ) ;
`include "dsp_includes.vh"

   //
   // Test Configuration
   // These parameters need to be set for each test case
   //
   parameter simulation_name = "basic_00";
   parameter number_of_tests = 10;

   reg  err;
   reg [31:0] data_out;
   integer    i;
   reg [31:0] daq_read;
   reg [31:0] cpu_read;
   reg [31:0] debug_reg;

   initial begin
      daq_read = 0;

      $display("Basic Test Case");
      @(negedge `WB_RST);
      repeat (100) @(posedge `WB_CLK);

      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT0_OFFSET,  4'hF, 32'h0123_4567);
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT1_OFFSET,  4'hF, 32'hdead_beef);
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT2_OFFSET,  4'hF, 32'hfeed_f00d);
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT3_OFFSET,  4'hF, 32'haa55_cc77);
      `CPU_WRITES(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT4_OFFSET,  4'hF, 32'hbb66_dd88);


      `CPU_READS(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT0_OFFSET,  4'hF, 32'h0123_4567, cpu_read);
      `CPU_READS(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT1_OFFSET,  4'hF, 32'hdead_beef, cpu_read);
      `CPU_READS(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT2_OFFSET,  4'hF, 32'hfeed_f00d, cpu_read);
      `CPU_READS(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT3_OFFSET,  4'hF, 32'haa55_cc77, cpu_read);
      `CPU_READS(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_INPUT4_OFFSET,  4'hF, 32'hbb66_dd88, cpu_read);

      `CPU_READS(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_OUTPUT0_OFFSET,  4'hF, 32'h0123_4567, cpu_read);
      `CPU_READS(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_OUTPUT1_OFFSET,  4'hF, 32'h89ab_cdef, cpu_read);
      `CPU_READS(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_OUTPUT2_OFFSET,  4'hF, 32'h1122_3344, cpu_read);
      `CPU_READS(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_OUTPUT3_OFFSET,  4'hF, 32'h5566_7788, cpu_read);
      `CPU_READS(`WB_DSP_SLAVE_BASE_ADDRESS+`WB_DSP_SLAVE_OUTPUT4_OFFSET,  4'hF, 32'h99aa_bbcc, cpu_read);

      repeat (50) @(posedge `WB_CLK);
      `TEST_COMPLETE;
   end

endmodule // test_case
