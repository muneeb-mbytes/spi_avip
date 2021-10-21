`ifndef M_SPI_SEQ_PKG_INCLUDED
`define M_SPI_SEQ_PKG_INCLUDED

//-----------------------------------------------------------------------------------------
// Package: m_spi_seq
// Description:
// Includes all the files written to run the simulation
//-------------------------------------------------------------------------------------------
  package m_spi_seq_pkg;

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
 `include "m_spi_fd_8b_seq.sv"
 `include "m_spi_fd_16b_seq.sv"

endpackage :m_spi_seq_pkg

`endif

