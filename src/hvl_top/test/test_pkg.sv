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

<<<<<<< HEAD
  //-------------------------------------------------------
  // Importing the required packages
  //-------------------------------------------------------
  import spi_master_pkg::*;
  import spi_slave_pkg::*;
  import spi_env_pkg::*;
  
  `include "master_virtual_sequence.sv"
  `include "slave_virtual_sequence.sv"
  
  `include "base_test.sv"
=======
  
  `include "slave_agent_config.sv"
  `include "master_agent_config.sv"
  `include "env_config.sv"
  
  //-------------------------------------------------------
  // Include master files
  //-------------------------------------------------------
  `include "master_xtn.sv"  
  `include "master_sequencer.sv"
  `include "master_driver_proxy.sv"
  `include "master_monitor_proxy.sv"
  `include "master_agent.sv"
  
  //`include "master_virtual_sequence.sv"
  `include "master_virtual_sequencer.sv"
 
  //-------------------------------------------------------
  // Include all other files
  //-------------------------------------------------------
  `include "slave_tx.sv"
  `include "slave_sequencer.sv"
  `include "slave_sequence.sv"
  `include "slave_driver_proxy.sv"
  `include "slave_monitor_proxy.sv"
  
  `include "slave_virtual_sequencer.sv"
  `include "slave_virtual_sequence.sv"
  `include "slave_agent.sv"
  
  `include "env.sv"
  `include "base_test.sv"
 
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27

endpackage :test_pkg
