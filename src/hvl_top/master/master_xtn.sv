`ifndef MASTER_XTN_INCLUDED_
`define MASTER_XTN_INCLUDED_

 //--------------------------------------------------------------------------------------------
 // Class: master_xtn.
 // Description of the class.
 // This class holds the data items required to drive stimulus to dut
 // and also holds methods that manipulatethose data items
 //--------------------------------------------------------------------------------------------
 class master_xtn extends uvm_sequence_item;
  
  //register with factory so we can override with uvm method in future if necessary.

  `uvm_object_utils(master_xtn)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_xtn");
  extern function void do_print(uvm_printer printer);
 endclass : master_xtn

//--------------------------------------------------------------------------------------------
// Construct: new
// initializes the class object
//
// Parameters:
//  name - master_xtn
//--------------------------------------------------------------------------------------------
  function master_xtn::new(string name = "master_xtn");
    super.new(name);
  endfunction : new

  function void master_xtn::do_print(uvm_printer printer);
    super.do_print(printer);
  endfunction : do_print
  

`endif

