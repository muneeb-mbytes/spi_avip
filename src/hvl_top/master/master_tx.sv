`ifndef MASTER_TX_INCLUDED_
`define MASTER_TX_INCLUDED_

 //--------------------------------------------------------------------------------------------
 // Class: master_tx.
 // Description of the class.
 // This class holds the data items required to drive stimulus to dut
 // and also holds methods that manipulatethose data items
 //--------------------------------------------------------------------------------------------
 class master_tx extends uvm_sequence_item;
  
  //register with factory so we can override with uvm method in future if necessary.

  `uvm_object_utils(master_tx)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_tx");
  extern function void do_print(uvm_printer printer);
 endclass : master_tx

//--------------------------------------------------------------------------------------------
// Construct: new
// initializes the class object
//
// Parameters:
//  name - master_tx
//--------------------------------------------------------------------------------------------
  function master_tx::new(string name = "master_tx");
    super.new(name);
  endfunction : new

  function void master_tx::do_print(uvm_printer printer);
    super.do_print(printer);
  endfunction : do_print
  

`endif

