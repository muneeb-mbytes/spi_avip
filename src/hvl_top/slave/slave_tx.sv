`ifndef SLAVE_TX_INCLUDED_
`define SLAVE_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_tx
<<<<<<< HEAD
// It's a transaction class that holds the SPI data items for generating the stimulus
//--------------------------------------------------------------------------------------------
class slave_tx extends uvm_sequence_item;
=======
// Class Description: 
//  slave_tx is extended from uvm_sequence_item to get required sequence items
//--------------------------------------------------------------------------------------------
class slave_tx extends uvm_sequence_item;

  //-------------------------------------------------------
  // Factory Registration is done to create method and override later
  //-------------------------------------------------------
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
  `uvm_object_utils(slave_tx)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_tx");
  extern function void do_print(uvm_printer printer);

endclass : slave_tx

//--------------------------------------------------------------------------------------------
// Construct: new
<<<<<<< HEAD
// Constructs the slave_tx object
//  
//
// Parameters:
=======
//  New method allocates memory and return address to class handle
//
//Parameters:
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
//  name - slave_tx
//--------------------------------------------------------------------------------------------
function slave_tx::new(string name = "slave_tx");
  super.new(name);
endfunction : new

<<<<<<< HEAD
// TODO(mshariff): Have print, cpoy compare methods
=======
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
function void slave_tx::do_print(uvm_printer printer);
  super.do_print(printer);
endfunction : do_print

`endif
<<<<<<< HEAD
=======

>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
