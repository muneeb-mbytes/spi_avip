`ifndef SPI_SLAVE_PKG_INCLUDED_
`define SPI_SLAVE_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: spi_slave_pkg
//  Includes all the files related to SPI slave
//--------------------------------------------------------------------------------------------
package spi_slave_pkg;

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
  `include "slave_tx.sv"
  `include "slave_agent_config.sv"
  `include "slave_sequencer.sv"
  `include "slave_sequence.sv"
  `include "slave_driver_proxy.sv"
  `include "slave_monitor_proxy.sv"
  `include "slave_agent.sv"
  
endpackage : spi_slave_pkg

`endif
