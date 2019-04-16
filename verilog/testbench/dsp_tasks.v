//                              -*- Mode: Verilog -*-
// Filename        : dsp_tasks.v
// Description     : DSP Support Tasks
// Author          : Phil Tracton
// Created On      : Tue Apr 16 17:11:17 2019
// Last Modified By: Phil Tracton
// Last Modified On: Tue Apr 16 17:11:17 2019
// Update Count    : 0
// Status          : Unknown, Use with caution!

module dsp_tasks (/*AUTOARG*/ ) ;

   task CPU_READ;
      input [31:0] address;
      input [3:0]  selection;
      input [31:0] expected;

      output [31:0] data;
      begin
         data = 32'hFFFFFFFF;

         @(posedge `WB_CLK);
         `CPU_ADDR = address;
         `CPU_SEL = selection;
         `CPU_WRITE = 0;
         `CPU_START = 1;

         if (`CPU_ACTIVE === 0)  begin
            @(posedge `CPU_ACTIVE);
            @(negedge `CPU_ACTIVE);
         end else begin
            @(negedge `CPU_ACTIVE);
         end

         @(posedge `WB_CLK);
         `CPU_WRITE = 0;
         `CPU_ADDR = $random;
         `CPU_SEL = $random;
         `CPU_START = 0;
         #1 data = `CPU_DATA_RD;
         //$display("CPU READ addr = 0x%x data = 0x%x sel = 0x%x @ %d", address, data, selection, $time);
         `TEST_COMPARE("CPU READ", expected, data);

      end
   endtask // CPU_READ

   task CPU_WRITE;
      input [31:0] address;
      input [3:0]  selection;
      input [31:0] data;
      begin
         @(posedge `WB_CLK);
         $display("CPU WRITE addr = 0x%x data = 0x%x sel = 0x%x @ %d", address, data, selection, $time);

         `CPU_ADDR = address;
         `CPU_DATA_WR = data;
         `CPU_SEL = selection;
         `CPU_WRITE = 1;
         `CPU_START = 1;

         if (`CPU_ACTIVE === 0) begin
            @(posedge `CPU_ACTIVE);
            @(negedge `CPU_ACTIVE);
         end else begin
            @(negedge `CPU_ACTIVE);
         end

         @(posedge `WB_CLK);
         `CPU_WRITE = 0;
         `CPU_ADDR = $random;
         `CPU_DATA_WR = $random;
         `CPU_SEL = $random;
         `CPU_START = 0;

      end
   endtask // CPU_WRITE

   task CPU_WRITE_FILE_CONFIG;
      input [7:0] file_number;
      input [31:0] start_address;
      input [31:0] end_address;
      input [31:0] rd_ptr;
      input [31:0] wr_ptr;
      input [31:0] control;
      reg [31:0]   address;

      begin
         address = `WB_RAM0 + ('h20*file_number);
         $display("CPU WRITE CONFIG File=%d Start Address=0x%x Address =0x%x@ %d", file_number, start_address, address, $time);
         `CPU_WRITES(address, 4'hF, start_address);
         address = address + 4;
         `CPU_WRITES(address, 4'hF, end_address);
         address = address + 4;
         `CPU_WRITES(address, 4'hF, rd_ptr);
         address = address + 4;
         `CPU_WRITES(address, 4'hF, wr_ptr);
         address = address + 4;
         `CPU_WRITES(address, 4'hF, 32'h0); //Status starts as a 0
         address = address + 4;
         `CPU_WRITES(address, 4'hF, control);
         address = address + 4;
         `CPU_WRITES(address, 4'hF, 32'h0); // Reserved 0 is a 0
         address = address + 4;
         `CPU_WRITES(address, 4'hF, 32'h0); // Reserved 1 is a 0

      end
   endtask // CPU_WRITE_FILE_CONFIG




   task DAQ_READ;
      input [31:0] address;
      input [3:0]  selection;
      input [31:0] expected;

      output [31:0] data;
      begin
         data = 32'hFFFFFFFF;

         @(posedge `WB_CLK);
         `DAQ_ADDR = address;
         `DAQ_SEL = selection;
         `DAQ_WRITE = 0;
         `DAQ_START = 1;

         if (`DAQ_ACTIVE === 0)  begin
            @(posedge `DAQ_ACTIVE);
            @(negedge `DAQ_ACTIVE);
         end else begin
            @(negedge `DAQ_ACTIVE);
         end

         @(posedge `WB_CLK);
         `DAQ_WRITE = 0;
         `DAQ_ADDR = $random;
         `DAQ_SEL = $random;
         `DAQ_START = 0;
         #1 data = `DAQ_DATA_RD;
         //$display("DAQ READ addr = 0x%x data = 0x%x sel = 0x%x @ %d", address, data, selection, $time);
         `TEST_COMPARE("DAQ READ", expected, data);

      end
   endtask // DAQ_READ

   task DAQ_WRITE;
      input [31:0] address;
      input [3:0]  selection;
      input [31:0] data;
      begin
         @(posedge `WB_CLK);
         $display("DAQ WRITE addr = 0x%x data = 0x%x sel = 0x%x @ %d", address, data, selection, $time);

         `DAQ_ADDR = address;
         `DAQ_DATA_WR = data;
         `DAQ_SEL = selection;
         `DAQ_WRITE = 1;
         `DAQ_START = 1;

         if (`DAQ_ACTIVE === 0) begin
            @(posedge `DAQ_ACTIVE);
            @(negedge `DAQ_ACTIVE);
         end else begin
            @(negedge `DAQ_ACTIVE);
         end

         @(posedge `WB_CLK);
         `DAQ_WRITE = 0;
         `DAQ_ADDR = $random;
         `DAQ_DATA_WR = $random;
         `DAQ_SEL = $random;
         `DAQ_START = 0;

      end
   endtask // DAQ_WRITE

endmodule // dsp_tasks
