//--------------------------------------------------------------------------------------------
// Module: Hvl top module
//--------------------------------------------------------------------------------------------
module hvl_top;

  //-------------------------------------------------------
  // Package : Importing Uvm Pakckage and Test Package
  //-------------------------------------------------------
  import test_pkg::*;
  import uvm_pkg::*;

  //-------------------------------------------------------
  // run_test for simulation
  //-------------------------------------------------------
  initial begin : START_TEST 
    
    // The test to start is given at the command line
    // The command-line UVM_TESTNAME takes the precedance
    run_test("base_test");

  end

endmodule : hvl_top
