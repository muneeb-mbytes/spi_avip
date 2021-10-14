`ifndef SLAVE_TX_INCLUDED_
`define SLAVE_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_tx
// Class Description: 
//  slave_tx is extended from uvm_sequence_item to get required sequence items
//--------------------------------------------------------------------------------------------
class slave_tx extends uvm_sequence_item;

  //-------------------------------------------------------
  // Factory Registration is done to create method and override later
  //-------------------------------------------------------
  `uvm_object_utils(slave_tx)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_tx");
  extern function void do_print(uvm_printer printer);

endclass : slave_tx

//--------------------------------------------------------------------------------------------
// Construct: new
//  New method allocates memory and return address to class handle
//
//Parameters:
//  name - slave_tx
//--------------------------------------------------------------------------------------------
function slave_tx::new(string name = "slave_tx");
  super.new(name);
endfunction : new

function void slave_tx::do_print(uvm_printer printer);
  super.do_print(printer);
endfunction : do_print

`endif

