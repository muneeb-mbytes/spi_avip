`ifndef TEST_PKG_INCLUDED_
`define TEST_PKG_INCLUDED_

//-----------------------------------------------------------------------------------------
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
  import m_spi_seq_pkg::*;
  import s_spi_seq_pkg::*;
  import spi_virtual_seq_pkg::*;

 //including base_test for testing
 `include "base_test.sv"
 `include "spi_simple_fd_8b_test.sv"
 `include "spi_simple_fd_16b_test.sv"

endpackage : test_pkg

`endif

