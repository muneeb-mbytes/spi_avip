`ifndef SPI_MASTER_PKG_INCLUDED_
`define SPI_MASTER_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: spi_master_pkg
//  Includes all the files related to SPI master
//--------------------------------------------------------------------------------------------
package spi_master_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;
 
  // Import spi_globals_pkg 
  import spi_globals_pkg::*;

  //-------------------------------------------------------
  // Include all other files
  //-------------------------------------------------------
  `include "master_tx.sv"
  `include "master_agent_config.sv"
  `include "master_sequencer.sv"
  `include "master_sequence.sv"
  `include "master_driver_proxy.sv"
  `include "master_monitor_proxy.sv"
  `include "master_agent.sv"
  
endpackage : spi_master_pkg

`endif
