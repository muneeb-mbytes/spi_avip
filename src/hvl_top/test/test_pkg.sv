//--------------------------------------------------------------------------------------------
// Package: Test
// Description:
// Includes all the files written to run the simulation
//--------------------------------------------------------------------------------------------
package test_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  //-------------------------------------------------------
  // Importing the required packages
  //-------------------------------------------------------
  import spi_globals_pkg::*;
  import spi_master_pkg::*;
  import spi_slave_pkg::*;
  import spi_env_pkg::*;
  
  `include "master_virtual_sequence.sv"
  `include "slave_virtual_sequence.sv"
  
  `include "base_test.sv"

endpackage :test_pkg
