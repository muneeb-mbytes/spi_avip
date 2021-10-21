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
  import m_spi_seq_pkg::*;
  import s_spi_seq_pkg::*;
  import spi_env_pkg::*;


  //-------------------------------------------------------
  // Include all other files
  //-------------------------------------------------------
  `include "spi_fd_vseq_base.sv"
  `include "vseq1_fd_8b_seq.sv"
  `include "vseq1_fd_16b_seq.sv"
  
endpackage : spi_virtual_seq_pkg

`endif
