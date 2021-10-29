`ifndef SLAVE_SPI_SEQ_ITEM_CONVERTER_INCLUDED_
`define SLAVE_SPI_SEQ_ITEM_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// class : slave_spi_seq_item_converter
// Description:
// class converting seq_item transactions into struct data items and viceversa
//--------------------------------------------------------------------------------------------
  
class slave_spi_seq_item_converter;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern static function void from_class(input slave_tx input_conv_h,output spi_transfer_char_s output_conv);
  extern static function void to_class(input spi_transfer_char_s input_conv, output slave_tx output_conv_h);
  
endclass : slave_spi_seq_item_converter

//--------------------------------------------------------------------------------------------
// function: from_class
// converting seq_item transactions into struct data items
//--------------------------------------------------------------------------------------------

function void slave_spi_seq_item_converter::from_class(input slave_tx input_conv_h,
                                                        output spi_transfer_char_s output_conv);
  output_conv.no_of_miso_bits_transfer = input_conv_h.master_in_slave_out.size()*CHAR_LENGTH;
  for(int i=0; i<input_conv_h.master_out_slave_in.size(); i++) begin
    //output_conv_h.master_out_slave_in[i] = input_conv_h.master_out_slave_in[i];
    output_conv.master_in_slave_out[i] = input_conv_h.master_in_slave_out[i];
    //output_conv_h.no_of_bits_transfer = input_conv_h.no_of_bits_transfer;
  end
endfunction : from_class

//--------------------------------------------------------------------------------------------
// function:to_class
// converting struct data items into seq_item transactions
//--------------------------------------------------------------------------------------------
function void slave_spi_seq_item_converter::to_class(input spi_transfer_char_s input_conv, 
                                                      output slave_tx output_conv_h);
  for(int i=0;i<DATA_WIDTH;i++) begin
    output_conv_h = new();
    output_conv_h.master_out_slave_in[i] = input_conv.master_out_slave_in[i];  
    output_conv_h.master_in_slave_out[i] = input_conv.master_in_slave_out[i];  
    //output_conv_h.no_of_bits_transfer = input_conv_h.no_of_bits_transfer;
  end
endfunction : to_class

`endif
