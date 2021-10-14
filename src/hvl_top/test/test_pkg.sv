//--------------------------------------------------------------------------------------------
// Package: Test
// Description:
// Includes all the files written to run the simulation
//--------------------------------------------------------------------------------------------
package test_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;

  //-------------------------------------------------------
  // Include all other files
  //-------------------------------------------------------
  `include "slave_tx.sv"
  `include "slave_sequence.sv"
  `include "slave_sequencer.sv"
  `include "slave_driver_proxy.sv"
  `include "slave_monitor_proxy.sv"
  `include "slave_agent.sv"
  
  `include "slave_virtual_sequence.sv"
  `include "slave_virtual_sequencer.sv"
  `include "env.sv"

  `include "base_test.sv"

  // `include "slave_agent_config.sv"
  // `include "env_config.sv"

endpackage :test_pkg
