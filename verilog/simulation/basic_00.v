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


   //
   // Test Configuration
   // These parameters need to be set for each test case
   //
   parameter simulation_name = "sum_00";
   parameter number_of_tests = 80;

   reg  err;
   reg [31:0] data_out;
   integer    i;
   reg [31:0] daq_read;

   task DAQ_READ;
      input [31:0] address;
      input [3:0]  selection;
      input [31:0] expected;

      output [31:0] data;
      begin
         data = 32'hFFFFFFFF;

         @(posedge `WB_CLK);
         `TB_ADDR = address;
         `TB_SEL = selection;
         `TB_WRITE = 0;
         `TB_START = 1;

         if (`TB_ACTIVE === 0)
           @(posedge `TB_ACTIVE);

         @(posedge `WB_CLK);
         `TB_WRITE = 0;
         `TB_ADDR = $random;
         `TB_SEL = $random;
         `TB_START = 0;
         #1 data = `TB_DATA_RD;
         //$display("DAQ READ addr = 0x%x data = 0x%x sel = 0x%x @ %d", address, data, selection, $time);
         `TEST_COMPARE("DAQ READ", data, expected);

      end
   endtask // DAQ_READ

   task DAQ_WRITE;
      input [31:0] address;
      input [3:0]  selection;
      input [31:0] data;
      begin
         @(posedge `WB_CLK);
         $display("DAQ WRITE addr = 0x%x data = 0x%x sel = 0x%x @ %d", address, data, selection, $time);

         `TB_ADDR = address;
         `TB_DATA_WR = data;
         `TB_SEL = selection;
         `TB_WRITE = 1;
         `TB_START = 1;

         if (`TB_ACTIVE === 0)
           @(posedge `TB_ACTIVE);

         @(posedge `WB_CLK);
         `TB_WRITE = 0;
         `TB_ADDR = $random;
         `TB_DATA_WR = $random;
         `TB_SEL = $random;
         `TB_START = 0;

      end
   endtask // DAQ_WRITE

   initial begin
      daq_read = 0;

      $display("Basic Test Case");
      @(negedge `WB_RST);
      repeat (100) @(posedge `WB_CLK);

      DAQ_WRITE(`WB_RAM0,    4'hF, 32'h0123_4567);
      repeat (2) @(posedge `WB_CLK);
      DAQ_WRITE(`WB_RAM0+4,  4'hF, 32'h89AB_CDEF);
      repeat (2) @(posedge `WB_CLK);
      DAQ_WRITE(`WB_RAM0+8,  4'hF, 32'hAA55_CC77);
      repeat (2) @(posedge `WB_CLK);
      DAQ_WRITE(`WB_RAM0+12, 4'hF, 32'hBB66_DD99);
      repeat (2) @(posedge `WB_CLK);
      DAQ_READ(`WB_RAM0,    4'hf, 32'h0123_4567, daq_read);
      repeat (2) @(posedge `WB_CLK);
      DAQ_READ(`WB_RAM0+8,  4'hf, 32'hAA55_CC77, daq_read);
      repeat (2) @(posedge `WB_CLK);
      DAQ_READ(`WB_RAM0+12, 4'hf, 32'hBB66_DD99, daq_read);
      repeat (2) @(posedge `WB_CLK);
      DAQ_READ(`WB_RAM0+4,  4'hf, 32'h89AB_CDEF, daq_read);
      repeat (2) @(posedge `WB_CLK);

      #500;
      `TEST_COMPLETE;
   end

endmodule // test_case
