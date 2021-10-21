`ifndef MASTER_TX_INCLUDED_
`define MASTER_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_tx.
//It's a transacion class that holds the SPI data items for generating the stimulus
//--------------------------------------------------------------------------------------------
class master_tx extends uvm_sequence_item;
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
//have print,copy compare methods
  function void master_tx::do_print(uvm_printer printer);
    super.do_print(printer);
  endfunction : do_print
  

`endif

