`ifndef SPI_SLAVE_SEQ_PKG_INCLUDED
`define SPI_SLAVE_SEQ_PKG_INCLUDED

//-----------------------------------------------------------------------------------------
// Package: s_spi_seq
// Description:
// Includes all the files written to run the simulation
//-------------------------------------------------------------------------------------------
  package spi_slave_seq_pkg;

//-------------------------------------------------------
// Import uvm package
//-------------------------------------------------------
 `include "uvm_macros.svh"
  import uvm_pkg::*;
  import spi_slave_pkg::*;
  import spi_globals_pkg::*;

//-------------------------------------------------------
// Importing the required packages
//-------------------------------------------------------
 `include "slave_base_seq.sv"
 `include "spi_fd_8b_slave_seq.sv"
 `include "spi_fd_16b_slave_seq.sv"
 `include "spi_fd_24b_slave_seq.sv"
 `include "spi_fd_negative_scenarios_slave_seq.sv"
 `include "spi_fd_32b_slave_seq.sv"
 `include "spi_fd_64b_slave_seq.sv"
 `include "spi_fd_8b_ct_slave_seq.sv"
 `include "spi_fd_dct_slave_seq.sv"
 `include "spi_fd_msb_slave_seq.sv"
 `include "spi_fd_lsb_slave_seq.sv"
 `include "spi_fd_cross_slave_seq.sv"
 `include "spi_fd_cpol0_cpha0_slave_seq.sv"
 `include "spi_fd_cpol0_cpha1_slave_seq.sv"
 `include "spi_fd_cpol1_cpha0_slave_seq.sv"
 `include "spi_fd_cpol1_cpha1_slave_seq.sv"
 `include "spi_fd_maximum_bits_slave_seq.sv"
 `include "spi_fd_c2t_delay_slave_seq.sv"
 `include "spi_fd_t2c_delay_slave_seq.sv"
 `include "spi_fd_baudrate_slave_seq.sv"
 `include "spi_fd_rand_slave_seq.sv"
 `include "spi_fd_no_of_slaves_slave_seq.sv"
 `include "spi_dual_spi_type_slave_seq.sv"
 `include "spi_quad_spi_type_slave_seq.sv"
endpackage :spi_slave_seq_pkg

`endif


