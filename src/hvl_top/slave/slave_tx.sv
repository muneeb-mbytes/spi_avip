`ifndef SLAVE_TX_INCLUDED_
`define SLAVE_TX_INCLUDED_

`define cs_length 2
`define DW 2**`SIZE
`define SIZE 3
//--------------------------------------------------------------------------------------------
// Class: slave_tx
// It's a transaction class that holds the SPI data items for generating the stimulus
//--------------------------------------------------------------------------------------------
class slave_tx extends uvm_sequence_item;
  `uvm_object_utils(slave_tx)
 
  //-------------------------------------------------------
  // Instantiating SPI signals
  //-------------------------------------------------------
  bit sclk;
//  bit cs;
  bit cpol;
  bit cpha;
  
  bit mosi0;
  bit mosi1;
  bit mosi2;
  bit mosi3;

  rand bit miso0;
  rand bit miso1;
  rand bit miso2;
  rand bit miso3;

  //-------------------------------------------------------
  // Instantiation of Data Signals
  //-------------------------------------------------------
  bit [7:0] data_master_out_slave_in;
  bit [7:0] data_master_in_slave_out;

  //input signals
  rand bit [`DW-1:0]master_in_slave_out[$];
       bit [`cs_length-1:0] cs;

       bit [`DW-1:0] master_out_slave_in[$];

//--------------------------------------------------------------------------------------------
// Constraints for SPI
//--------------------------------------------------------------------------------------------

constraint miso{master_in_slave_out.size()>0 && master_in_slave_out.size()<8;}

//-------------------------------------------------------
// Externally defined Tasks and Functions
//-------------------------------------------------------
  extern function new(string name = "slave_tx");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);

endclass : slave_tx

//--------------------------------------------------------------------------------------------
// Construct: new
// initializes the class object
// Parameters: 
// instance name of the slave template
// Constructs the slave_tx object
//  
// Parameters:
//  name - slave_tx
//--------------------------------------------------------------------------------------------
function slave_tx::new(string name = "slave_tx");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// do_copy method
//--------------------------------------------------------------------------------------------

function void slave_tx::do_copy (uvm_object rhs);
  slave_tx rhs_;

  if(!$cast(rhs_,rhs)) begin
  `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);
  cs= rhs_.cs;
  foreach(master_in_slave_out[i])
  master_in_slave_out[i]= rhs_.master_in_slave_out[i];
  foreach(master_out_slave_in[i])
  master_out_slave_in[i]= rhs_.master_out_slave_in[i];
endfunction:do_copy


//--------------------------------------------------------------------------------------------
// do_compare method
//--------------------------------------------------------------------------------------------
function bit  slave_tx::do_compare (uvm_object rhs,uvm_comparer comparer);
  slave_tx rhs_;

  if(!$cast(rhs_,rhs)) begin
  `uvm_fatal("do_compare","cast of the rhs object failed")
  return 0;
  end

  return super.do_compare(rhs,comparer) &&
  master_in_slave_out== rhs_.master_in_slave_out &&
  master_out_slave_in== rhs_.master_out_slave_in;
endfunction:do_compare


//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void slave_tx::do_print(uvm_printer printer);
  super.do_print(printer);
       printer.print_field( "cs", cs , 2,UVM_DEC);
       foreach(master_in_slave_out[i])
       printer.print_field($sformatf("master_in_slave_out[%0d]",i),this.master_in_slave_out[i],8,UVM_HEX);
       foreach(master_out_slave_in[i])
       printer.print_field($sformatf("master_out_slave_in[%0d]",i),this.master_out_slave_in[i],8,UVM_HEX);
endfunction:do_print

/*
//-------------------------------------------------------
// Function: do_copy
//  Copying transaction to another object
//
// Parameters: 
//  name - rhs
//-------------------------------------------------------
function void slave_tx::do_copy (uvm_object rhs);
  
  // Variable: rhs_h
  // New handle used to copy
  slave_tx rhs_h;
  
  if(!$cast(rhs_h,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);

  cs    = rhs_h.cs;
  mosi0 = rhs_h.mosi0;
  miso0 = rhs_h.miso0;

endfunction : do_copy

//-------------------------------------------------------
// Function: do_compare
//  Comparing transaction from another object
//
// Parameters: 
//  name - rhs
//-------------------------------------------------------
function bit slave_tx::do_compare (uvm_object rhs, uvm_comparer comparer);
  
  // Variable: rhs_h
  // New handle used to copy
  slave_tx rhs_h;
  
  if(!$cast(rhs_h,rhs)) begin
    `uvm_fatal("do_compare","cast of the rhs object failed")
    return 0;
  end
  
  return super.do_compare(rhs,comparer) &&
  cs    == rhs_h.cs &&
  miso0 == rhs_h.miso0 &&
  mosi0 == rhs_h.mosi0;

endfunction:do_compare 

//-------------------------------------------------------
// Function: do_print
//  Comparing transaction from another object
//
// Parameters: 
//  name - printer
//-------------------------------------------------------
function void slave_tx::do_print(uvm_printer printer);
  super.do_print(printer);
         
  printer.print_field ("sclk",  sclk, 1, UVM_DEC);
  printer.print_field ("cs",    cs,   1, UVM_DEC);
  printer.print_field ("cpol",  cpol, 1, UVM_DEC);
  printer.print_field ("cpha",  cpha, 1, UVM_DEC);
  
  printer.print_field ("master_out_slave_in", data_master_out_slave_in, 8, UVM_HEX);
  printer.print_field ("master_in_slave_out", data_master_in_slave_out, 8, UVM_HEX);
  
  printer.print_field ("miso0", miso0, 1, UVM_DEC);
  printer.print_field ("miso1", miso1, 1, UVM_DEC);
  printer.print_field ("miso2", miso2, 1, UVM_DEC);
  printer.print_field ("miso3", miso3, 1, UVM_DEC);
  
  printer.print_field ("mosi0", mosi0, 1, UVM_DEC);
  printer.print_field ("mosi1", mosi1, 1, UVM_DEC);
  printer.print_field ("mosi2", mosi2, 1, UVM_DEC);
  printer.print_field ("mosi3", mosi3, 1, UVM_DEC);

endfunction : do_print
*/
`endif
