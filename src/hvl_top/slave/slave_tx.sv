`ifndef SLAVE_TX_INCLUDED_
`define SLAVE_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_tx
// It's a transaction class that holds the SPI data items for generating the stimulus
//--------------------------------------------------------------------------------------------
class slave_tx extends uvm_sequence_item;
  `uvm_object_utils(slave_tx)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_tx");
  extern function void do_print(uvm_printer printer);

endclass : slave_tx

//--------------------------------------------------------------------------------------------
// Construct: new
// Constructs the slave_tx object
//  
//
// Parameters:
//  name - slave_tx
//--------------------------------------------------------------------------------------------
function slave_tx::new(string name = "slave_tx");
  super.new(name);
endfunction : new

// TODO(mshariff): Have print, cpoy compare methods
function void slave_tx::do_print(uvm_printer printer);
  super.do_print(printer);
endfunction : do_print

`endif
