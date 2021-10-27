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

//-------------------------------------------------------
// Importing the required packages
//-------------------------------------------------------
 `include "master_base_seq.sv"
 `include "spi_fd_8b_master_seq.sv"
 `include "spi_fd_16b_master_seq.sv"

endpackage :spi_master_seq_pkg

`endif

