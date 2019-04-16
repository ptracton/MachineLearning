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
