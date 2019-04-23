//                              -*- Mode: Verilog -*-
// Filename        : wrap_around_00.v
// Description     : Test the DAQ wrapping around writing data
// Author          : Philip Tracton
// Created On      : Sun Apr 21 14:21:56 2019
// Last Modified By: Philip Tracton
// Last Modified On: Sun Apr 21 14:21:56 2019
// Update Count    : 0
// Status          : Unknown, Use with caution!

module test_case (/*AUTOARG*/ ) ;
`include "dsp_includes.vh"

   //
   // Test Configuration
   // These parameters need to be set for each test case
   //
   parameter simulation_name = "wrap_around_00";
   parameter number_of_tests = 89;
   reg [31:0] address;
   reg [7:0]  file_num;
   reg [31:0] cpu_read_data;
   reg        daq_read;
   integer    i;

   initial begin
      daq_read = 0;
      address = 0;
      file_num = 0;
      cpu_read_data = 0;

      $display("DAQ Wrap Around");
      @(negedge `WB_RST);
      repeat (100) @(posedge `WB_CLK);


      //
      // Configure the files to different sizes of data and depth of storage
      //
      file_num = 1;
      address = `WB_RAM0 + file_num * 'h20;
      `CPU_WRITE_FILE_CONFIG(file_num, `WB_RAM1, `WB_RAM1+(4*20), `WB_RAM1, `WB_RAM1, `B_CONTROL_DATA_SIZE_WORD);

      repeat (500) @(posedge `WB_CLK);

      `CPU_READS(address + `FILE_START_ADDRESS_OFFSET, 4'hF, `WB_RAM1, cpu_read_data);
      `CPU_READS(address + `FILE_END_ADDRESS_OFFSET, 4'hF, `WB_RAM1+(4*20), cpu_read_data);
      `CPU_READS(address + `FILE_RD_PTR_OFFSET, 4'hF, `WB_RAM1, cpu_read_data);
      `CPU_READS(address + `FILE_WR_PTR_OFFSET, 4'hF, `WB_RAM1, cpu_read_data);
      `CPU_READS(address + `FILE_STATUS_OFFSET, 4'hF, 1 << `F_STATUS_EMPTY, cpu_read_data);
      `CPU_READS(address + `FILE_CONTROL_OFFSET, 4'hF, 0, cpu_read_data);

      //
      // Load data and have it wrap around
      //
      $display("\n\nLoading 32 bit data via DAQ @d", $time);
      for (i=0; i<22; i=i+1) begin
         `DAQ_WRITES_FILE(1, 32'hdead_0000+i);
      end

      repeat (50) @(posedge `WB_CLK);
      file_num = 1;
      address = `WB_RAM0 + file_num * 'h20;
      `CPU_READS(address + `FILE_STATUS_OFFSET, 4'hF,
                 (1 << `F_STATUS_FULL) | (1<< `F_STATUS_WRAP_AROUND),
                 cpu_read_data);
      `CPU_READS(address + `FILE_WR_PTR_OFFSET, 4'hF,
                 `WB_RAM1+4,
                 cpu_read_data
                 );


      repeat (50) @(posedge `WB_CLK);
      `TEST_COMPLETE;

   end


endmodule // wrap_around_00
