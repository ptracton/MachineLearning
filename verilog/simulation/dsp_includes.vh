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
`define DUT         `TB.dut
`define DSP         `DUT.dsp
`define DAQ         `DUT.daq
`define DSP_TASKS   `TB.dsp_tasks
`define DSP_EQUATION_DTREE  `DSP.equations.dtree
//testbench.dut.dsp.equations.dtree.dtree_output[31:0]

`define DAQ_READS   `DSP_TASKS.DAQ_READ
`define DAQ_WRITES  `DSP_TASKS.DAQ_WRITE
`define DAQ_WRITES_FILE `DSP_TASKS.DAQ_WRITES_FILE

`define CPU_READS   `DSP_TASKS.CPU_READ
`define CPU_WRITES  `DSP_TASKS.CPU_WRITE
`define CPU_WRITE_FILE_CONFIG `DSP_TASKS.CPU_WRITE_FILE_CONFIG

`define DAQ_START   `TB.daq_start
`define DAQ_ADDR    `TB.daq_address
`define DAQ_SEL     `TB.daq_selection
`define DAQ_WRITE   `TB.daq_write
`define DAQ_DATA_WR `TB.daq_data_wr
`define DAQ_DATA_RD `TB.daq_data_rd
`define DAQ_ACTIVE  `TB.daq_active

`define CPU_START   `TB.cpu_start
`define CPU_ADDR    `TB.cpu_address
`define CPU_SEL     `TB.cpu_selection
`define CPU_WRITE   `TB.cpu_write
`define CPU_DATA_WR `TB.cpu_data_wr
`define CPU_DATA_RD `TB.cpu_data_rd
`define CPU_ACTIVE  `TB.cpu_active

`define FILE_NUM     `TB.file_num
`define FILE_WRITE   `TB.file_write
`define FILE_READ   `TB.file_read
`define FILE_WRITE_DATA   `TB.file_write_data
`define FILE_READ_DATA   `TB.file_read_data
`define FILE_ACTIVE   `TB.file_active

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
     #define DATA_SIZE   00/11=32 bits, 01 is 8 bits, 10 is 16 bits

 uint32_t reserved0        // offset 18
 uint32_t reserved1        // offset 1C
 } FILE_TypeDef

This is a 32*8 = 256 bit structure

 ******************************************************************************/

`define FILE_START_ADDRESS_OFFSET 32'h0000_0000
`define FILE_END_ADDRESS_OFFSET   32'h0000_0004
`define FILE_RD_PTR_OFFSET        32'h0000_0008
`define FILE_WR_PTR_OFFSET        32'h0000_000C
`define FILE_STATUS_OFFSET        32'h0000_0010
`define FILE_CONTROL_OFFSET       32'h0000_0014
`define FILE_RESERVED0_OFFSET     32'h0000_0018
`define FILE_RESERVED1_OFFSET     32'h0000_001C

`define F_STATUS_WRAP_AROUND      0
`define F_STATUS_FULL             1
`define F_STATUS_EMPTY            2
`define F_STATUS_WRAP             3
`define F_STATUS_ERROR            4

`define F_CONTROL_DATA_SIZE           1:0
`define B_CONTROL_DATA_SIZE_WORD      2'b00
`define B_CONTROL_DATA_SIZE_HWORD     2'b01
`define B_CONTROL_DATA_SIZE_BYTE      2'b10
`define B_CONTROL_DATA_SIZE_UNDEFINED 2'b11


`define WB_DSP_SLAVE_BASE_ADDRESS       32'h7000_0000

`define WB_DSP_SLAVE_INPUT0_OFFSET      8'h00
`define F_DSP_SLAVE_EQUATION_NUMBER     7:0
`define B_DSP_EQUATION_NONE             8'h01
`define B_DSP_EQUATION_SUM              8'h01
`define B_DSP_EQUATION_MULTIPLY         8'h02
`define B_DSP_EQUATION_DTREE            8'h03

`define F_DSP_SLAVE_DATA_SIZE           9:8
`define F_DSP_SLAVE_DATA_SIGNED         10
`define F_DSP_SLAVE_ENABLE_MAC          11
`define F_DSP_SLAVE_SCALAR_MULTIPLY     12
`define F_DSP_SLAVE_EQUATION_START      31

`define F_DSP_DTREE_OUTPUT              7:0
`define F_DSP_DTREE_LEAF                31

`define WB_DSP_SLAVE_INPUT1_OFFSET      8'h04
`define F_DSP_SLAVE_INPUT_FILE0         07:00
`define F_DSP_SLAVE_INPUT_FILE1         15:08
`define F_DSP_SLAVE_INPUT_FILE2         23:16
`define F_DSP_SLAVE_INPUT_FILE3         31:24

`define WB_DSP_SLAVE_INPUT2_OFFSET      8'h08
`define F_DSP_SLAVE_INPUT_FILE4         07:00
`define F_DSP_SLAVE_INPUT_FILE5         15:08
`define F_DSP_SLAVE_INPUT_FILE6         23:16
`define F_DSP_SLAVE_INPUT_FILE7         31:24

`define WB_DSP_SLAVE_INPUT3_OFFSET      8'h0C
`define F_DSP_SLAVE_OUTPUT_FILE0        07:00
`define F_DSP_SLAVE_OUTPUT_FILE1        15:08
`define F_DSP_SLAVE_OUTPUT_FILE2        23:16
`define F_DSP_SLAVE_OUTPUT_FILE3        31:24


`define WB_DSP_SLAVE_INPUT4_OFFSET      8'h10
`define F_DSP_SLAVE_INPUT2_FILE4        07:00
`define F_DSP_SLAVE_INPUT2_FILE5        15:08
`define F_DSP_SLAVE_INPUT2_FILE6        23:16
`define F_DSP_SLAVE_INPUT2_FILE7        31:24

`define WB_DSP_SLAVE_OUTPUT0_OFFSET     8'h14
`define WB_DSP_SLAVE_OUTPUT1_OFFSET     8'h18
`define WB_DSP_SLAVE_OUTPUT2_OFFSET     8'h1C
`define WB_DSP_SLAVE_OUTPUT3_OFFSET     8'h20
`define WB_DSP_SLAVE_OUTPUT4_OFFSET     8'h24


`define DSP_EQUATIONS_MAX     3

`define WB_DAQ_SLAVE_BASE_ADDRESS       32'h8000_0000



`define TEST_TASKS  `TB.test_tasks
`define TEST_PASSED `TEST_TASKS.test_passed
`define TEST_FAILED `TEST_TASKS.test_failed
`define TEST_COMPARE  `TEST_TASKS.compare_values
`define TEST_COMPLETE `TEST_TASKS.all_tests_completed
