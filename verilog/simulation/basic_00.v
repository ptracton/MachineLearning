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
   parameter simulation_name = "basic_00";
   parameter number_of_tests = 64;

   reg  err;
   reg [31:0] data_out;
   integer    i;
   reg [31:0] daq_read;
   reg [31:0] cpu_read;


   initial begin
      daq_read = 0;

      $display("Basic Test Case");
      @(negedge `WB_RST);
      repeat (100) @(posedge `WB_CLK);

      // `DAQ_WRITES(`WB_RAM0,    4'hF, 32'h0123_4567);
      // `DAQ_WRITES(`WB_RAM0+4,  4'hF, 32'h89AB_CDEF);
      // `DAQ_WRITES(`WB_RAM0+8,  4'hF, 32'hAA55_CC77);
      // `DAQ_WRITES(`WB_RAM0+12, 4'hF, 32'hBB66_DD99);

      // `DAQ_READS(`WB_RAM0,    4'hf, 32'h0123_4567, daq_read);
      // `DAQ_READS(`WB_RAM0+8,  4'hf, 32'hAA55_CC77, daq_read);
      // `DAQ_READS(`WB_RAM0+12, 4'hf, 32'hBB66_DD99, daq_read);
      // `DAQ_READS(`WB_RAM0+4,  4'hf, 32'h89AB_CDEF, daq_read);

      `CPU_WRITES(`WB_RAM3,    4'hF, 32'h0123_4567);
      `CPU_WRITES(`WB_RAM3+4,  4'hF, 32'h89AB_CDEF);
      `CPU_WRITES(`WB_RAM3+8,  4'hF, 32'hAA55_CC77);
      `CPU_WRITES(`WB_RAM3+12, 4'hF, 32'hBB66_DD99);

      `CPU_READS(`WB_RAM3,    4'hF, 32'h0123_4567, cpu_read);
      `CPU_READS(`WB_RAM3+8,  4'hF, 32'hAA55_CC77, cpu_read);
      `CPU_READS(`WB_RAM3+12, 4'hF, 32'hBB66_DD99, cpu_read);
      `CPU_READS(`WB_RAM3+4,  4'hF, 32'h89AB_CDEF, cpu_read);

      `CPU_WRITE_FILE_CONFIG(0, `WB_RAM1, `WB_RAM1+(4*20), `WB_RAM1, `WB_RAM1, 0);
      `CPU_WRITE_FILE_CONFIG(1, `WB_RAM2, `WB_RAM2+(4*25), `WB_RAM2, `WB_RAM2, 0);
      `CPU_WRITE_FILE_CONFIG(2, `WB_RAM3, `WB_RAM3+(4*40), `WB_RAM3, `WB_RAM3, 0);

      repeat (500) @(posedge `WB_CLK);

      for (i=0; i< 20; i=i+1) begin
         `DAQ_WRITES_FILE(0, 32'hdead_0000+i);
         `DAQ_WRITES_FILE(1, 32'hfeed_0000+i);
         `DAQ_WRITES_FILE(2, 32'hbeef_0000+i);
      end
      //      `DAQ_WRITES_FILE(0, 32'hdead_beef);
      //      `DAQ_WRITES_FILE(0, 32'h5555_aaaa);
      //      `DAQ_WRITES_FILE(0, 32'hbbbb_6666);
      //      `DAQ_WRITES_FILE(0, 32'h7777_cccc);

      repeat (50) @(posedge `WB_CLK);
      for (i=0; i< 20; i=i+1) begin
         `CPU_READS(`WB_RAM1 + i*4,    4'hF, 32'hdead_0000+i, cpu_read);
         `CPU_READS(`WB_RAM2 + i*4,    4'hF, 32'hfeed_0000+i, cpu_read);
         `CPU_READS(`WB_RAM3 + i*4,    4'hF, 32'hbeef_0000+i, cpu_read);
      end

      //      `CPU_READS(`WB_RAM1,    4'hF, 32'hdead_beef, cpu_read);
      //      `CPU_READS(`WB_RAM1+4,  4'hF, 32'h5555_aaaa, cpu_read);
      //      `CPU_READS(`WB_RAM1+8,  4'hF, 32'hbbbb_6666, cpu_read);
      //      `CPU_READS(`WB_RAM1+12, 4'hF, 32'h7777_cccc, cpu_read);

      repeat (50) @(posedge `WB_CLK);
      `TEST_COMPLETE;
   end

endmodule // test_case
