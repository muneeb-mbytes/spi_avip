`ifndef SLAVE_SPI_SEQ_ITEM_CONVERTER_INCLUDED_
`define SLAVE_SPI_SEQ_ITEM_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// class : slave_spi_seq_item_converter
// Description:
// class converting seq_item transactions into struct data items and viceversa
//--------------------------------------------------------------------------------------------

class slave_spi_seq_item_converter extends uvm_object;
  
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_spi_seq_item_converter");
  extern static function void from_class(input slave_tx input_conv_h,
                                         output spi_transfer_char_s output_conv);
  extern static function void to_class(input spi_transfer_char_s input_conv,
                                        output slave_tx output_conv_h);
  extern function void from_class_msb_first(input slave_tx input_conv_h, 
                                            output spi_transfer_char_s output_conv);
  extern function void do_print(uvm_printer printer);

endclass : slave_spi_seq_item_converter

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - slave_spi_seq_item_converter
//--------------------------------------------------------------------------------------------
function slave_spi_seq_item_converter::new(string name = "slave_spi_seq_item_converter");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// function: from_class
// converting seq_item transactions into struct data items
//--------------------------------------------------------------------------------------------
function void slave_spi_seq_item_converter::from_class(input slave_tx input_conv_h,
                                                        output spi_transfer_char_s output_conv);

  output_conv.no_of_miso_bits_transfer = input_conv_h.master_in_slave_out.size()*CHAR_LENGTH;
  `uvm_info("slave_seq_item_conv_class",
  $sformatf("no_of_miso_bits_transfer = \n %p",
  output_conv.no_of_miso_bits_transfer),UVM_HIGH)

  for(int i=0; i<input_conv_h.master_in_slave_out.size(); i++) begin
    //output_conv.master_in_slave_out = output_conv.master_in_slave_out << CHAR_LENGTH;
    output_conv.master_in_slave_out[i][CHAR_LENGTH-1:0] = input_conv_h.master_in_slave_out[i];    
    `uvm_info("slave_seq_item_conv_class",
    $sformatf("output_conv_master_in_slave_out = \n %p",output_conv.master_in_slave_out),UVM_HIGH)
    //output_conv.master_in_slave_out[i] = input_conv_h.master_in_slave_out[i];    
  end

endfunction: from_class 

//--------------------------------------------------------------------------------------------
// function: from_class
// converting seq_item transactions into struct data items when msb is high
//--------------------------------------------------------------------------------------------
function void slave_spi_seq_item_converter::from_class_msb_first(input slave_tx input_conv_h,
                                                           output spi_transfer_char_s output_conv);
  
  output_conv.no_of_mosi_bits_transfer = input_conv_h.master_out_slave_in.size()*CHAR_LENGTH;
  
  for(int i=output_conv.no_of_mosi_bits_transfer; i>0; i++) begin
    output_conv.master_out_slave_in[i] = input_conv_h.master_out_slave_in[i];
  end

endfunction: from_class_msb_first

//--------------------------------------------------------------------------------------------
// function:to_class
// converting struct data items into seq_item transactions
//--------------------------------------------------------------------------------------------
function void slave_spi_seq_item_converter::to_class(input spi_transfer_char_s input_conv, 
                                                      output slave_tx output_conv_h);
  output_conv_h = new();

  // Defining the size of arrays
  output_conv_h.master_out_slave_in = new[input_conv.no_of_mosi_bits_transfer/CHAR_LENGTH];
  //output_conv_h.master_out_slave_in = new[input_conv.no_of_mosi_bits_transfer];
  output_conv_h.master_in_slave_out = new[input_conv.no_of_miso_bits_transfer/CHAR_LENGTH];
  //output_conv_h.master_in_slave_out = new[input_conv.no_of_miso_bits_transfer];

  // Storing the values in the respective arrays
  for(int i=0; i<input_conv.no_of_mosi_bits_transfer/CHAR_LENGTH; i++) begin
  //for(int i=0; i<input_conv.no_of_mosi_bits_transfer; i++) begin
    output_conv_h.master_out_slave_in[i] = input_conv.master_out_slave_in[i][CHAR_LENGTH-1:0];
    output_conv_h.master_in_slave_out[i] = input_conv.master_in_slave_out[i][CHAR_LENGTH-1:0];
  //  output_conv_h.master_out_slave_in[i] = input_conv.master_out_slave_in[i];
  //  output_conv_h.master_in_slave_out[i] = input_conv.master_in_slave_out[i];
  end
  
endfunction: to_class

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void slave_spi_seq_item_converter::do_print(uvm_printer printer);

  spi_transfer_char_s spi_st;
  super.do_print(printer);

  foreach(spi_st.cs[i]) begin
    printer.print_field( "cs", spi_st.cs , 2,UVM_BIN);
  end

  foreach(spi_st.master_out_slave_in[i]) begin
    printer.print_field($sformatf("master_out_slave_in[%0d]",i),spi_st.master_out_slave_in[i],8,UVM_HEX);
  end

  foreach(spi_st.master_in_slave_out[i]) begin
    printer.print_field($sformatf("master_in_slave_out[%0d]",i,),spi_st.master_in_slave_out[i],8,UVM_HEX);
  end

endfunction : do_print

`endif
