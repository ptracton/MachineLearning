//                              -*- Mode: Verilog -*-
// Filename        : tb_fifo.v
// Description     : fifo test bench
// Author          : ptracton
// Created On      : Mon Jul  2 20:26:10 2018
// Last Modified By: ptracton
// Last Modified On: Mon Jul  2 20:26:10 2018
// Update Count    : 0
// Status          : Unknown, Use with caution!

module tb_wb_master_interface (/*AUTOARG*/) ;

   // For a testbench this is ok
   /* verilator lint_off STMTDLY */
   
   localparam WB_CLK_PERIOD= 10;
   
   reg 			wb_clk;
   initial begin
      wb_clk = 0;
      forever
	#(WB_CLK_PERIOD/2) wb_clk = ~wb_clk;
   end
 
   reg 			wb_rst;
   initial begin
      wb_rst = 0;
      #42 wb_rst = 1;
      #77 wb_rst = 0; 
   end

   //
   // Bus Matrix has slightly different names
   //
   wire wb_clk_i = wb_clk;
   wire wb_rst_i = wb_rst;
   

   //
   // General purpose test support
   //
   test_tasks #("wb_master_interface",
		14) TEST();

`define RAM0_ADDRESS 32'h20000000
`define RAM1_ADDRESS 32'h30000000
`define RAM2_ADDRESS 32'h90000000
`define RAM3_ADDRESS 32'hA0000000
  
   
`include "bus_matrix.vh"
   
   localparam aw = 32;
   localparam dw = 32;
   wire [31:0] data_rd;
   wire        active;
   reg 	       start;
   reg [31:0]  address;   
   reg [3:0]   selection;
   reg 	       write;
   reg [31:0]  data_wr;
   
   
   wb_master_interface dut( 
			   // Outputs
			   .wb_adr_o		(wb_m2s_daq_adr),
			   .wb_dat_o		(wb_m2s_daq_dat),
			   .wb_sel_o		(wb_m2s_daq_sel),
			   .wb_we_o		(wb_m2s_daq_we),
			   .wb_cyc_o		(wb_m2s_daq_cyc),
			   .wb_stb_o		(wb_m2s_daq_stb),
			   .wb_cti_o		(wb_m2s_daq_cti),
			   .wb_bte_o		(wb_m2s_daq_bte),
			   .data_rd		(data_rd),
			   .active		(active),
			   // Inputs
			   .wb_clk		(wb_clk),
			   .wb_rst		(wb_rst),
			   .wb_dat_i		(wb_s2m_daq_dat),
			   .wb_ack_i		(wb_s2m_daq_ack),
			   .wb_err_i		(wb_s2m_daq_err),
			   .wb_rty_i		(wb_s2m_daq_rty),
			   .start		(start),
			   .address		(address),
			   .selection		(selection),
			   .write		(write),
			   .data_wr		(data_wr)
			    );
   
   
   wb_ram 
     #(//Wishbone parameters
       .depth(384)
       )
   ram0
   (
    .wb_clk_i(wb_clk),
    .wb_rst_i(wb_rst),
    
    .wb_adr_i(wb_m2s_ram0_adr[14:0]),
    .wb_dat_i(wb_m2s_ram0_dat),
    .wb_sel_i(wb_m2s_ram0_sel),
    .wb_we_i(wb_m2s_ram0_we),
    .wb_bte_i(wb_m2s_ram0_bte),
    .wb_cti_i(wb_m2s_ram0_cti),
    .wb_cyc_i(wb_m2s_ram0_cyc),
    .wb_stb_i(wb_m2s_ram0_stb),
    
    .wb_ack_o(wb_s2m_ram0_ack),
    .wb_err_o(wb_s2m_ram0_err),
    .wb_dat_o(wb_s2m_ram0_dat)
    );
   
   assign wb_s2m_ram0_rty = 0;


   wb_ram 
     #(//Wishbone parameters
       .depth(256)
       )
   ram1
   (
    .wb_clk_i(wb_clk),
    .wb_rst_i(wb_rst),
    
    .wb_adr_i(wb_m2s_ram1_adr[14:0]),
    .wb_dat_i(wb_m2s_ram1_dat),
    .wb_sel_i(wb_m2s_ram1_sel),
    .wb_we_i(wb_m2s_ram1_we),
    .wb_bte_i(wb_m2s_ram1_bte),
    .wb_cti_i(wb_m2s_ram1_cti),
    .wb_cyc_i(wb_m2s_ram1_cyc),
    .wb_stb_i(wb_m2s_ram1_stb),
    
    .wb_ack_o(wb_s2m_ram1_ack),
    .wb_err_o(wb_s2m_ram1_err),
    .wb_dat_o(wb_s2m_ram1_dat)
    );
   
   assign wb_s2m_ram1_rty = 0;

   wb_ram 
     #(//Wishbone parameters
       .depth(128)
       )
   ram2
   (
    .wb_clk_i(wb_clk),
    .wb_rst_i(wb_rst),
    
    .wb_adr_i(wb_m2s_ram2_adr[14:0]),
    .wb_dat_i(wb_m2s_ram2_dat),
    .wb_sel_i(wb_m2s_ram2_sel),
    .wb_we_i(wb_m2s_ram2_we),
    .wb_bte_i(wb_m2s_ram2_bte),
    .wb_cti_i(wb_m2s_ram2_cti),
    .wb_cyc_i(wb_m2s_ram2_cyc),
    .wb_stb_i(wb_m2s_ram2_stb),
    
    .wb_ack_o(wb_s2m_ram2_ack),
    .wb_err_o(wb_s2m_ram2_err),
    .wb_dat_o(wb_s2m_ram2_dat)
    );
   
   assign wb_s2m_ram2_rty = 0;

   wb_ram 
     #(
       .depth(32)
       )
   ram3
   (
    .wb_clk_i(wb_clk),
    .wb_rst_i(wb_rst),
    
    .wb_adr_i(wb_m2s_ram3_adr[14:0]),
    .wb_dat_i(wb_m2s_ram3_dat),
    .wb_sel_i(wb_m2s_ram3_sel),
    .wb_we_i(wb_m2s_ram3_we),
    .wb_bte_i(wb_m2s_ram3_bte),
    .wb_cti_i(wb_m2s_ram3_cti),
    .wb_cyc_i(wb_m2s_ram3_cyc),
    .wb_stb_i(wb_m2s_ram3_stb),
    
    .wb_ack_o(wb_s2m_ram3_ack),
    .wb_err_o(wb_s2m_ram3_err),
    .wb_dat_o(wb_s2m_ram3_dat)
    );
   
   assign wb_s2m_ram3_rty = 0;

   task WriteRAM;
      input [31:0] Waddress;
      input [3:0]  Wselection;
      input [31:0] Wdata;
      begin
	 @(posedge wb_clk);
	 address = Waddress;
	 selection = Wselection;
	 data_wr = Wdata;
	 write = 1;
	 start = 1;
	 @(posedge wb_clk);
	 write = 0;
	 start = 0;
	 address = $random;
	 data_wr = $random;
	 selection = $random;
	 @(posedge wb_clk);
      end
   endtask // WriteRAM
   
   task ReadRAM;
      
      input [31:0] Raddress;
      input [3:0]  Rselection;
      output [31:0] Rdata;
      begin
	 @(posedge wb_clk);
	 data_wr = $random;
	 address = Raddress;
	 selection = Rselection;
	 write = 0;
	 start = 1;
	 @(posedge wb_clk);
	 write = 0;
	 start = 0;
	 address = $random;
	 data_wr = $random;
	 selection = $random;

	 #1 Rdata = data_rd;
	 //$display("Rdata = 0x%x data_rd = 0x%x @ %d", Rdata, data_rd, $time)	 ;	 

	 @(posedge wb_clk);
      end
   endtask // ReadRAM
   
   task RetryRAM;
      input [31:0] Waddress;
      input [3:0]  Wselection;
      input [31:0] Wdata;
      begin
	 force dut.wb_ack_i = 0;
	 
	 @(posedge wb_clk);
	 address = Waddress;
	 selection = Wselection;
	 data_wr = Wdata;
	 write = 1;
	 start = 1;
	 @(posedge wb_clk);
	 force dut.wb_rty_i = 1;      
	 write = 0;
	 start = 0;
	 address = $random;
	 data_wr = $random;
	 selection = $random;
	 @(posedge wb_clk);     
	 release dut.wb_ack_i;
	 release dut.wb_rty_i;
      end
   endtask // RetryRAM
   
   
   
   reg [31:0] read_ram;
   
   initial begin

      start = 0;
      address = 0;
      selection = 0;
      write = 0;
      data_wr = 0;
      read_ram = 0;      
      
      //
      // Wait for reset to release
      //
      @(negedge wb_rst);


      //
      // Writing and reading words
      //
      repeat(10) @(posedge wb_clk);

      WriteRAM(`RAM0_ADDRESS, 4'hF, 32'ha5a5_b6b6);
      WriteRAM(`RAM0_ADDRESS+4, 4'hF, 32'h01234567);

      WriteRAM(`RAM1_ADDRESS, 4'hF, 32'h1a1a_1b1b);
      WriteRAM(`RAM2_ADDRESS, 4'hF, 32'h2a2a_2b2b);
      WriteRAM(`RAM3_ADDRESS, 4'hF, 32'h3a3a_3b3b);
      
      WriteRAM(`RAM1_ADDRESS+4, 4'hF, 32'h11234567);
      WriteRAM(`RAM2_ADDRESS+4, 4'hF, 32'h21234567);
      WriteRAM(`RAM3_ADDRESS+4, 4'hF, 32'h31234567);
      
      repeat(10) @(posedge wb_clk);
      

      ReadRAM(`RAM0_ADDRESS, 4'hF, read_ram);
      TEST.compare_values("RAM0 0", 32'ha5a5_b6b6, read_ram);      
      ReadRAM(`RAM0_ADDRESS+4, 4'hF, read_ram);
      TEST.compare_values("RAM0 4", 32'h0123_4567, read_ram);      
      
      ReadRAM(`RAM1_ADDRESS, 4'hF, read_ram);
      TEST.compare_values("RAM1 0", 32'h1a1a_1b1b, read_ram);
      
      ReadRAM(`RAM2_ADDRESS, 4'hF, read_ram);
      TEST.compare_values("RAM2 0", 32'h2a2a_2b2b, read_ram);
      
      ReadRAM(`RAM3_ADDRESS, 4'hF, read_ram);
      TEST.compare_values("RAM3 0", 32'h3a3a_3b3b, read_ram);
      
      ReadRAM(`RAM1_ADDRESS+4, 4'hF, read_ram);
      TEST.compare_values("RAM1 4", 32'h1123_4567, read_ram);
            
      ReadRAM(`RAM2_ADDRESS+4, 4'hF, read_ram);
      TEST.compare_values("RAM2 4", 32'h2123_4567, read_ram);
      
      ReadRAM(`RAM3_ADDRESS+4, 4'hF, read_ram);
      TEST.compare_values("RAM3 4", 32'h3123_4567, read_ram);      


      repeat(10) @(posedge wb_clk);

      //
      // Half-Byte Writing and Reading
      //
      WriteRAM(`RAM0_ADDRESS+64, 4'h3, 32'hFFFF_dead);
      ReadRAM(`RAM0_ADDRESS+64, 4'h3, read_ram);
      TEST.compare_values("RAM0 Half-Byte0", 32'hxxxx_dead, read_ram); 

      WriteRAM(`RAM0_ADDRESS+64, 4'hC, 32'hbeef_FFFF);
      ReadRAM(`RAM0_ADDRESS+64, 4'hC, read_ram);
      TEST.compare_values("RAM0 Half-Byte 1", 32'hbeef_dead, read_ram); 

     
      
      repeat(10) @(posedge wb_clk);

      //
      // Byte Writing and Reading
      //
      WriteRAM(`RAM0_ADDRESS+100, 4'h1, 32'hFFFF_FFaa);
      ReadRAM(`RAM0_ADDRESS+100, 4'h1, read_ram);
      TEST.compare_values("RAM0 Byte0", 32'hxxxxxxaa, read_ram); 

      WriteRAM(`RAM0_ADDRESS+100, 4'h2, 32'hFFFF_bbFF);
      ReadRAM(`RAM0_ADDRESS+100, 4'h2, read_ram);
      TEST.compare_values("RAM0 Byte 1", 32'hxxxx_bbaa, read_ram); 

      WriteRAM(`RAM0_ADDRESS+100, 4'h4, 32'hFFCC_FFFF);
      ReadRAM(`RAM0_ADDRESS+100, 4'h4, read_ram);
      TEST.compare_values("RAM0 Byte 2", 32'hxxCC_bbaa, read_ram); 

      WriteRAM(`RAM0_ADDRESS+100, 4'h8, 32'hDDFF_FFFF);
      ReadRAM(`RAM0_ADDRESS+100, 4'h8, read_ram);
      TEST.compare_values("RAM0 Byte 3", 32'hddcc_bbaa, read_ram); 
      
      
      TEST.all_tests_completed();
   end
   
endmodule // tb_fifo
