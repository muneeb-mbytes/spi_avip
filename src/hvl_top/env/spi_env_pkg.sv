`ifndef SPI_ENV_PKG_INCLUDED_
`define SPI_ENV_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: spi_env_pkg
//  Includes all the files related to SPI env
//--------------------------------------------------------------------------------------------
package spi_env_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  //-------------------------------------------------------
  // Importing the required packages
  //-------------------------------------------------------
  import spi_globals_pkg::*;
  import spi_master_pkg::*;
  import spi_slave_pkg::*;

  //-------------------------------------------------------
  // Include all other files
  //-------------------------------------------------------
  `include "env_config.sv"

  `include "master_virtual_sequencer.sv"
  `include "slave_virtual_sequencer.sv"
  `include "virtual_sequencer.sv"

  // SCOREBOARD
  // Coverage 

  `include "env.sv"

endpackage : spi_env_pkg

`endif
