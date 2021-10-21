`ifndef SLAVE_SEQUENCER_INCLUDED_
`define SLAVE_SEQUENCER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_sequencer
<<<<<<< HEAD
// It send transactions to driver via tlm ports
//--------------------------------------------------------------------------------------------
class slave_sequencer extends uvm_sequencer#(slave_tx);
=======
// Class Description:
// This class sends transaction from sequencer to driver via tlm ports
//--------------------------------------------------------------------------------------------
class slave_sequencer extends uvm_sequencer #(slave_tx);

  //-------------------------------------------------------
  // Factory registration: To create a method and override later
  //-------------------------------------------------------
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
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

<<<<<<< HEAD
`endif
=======
//--------------------------------------------------------------------------------------------

`endif

>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
