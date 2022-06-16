`ifndef SPI_VIRTUAL_SEQ_PKG_INCLUDED_
`define SPI_VIRTUAL_SEQ_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: spi_virtual_seq_pkg
//  Includes all the files related to SPI virtual sequences
//--------------------------------------------------------------------------------------------
package spi_virtual_seq_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;
  import spi_master_pkg::*;
  import spi_slave_pkg::*;
  import spi_master_seq_pkg::*;
  import spi_slave_seq_pkg::*;
  import spi_env_pkg::*;


  //-------------------------------------------------------
  // Include all other files
  //-------------------------------------------------------
  `include "spi_fd_virtual_seq_base.sv"
  `include "spi_fd_8b_virtual_seq.sv"
  `include "spi_fd_16b_virtual_seq.sv"
  `include "spi_fd_24b_virtual_seq.sv"
  `include "spi_fd_negative_scenarios_virtual_seq.sv"
  `include "spi_fd_32b_virtual_seq.sv"
  `include "spi_fd_64b_virtual_seq.sv"
  `include "spi_fd_8b_ct_virtual_seq.sv"
  `include "spi_fd_dct_virtual_seq.sv"
  `include "spi_fd_cross_virtual_seq.sv"
  `include "spi_fd_cpol0_cpha0_virtual_seq.sv"
  `include "spi_fd_cpol0_cpha1_virtual_seq.sv"
  `include "spi_fd_cpol1_cpha0_virtual_seq.sv"
  `include "spi_fd_cpol1_cpha1_virtual_seq.sv"
  `include "spi_fd_msb_virtual_seq.sv"
  `include "spi_fd_lsb_virtual_seq.sv"
  `include "spi_fd_maximum_bits_virtual_seq.sv"
  `include "spi_fd_c2t_delay_virtual_seq.sv"
  `include "spi_fd_t2c_delay_virtual_seq.sv"
  `include "spi_fd_baudrate_virtual_seq.sv"
  `include "spi_fd_rand_virtual_seq.sv"
  `include "spi_fd_no_of_slaves_virtual_seq.sv"
  `include "spi_dual_spi_type_virtual_seq.sv"
  `include "spi_quad_spi_type_virtual_seq.sv"
endpackage : spi_virtual_seq_pkg

`endif
