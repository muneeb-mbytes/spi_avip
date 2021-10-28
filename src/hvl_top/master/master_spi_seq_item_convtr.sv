`ifndef MASTER_SPI_SEQ_ITEM_CONVERTER_INCLUDED_
`define MASTER_SPI_SEQ_ITEM_CONVERTER_INCLUDED_
//--------------------------------------------------------------------------------------------
// class : master_spi_seq_item_converter
// Description:
// class converting seq_item transactions into struct data items and viceversa
//--------------------------------------------------------------------------------------------

class master_spi_seq_item_converter;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern static function void from_class(input master_tx input_conv_h,output spi_transfer_char_s output_conv_h);
  extern static function void to_class(output master_tx output_conv_h,input spi_transfer_char_s input_conv_h);

endclass : master_spi_seq_item_converter

//--------------------------------------------------------------------------------------------
// function: from_class
// converting seq_item transactions into struct data items
//--------------------------------------------------------------------------------------------

function void master_spi_seq_item_converter::from_class(input master_tx input_conv_h,output spi_transfer_char_s output_conv_h);
  output_conv_h.no_of_mosi_bits_transfer = input_conv_h.master_out_slave_in.size();
  foreach(output_conv_h.no_of_mosi_bits_transfer[i]) begin
  output_conv_h.master_out_slave_in[i] = input_conv_h.master_out_slave_in[i];
  output_conv_h.cs[i] = input_conv_h.cs[i];
 //output_conv_h.master_in_slave_out[i] = input_conv_h.master_in_slave_out[i];
 // output_conv_h.no_of_bits_transfer = input_conv_h.no_of_bits_transfer;
   end
 endfunction: from_class 

//--------------------------------------------------------------------------------------------
// function:to_class
// converting struct data items into seq_item transactions
//--------------------------------------------------------------------------------------------

function void master_spi_seq_item_converter::to_class(output master_tx output_conv_h,input spi_transfer_char_s input_conv_h);
  output_conv_h = new();
  output_conv_h.master_out_slave_in = input_conv_h.master_out_slave_in;
  output_conv_h.cs = input_conv_h.cs;
  output_conv_h.master_in_slave_out = input_conv_h.master_in_slave_out;
  //output_conv_h.no_of_bits_transfer = input_conv_h.no_of_bits_transfer;
endfunction: to_class

`endif
