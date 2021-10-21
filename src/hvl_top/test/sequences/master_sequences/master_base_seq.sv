`ifndef MASTER_BASE_SEQ_INCLUDED_
`define MASTER_BASE_SEQ_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_base_seq 
// creating master_base_seq class extends from uvm_sequence
//--------------------------------------------------------------------------------------------
class master_base_seq extends uvm_sequence #(master_tx);
  //factory registration
  `uvm_object_utils(master_base_seq)

  //-------------------------------------------------------
  // Externally defined Function
  //-------------------------------------------------------
  extern function new(string name = "master_base_seq");
endclass : master_base_seq


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the master_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------

function master_base_seq::new(string name = "master_base_seq");
  super.new(name);
endfunction : new

`endif
