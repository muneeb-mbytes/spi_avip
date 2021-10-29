`ifndef MASTER_SPI_SEQ_ITEM_CONVERTER_INCLUDED_
`define MASTER_SPI_SEQ_ITEM_CONVERTER_INCLUDED_
//--------------------------------------------------------------------------------------------
// class : master_spi_seq_item_converter
// Description:
// class converting seq_item transactions into struct data items and viceversa
//--------------------------------------------------------------------------------------------

class master_spi_seq_item_converter;
  
  static int c2t;
  static int t2c;
  static int baudrate;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern static function void from_class(input master_tx input_conv_h,output spi_transfer_char_s output_conv);
  extern static function void to_class(input spi_transfer_char_s input_conv, output master_tx output_conv_h);

endclass : master_spi_seq_item_converter

//--------------------------------------------------------------------------------------------
// function: from_class
// converting seq_item transactions into struct data items
//--------------------------------------------------------------------------------------------

function void master_spi_seq_item_converter::from_class(input master_tx input_conv_h,
                                                        output spi_transfer_char_s output_conv);
  output_conv.no_of_mosi_bits_transfer = input_conv_h.master_out_slave_in.size()*CHAR_LENGTH;
  for(int i=0; i<input_conv_h.master_out_slave_in.size(); i++) begin
    output_conv.master_out_slave_in[i] = input_conv_h.master_out_slave_in[i];
    output_conv.cs = input_conv_h.cs;
    output_conv.c2t = c2t;
    output_conv.t2c = t2c;
    output_conv.baudrate = baudrate;
    //output_conv_h.master_in_slave_out[i] = input_conv_h.master_in_slave_out[i];
  end
  
 endfunction: from_class 

//--------------------------------------------------------------------------------------------
// function:to_class
// converting struct data items into seq_item transactions
//--------------------------------------------------------------------------------------------

function void master_spi_seq_item_converter::to_class(input spi_transfer_char_s input_conv, 
                                                      output master_tx output_conv_h);
  for(int i=0; i<DATA_WIDTH; i++) begin
    output_conv_h = new();
    output_conv_h.master_out_slave_in[i] = input_conv.master_out_slave_in[i];   
    output_conv_h.cs = input_conv.cs;
    output_conv_h.master_in_slave_out[i] = input_conv.master_in_slave_out[i];
    //output_conv_h.no_of_bits_transfer = input_conv_h.no_of_bits_transfer;
  end
  
endfunction: to_class

`endif
