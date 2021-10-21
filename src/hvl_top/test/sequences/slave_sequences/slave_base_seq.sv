`ifndef SLAVE_BASE_SEQ_INCLUDED_
`define SLAVE_BASE_SEQ_INCLUDED_

//-------------------------------------------------------------------------------------------
// Class: slave_base_base_sequence
// slave sequence 
//--------------------------------------------------------------------------------------------
class slave_base_seq extends uvm_sequence #(slave_tx);
  
  //factory registration
  `uvm_object_utils(slave_base_seq)

  //-------------------------------------------------------
  // Externally defined Function
  //-------------------------------------------------------
  extern function new(string name = "slave_base_seq");
endclass : slave_base_seq


//-----------------------------------------------------------------------------
// Constructor: new
// Initializes the slave_base_sequence class object
//
// Parameters:
//  name - instance name of the config_template
//-----------------------------------------------------------------------------

function slave_base_seq::new(string name = "slave_base_seq");
  super.new(name);
endfunction : new

`endif
