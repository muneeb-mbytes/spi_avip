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
 bit sclk;
 bit ss_n;

 rand bit [1:0]cpol;
 rand bit [1:0]cpha;

 bit [7:0]data_in_mosi;

 rand bit mosi;

 bit miso; 

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
 
    printer.print_field("sclk", sclk, 1,UVM_DEC);
    printer.print_field("ss_n", ss_n, 1,UVM_DEC);
    printer.print_field("cpol", cpol, 2, UVM_DEC);
    printer.print_field("cpha", cpha, 2, UVM_DEC);
  
    printer.print_field("data_in_mosi", data_in_mosi, 8, UVM_HEX);
    printer.print_field("miso", miso, 1, UVM_DEC);
    printer.print_field("mosi", mosi, 1, UVM_DEC);
  
  endfunction : do_print
  

`endif

