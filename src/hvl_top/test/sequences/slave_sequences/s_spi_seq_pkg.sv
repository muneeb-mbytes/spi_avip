`ifndef S_SPI_SEQ_PKG_INCLUDED
`define S_SPI_SEQ_PKG_INCLUDED

//-----------------------------------------------------------------------------------------
// Package: s_spi_seq
// Description:
// Includes all the files written to run the simulation
//-------------------------------------------------------------------------------------------
  package s_spi_seq_pkg;

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
 `include "s_spi_fd_8b_seq.sv"
 `include "s_spi_fd_16b_seq.sv"

endpackage :s_spi_seq_pkg

`endif


