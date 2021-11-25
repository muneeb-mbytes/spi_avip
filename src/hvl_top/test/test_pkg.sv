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
  import spi_master_seq_pkg::*;
  import spi_slave_seq_pkg::*;
  import spi_virtual_seq_pkg::*;

 //including base_test for testing
 `include "base_test.sv"
 `include "assertions_base_test.sv"
 `include "spi_simple_fd_8b_test.sv"
 `include "spi_simple_fd_16b_test.sv"
 `include "spi_simple_fd_24b_test.sv"
 `include "spi_simple_fd_32b_test.sv"
 `include "spi_simple_fd_64b_test.sv"
 `include "spi_simple_fd_8b_ct_test.sv"
 `include "spi_simple_fd_dct_test.sv"
 `include "spi_simple_fd_msb_test.sv"
 `include "spi_simple_fd_lsb_test.sv"
 `include "spi_simple_fd_cross_test.sv"
 `include "spi_simple_fd_cpol0_cpha1_test.sv"
 `include "spi_simple_fd_cpol0_cpha0_test.sv"
 `include "spi_simple_fd_cpol0_cpha1_test.sv"
 `include "spi_simple_fd_cpol1_cpha0_test.sv"
 `include "spi_simple_fd_cpol1_cpha1_test.sv"
 `include "spi_simple_fd_maximum_bits_test.sv"
 `include "spi_simple_fd_c2t_delay_test.sv"
 `include "spi_simple_fd_t2c_delay_test.sv"
 `include "spi_simple_fd_baudrate_test.sv"
 `include "spi_simple_fd_no_of_slaves_test.sv"
 `include "spi_simple_fd_rand_test.sv"
 `include "spi_dual_spi_type_test.sv"
 `include "spi_quad_spi_type_test.sv"
 `include "spi_simple_fd_negative_scenarios_test.sv"
endpackage : test_pkg

`endif

