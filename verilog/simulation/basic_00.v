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

   initial begin
      $display("Basic Test Case");


      #500000;
      `TEST_COMPLETE;
   end

endmodule // test_case
