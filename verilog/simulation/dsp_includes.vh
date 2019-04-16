//                              -*- Mode: Verilog -*-
// Filename        : wb_dsp_includes.vh
// Description     : Include file for WB DSP Testing
// Author          : Philip Tracton
// Created On      : Wed Dec  2 13:38:15 2015
// Last Modified By: Philip Tracton
// Last Modified On: Wed Dec  2 13:38:15 2015
// Update Count    : 0
// Status          : Unknown, Use with caution!


//`include "../rtl/wb_daq_slave_registers_include.vh"
//`include "../rtl/wb_dsp_slave_registers_include.vh"

`define TB          testbench
`define WB_RST      `TB.wb_rst
`define WB_CLK      `TB.wb_clk
`define DSP         `TB.dsp
`define DAQ         `TB.daq

`define TB_START   `TB.start
`define TB_ADDR    `TB.address
`define TB_SEL     `TB.selection
`define TB_WRITE   `TB.write
`define TB_DATA_WR `TB.data_wr
`define TB_DATA_RD `TB.data_rd
`define TB_ACTIVE  `TB.active

`define RAM0        `TB.ram0
`define RAM00       `RAM.ram0
`define MEMORY0     `RAM0.mem


`define RAM1        `TB.ram1
`define RAM10       `RAM.ram0
`define MEMORY1     `RAM0.mem


`define RAM2        `TB.ram2
`define RAM20       `RAM.ram0
`define MEMORY2     `RAM0.mem


`define RAM3        `TB.ram3
`define RAM30       `RAM.ram0
`define MEMORY3     `RAM0.mem

`define TEST_CASE       `TB.test_case
`define SIMULATION_NAME `TEST_CASE.simulation_name
//`define RAM_IMAGE       `TEST_CASE.ram_image
`define NUMBER_OF_TESTS `TEST_CASE.number_of_tests

`define WB_RAM0 32'h9000_0000
`define WB_RAM1 32'h9000_2000
`define WB_RAM2 32'h9000_4000
`define WB_RAM3 32'h9000_6000

/*******************************************************************************

 FILE Data Structure

 typedef struct{
 uint32_t start_address;   // offset 00
 uint32_t end_address;     // offset 04
 uint32_t rd_ptr;          // offset 08
 uint32_t wr_ptr;          // offset 0c
 uint32_t status;          // offset 10
     #define EMPTY   0x00000001
     #define FULL    0x00000002
     #define WRAP    0x00000004
     #define ERROR   0x00000008
 uint32_t control;         // offset 14
 uint32_t reserved0        // offset 18
 uint32_t reserved1        // offset 1C
 } FILE_TypeDef

This is a 32*8 = 256 bit structure

 ******************************************************************************/

`define FILE_START_ADDRESS_OFFSET 32'h0000_0000
`define FILE_END_ADDRESS_OFFSET   32'h0000_0004
`define FILE_READ_PTR_OFFSET      32'h0000_0008
`define FILE_WRITE_PTR_OFFSET     32'h0000_000C
`define FILE_STATUS_OFFSET        32'h0000_0010
`define FILE_CONTROL_OFFSET       32'h0000_0014
`define FILE_RESERVED0_OFFSET     32'h0000_0018
`define FILE_RESERVED1_OFFSET     32'h0000_001C


`define WB_DSP_BASE_ADDRESS         32'h7000_0000


`define WB_DAQ_BASE_ADDRESS        32'h8000_0000



`define TEST_TASKS  `TB.test_tasks
`define TEST_PASSED `TEST_TASKS.test_passed
`define TEST_FAILED `TEST_TASKS.test_failed
`define TEST_COMPARE  `TEST_TASKS.compare_values
`define TEST_COMPLETE `TEST_TASKS.all_tests_completed
