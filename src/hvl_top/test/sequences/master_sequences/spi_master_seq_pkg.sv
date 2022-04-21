`ifndef SPI_MASTER_SEQ_PKG_INCLUDED
`define SPI_MASTER_SEQ_PKG_INCLUDED

//-----------------------------------------------------------------------------------------
// Package: m_spi_seq
// Description:
// Includes all the files written to run the simulation
//-------------------------------------------------------------------------------------------
  package spi_master_seq_pkg;

//-------------------------------------------------------
// Import uvm package
//-------------------------------------------------------
 `include "uvm_macros.svh"
  import uvm_pkg::*;
  import spi_master_pkg::*;
  import spi_globals_pkg::*;

//-------------------------------------------------------
// Importing the required packages
//-------------------------------------------------------
 `include "master_base_seq.sv"
 `include "spi_fd_8b_master_seq.sv"
 `include "spi_fd_16b_master_seq.sv"
 `include "spi_fd_24b_master_seq.sv"
 `include "spi_fd_negative_scenarios_master_seq.sv"
 `include "spi_fd_32b_master_seq.sv"
 `include "spi_fd_64b_master_seq.sv"
 `include "spi_fd_8b_ct_master_seq.sv"
 `include "spi_fd_dct_master_seq.sv"
 `include "spi_fd_cross_master_seq.sv"
 `include "spi_fd_cpol0_cpha0_master_seq.sv"
 `include "spi_fd_cpol0_cpha1_master_seq.sv"
 `include "spi_fd_cpol1_cpha0_master_seq.sv"
 `include "spi_fd_cpol1_cpha1_master_seq.sv"
 `include "spi_fd_msb_master_seq.sv"
 `include "spi_fd_lsb_master_seq.sv"
 `include "spi_fd_maximum_bits_master_seq.sv"
 `include "spi_fd_c2t_delay_master_seq.sv"
 `include "spi_fd_t2c_delay_master_seq.sv"
 `include "spi_fd_baudrate_master_seq.sv"
 `include "spi_fd_rand_master_seq.sv"
 `include "spi_fd_no_of_slaves_master_seq.sv"
 `include "spi_dual_spi_type_master_seq.sv"
 `include "spi_quad_spi_type_master_seq.sv"
endpackage :spi_master_seq_pkg

`endif

