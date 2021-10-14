`ifndef SLAVE_SEQUENCER_INCLUDED_
`define SLAVE_SEQUENCER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_sequencer
// Class Description:
// This class sends transaction from sequencer to driver via tlm ports
//--------------------------------------------------------------------------------------------
class slave_sequencer extends uvm_sequencer #(slave_tx);

  //-------------------------------------------------------
  // Factory registration: To create a method and override later
  //-------------------------------------------------------
  `uvm_component_utils(slave_sequencer)

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

//--------------------------------------------------------------------------------------------

`endif

