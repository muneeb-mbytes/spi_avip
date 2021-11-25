`ifndef MASTER_SPI_SEQ_ITEM_CONVERTER_INCLUDED_
`define MASTER_SPI_SEQ_ITEM_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// class : master_spi_seq_item_converter
// Description:
// class converting seq_item transactions into struct data items and viceversa
//--------------------------------------------------------------------------------------------

class master_spi_seq_item_converter extends uvm_object;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_spi_seq_item_converter");
  extern static function void from_class(input master_tx input_conv_h,
                                         output spi_transfer_char_s output_conv);
  extern static function void to_class(input spi_transfer_char_s input_conv,
                                        output master_tx output_conv_h);
  extern function void from_class_msb_first(input master_tx input_conv_h, 
                                            output spi_transfer_char_s output_conv);
  extern function void do_print(uvm_printer printer);

endclass : master_spi_seq_item_converter

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - master_spi_seq_item_converter
//--------------------------------------------------------------------------------------------
function master_spi_seq_item_converter::new(string name = "master_spi_seq_item_converter");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// function: from_class
// converting seq_item transactions into struct data items
//--------------------------------------------------------------------------------------------
function void master_spi_seq_item_converter::from_class(input master_tx input_conv_h,
                                                        output spi_transfer_char_s output_conv);

  output_conv.no_of_mosi_bits_transfer = input_conv_h.master_out_slave_in.size()*CHAR_LENGTH;
  `uvm_info("master_seq_item_conv_class",
  $sformatf("no_of_mosi_bits_transfer = \n %p",
  output_conv.no_of_mosi_bits_transfer),UVM_HIGH)

  for(int i=0; i<input_conv_h.master_out_slave_in.size(); i++) begin
    `uvm_info("master_seq_item_conv_class",
    $sformatf(" master_tx_input_cov_h master_out_slave_in = \n %p",
    input_conv_h.master_out_slave_in[i]),UVM_HIGH)
    output_conv.master_out_slave_in[i][CHAR_LENGTH-1:0] = input_conv_h.master_out_slave_in[i];    
    
    `uvm_info("master_seq_item_conv_class",
    $sformatf("output_conv_master_out_slave_in = \n %p",output_conv.master_out_slave_in),UVM_HIGH)
  end

  // MSHA: for(int i=0; i<output_conv.no_of_mosi_bits_transfer; i++) begin
  // MSHA:   //output_conv.master_out_slave_in[i][j] = input_conv_h.master_out_slave_in[i];
  // MSHA:   //{<<byte{output_conv.master_out_slave_in[i]}} = input_conv_h.master_out_slave_in[i];
  // MSHA:   {{output_conv.master_out_slave_in[i]}} = input_conv_h.master_out_slave_in[i];
  // MSHA:   //output_conv_h.master_in_slave_out[i] = input_conv_h.master_in_slave_out[i];
  // MSHA: end

  output_conv.cs = input_conv_h.cs;

endfunction: from_class 

//--------------------------------------------------------------------------------------------
// function: from_class
// converting seq_item transactions into struct data items when msb is high
//--------------------------------------------------------------------------------------------
function void master_spi_seq_item_converter::from_class_msb_first(input master_tx input_conv_h,
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
function void master_spi_seq_item_converter::to_class(input spi_transfer_char_s input_conv, 
                                                      output master_tx output_conv_h);
  output_conv_h = new();

  // Defining the size of arrays
  output_conv_h.master_out_slave_in = new[input_conv.no_of_mosi_bits_transfer/CHAR_LENGTH];
  output_conv_h.master_in_slave_out = new[input_conv.no_of_miso_bits_transfer/CHAR_LENGTH];

  // Storing the values in the respective arrays
  for(int i=0; i<input_conv.no_of_mosi_bits_transfer/CHAR_LENGTH; i++) begin
    output_conv_h.master_out_slave_in[i] = input_conv.master_out_slave_in[i][CHAR_LENGTH-1:0];
    `uvm_info("master_seq_item_conv_class",
    $sformatf("To class master_out_slave_in = \n %p",output_conv_h.master_out_slave_in[i]),UVM_HIGH)
    output_conv_h.master_in_slave_out[i] = input_conv.master_in_slave_out[i][CHAR_LENGTH-1:0];
    `uvm_info("master_seq_item_conv_class",
    $sformatf("To class master_in_slave_out = \n %p",output_conv_h.master_out_slave_in[i]),UVM_HIGH)
  end

  output_conv_h.cs = input_conv.cs;
  
endfunction: to_class

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void master_spi_seq_item_converter::do_print(uvm_printer printer);

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
