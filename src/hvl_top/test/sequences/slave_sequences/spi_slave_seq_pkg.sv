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

//-------------------------------------------------------
// Importing the required packages
//-------------------------------------------------------
 `include "slave_base_seq.sv"
 `include "spi_fd_8b_slave_seq.sv"
 `include "spi_fd_16b_slave_seq.sv"

endpackage :spi_slave_seq_pkg

`endif


