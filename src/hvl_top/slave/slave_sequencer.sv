`ifndef SLAVE_SEQUENCER_INCLUDED_
`define SLAVE_SEQUENCER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_sequencer
// It send transactions to driver via tlm ports
//--------------------------------------------------------------------------------------------
class slave_sequencer extends uvm_sequencer#(slave_tx);
  `uvm_component_utils(slave_sequencer)

  // Variable: sa_cfg_h;
  // Handle for slave agent configuration
  slave_agent_config sa_cfg_h;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_sequencer", uvm_component parent = null);

endclass : slave_sequencer

//--------------------------------------------------------------------------------------------
// Construct: new
// slave_sequencer class object is initialized
//
// Parameters:
//  name - slave_sequencer
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function slave_sequencer::new(string name = "slave_sequencer", uvm_component parent = null);
  super.new(name, parent);
endfunction : new

`endif
