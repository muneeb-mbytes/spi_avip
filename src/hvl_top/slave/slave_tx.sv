`ifndef SLAVE_TX_INCLUDED_
`define SLAVE_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
//  Class: slave_tx
//  It's a transaction class that holds the SPI data items for generating the stimulus
//--------------------------------------------------------------------------------------------
class slave_tx extends uvm_sequence_item;
  `uvm_object_utils(slave_tx)

  //-------------------------------------------------------
  // Instantiating SPI signals
  //-------------------------------------------------------
  // TODO(mshariff): Not required
  bit cs;

  //input signals
  rand bit [CHAR_LENGTH-1:0]master_in_slave_out[];

  bit [CHAR_LENGTH-1:0] master_out_slave_in[];

  //--------------------------------------------------------------------------------------------
  // Constraints for SPI
  //--------------------------------------------------------------------------------------------

  constraint miso_c { master_in_slave_out.size() > 0 ;
                      master_in_slave_out.size() < MAXIMUM_BITS/CHAR_LENGTH;}

  constraint max_bits_miso{foreach(master_in_slave_out[i])
                                    master_in_slave_out[i]%8 ==0;}

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_tx");
  extern function void do_copy(uvm_object rhs);
  extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
  extern function void do_print(uvm_printer printer);

endclass : slave_tx

//--------------------------------------------------------------------------------------------
//  Construct: new
//  initializes the class object
//  Parameters: 
//  instance name of the slave template
//  Constructs the slave_tx object
//  
//  Parameters:
//  name - slave_tx
//--------------------------------------------------------------------------------------------
function slave_tx::new(string name = "slave_tx");
  super.new(name);  
endfunction : new

//--------------------------------------------------------------------------------------------
//do_copy method
//--------------------------------------------------------------------------------------------

function void slave_tx::do_copy (uvm_object rhs);
  slave_tx rhs_;

  if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("do_copy","cast of the rhs object failed")
  end

  super.do_copy(rhs);

  master_in_slave_out = rhs_.master_in_slave_out;
  master_out_slave_in = rhs_.master_out_slave_in;

endfunction : do_copy


 //-------------------------------------------------------
 //  do_compare method
 //-------------------------------------------------------
function bit slave_tx::do_compare (uvm_object rhs,uvm_comparer comparer);
  slave_tx rhs_;
  if(!$cast(rhs_,rhs)) begin
    `uvm_fatal("do_compare","cast of the rhs object failed")
     return 0;
  end

  // TODO(mshariff): Redo this logic, keeping in mind the arrays
  return super.do_compare(rhs,comparer) &&
  master_in_slave_out== rhs_.master_in_slave_out &&
  master_out_slave_in== rhs_.master_out_slave_in;
endfunction : do_compare

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void slave_tx::do_print(uvm_printer printer);
  super.do_print(printer);
  foreach(master_in_slave_out[i]) begin
    printer.print_field($sformatf("master_in_slave_out[%0d]",i),this.master_in_slave_out[i],8,UVM_HEX);
  end
  foreach(master_out_slave_in[i]) begin
    printer.print_field($sformatf("master_out_slave_in[%0d]",i),this.master_out_slave_in[i],8,UVM_HEX);
  end

endfunction : do_print

`endif
