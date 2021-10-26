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

  bit [7:0]data_master_out_slave_in;
  bit [7:0]data_master_in_slave_out;
  
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

//--------------------------------------------------------------------------------------------
// class : spi_seq_item_converter
// Description:
// class converting seq_item transactions into struct data items and viceversa
//--------------------------------------------------------------------------------------------

class spi_seq_item_converter;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern static function void from_class(input slave_tx input_conv_h,output spi_transfer_char_s output_conv_h);
  extern static function void to_class(output slave_tx output_conv_h,input spi_transfer_char_s input_conv_h);
  
endclass : spi_seq_item_converter

//--------------------------------------------------------------------------------------------
// function: from_class
// converting seq_item transactions into struct data items
//--------------------------------------------------------------------------------------------

function void spi_seq_item_converter::from_class(input slave_tx input_conv_h,output spi_transfer_char_s output_conv_h);
  foreach(output_conv_h.no_of_bits_transfer[i]) begin
  output_conv_h.master_out_slave_in[i] = input_conv_h.master_out_slave_in[i];
  output_conv_h.master_in_slave_out[i] = input_conv_h.master_in_slave_out[i];
//output_conv_h.no_of_bits_transfer = input_conv_h.no_of_bits_transfer;
  end
endfunction: from_class


//--------------------------------------------------------------------------------------------
// function:to_class
// converting struct data items into seq_item transactions
//--------------------------------------------------------------------------------------------
function void spi_seq_item_converter::to_class(output slave_tx output_conv_h,input spi_transfer_char_s input_conv_h);
  foreach(input_conv_h.no_of_bits_transfer[i]) begin
  output_conv_h = new();
  output_conv_h.master_out_slave_in[i] = input_conv_h.master_out_slave_in[i];
  output_conv_h.master_in_slave_out[i] = input_conv_h.master_in_slave_out[i];
//output_conv_h.no_of_bits_transfer = input_conv_h.no_of_bits_transfer;
  end
endfunction : to_class

`endif
