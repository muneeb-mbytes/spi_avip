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
  
endpackage : spi_virtual_seq_pkg

`endif
