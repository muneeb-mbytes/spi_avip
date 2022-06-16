`ifndef MASTER_TX_INCLUDED_
`define MASTER_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_tx
// Description of the class
// This class holds the data items required to drive stimulus to dut
// and also holds methods that manipulate those data items
//--------------------------------------------------------------------------------------------
class master_tx extends uvm_sequence_item;
  
  //register with factory so we can override with uvm method in future if necessary.

  `uvm_object_utils(master_tx)

  //input signals
  rand bit [CHAR_LENGTH-1:0]master_out_slave_in[];
  rand bit [NO_OF_SLAVES-1:0] cs;
  bit [CHAR_LENGTH-1:0] master_in_slave_out[];
  rand bit [CHAR_LENGTH/2-1:0]mosi0[];
  rand bit [CHAR_LENGTH/2-1:0]mosi1[];
       bit [CHAR_LENGTH/2-1:0]miso0[];
       bit [CHAR_LENGTH/2-1:0]miso1[];
  //--------------------------------------------------------------------------------------------
  // Constraints for SPI
  //--------------------------------------------------------------------------------------------

 constraint mosi_c { master_out_slave_in.size() > 0 ;
                     master_out_slave_in.size() < MAXIMUM_BITS/CHAR_LENGTH;}

 // constraint dual_spi_bits{foreach(mosi0[i])
 //                          if (i%2==0) 
 //                             mosi0[i]%2==0;
 //                          else
 //                             mosi0[i]%2!=0;}


  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_tx");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);
endclass : master_tx

//--------------------------------------------------------------------------------------------
//  Construct: new
//  initializes the class object
//
//  Parameters:
//  name - master_tx
//--------------------------------------------------------------------------------------------
function master_tx::new(string name = "master_tx");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// do_copy method
//--------------------------------------------------------------------------------------------

function void master_tx::do_copy (uvm_object rhs);
  master_tx rhs_;
  
  if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end
  super.do_copy(rhs);

  cs = rhs_.cs;
  master_in_slave_out = rhs_.master_in_slave_out;
  master_out_slave_in = rhs_.master_out_slave_in;

endfunction : do_copy


//--------------------------------------------------------------------------------------------
// do_compare method
//--------------------------------------------------------------------------------------------
function bit  master_tx::do_compare (uvm_object rhs,uvm_comparer comparer);
  master_tx rhs_;

  if(!$cast(rhs_,rhs)) begin
  `uvm_fatal("FATAL_MASTER_TX_DO_COMPARE_FAILED","cast of the rhs object failed")
  return 0;
  end

  return super.do_compare(rhs,comparer) &&
  master_out_slave_in== rhs_.master_out_slave_in &&
  master_in_slave_out== rhs_.master_in_slave_out;
endfunction : do_compare

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void master_tx::do_print(uvm_printer printer);
  super.do_print(printer);
  printer.print_field( "cs", cs , 2,UVM_BIN);
  foreach(master_out_slave_in[i]) begin
    printer.print_field($sformatf("master_out_slave_in[%0d]",i),this.master_out_slave_in[i],8,UVM_HEX);
  end
  foreach(master_in_slave_out[i]) begin
    printer.print_field($sformatf("master_in_slave_out[%0d]",i),this.master_in_slave_out[i],8,UVM_HEX);
  end
  foreach(mosi0[i]) begin
    printer.print_field($sformatf("mosi0[%0d]",i),this.mosi0[i],4,UVM_HEX);
  end
  foreach(mosi1[i]) begin
    printer.print_field($sformatf("mosi1[%0d]",i),this.mosi1[i],4,UVM_HEX);
  end
  foreach(miso0[i]) begin
    printer.print_field($sformatf("miso0[%0d]",i),this.miso0[i],4,UVM_HEX);
  end
  foreach(miso1[i]) begin
    printer.print_field($sformatf("miso1[%0d]",i),this.miso1[i],4,UVM_HEX);
  end




endfunction : do_print

`endif

