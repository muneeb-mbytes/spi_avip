`ifndef MASTER_SPI_CFG_CONVERTER_INCLUDED_
`define MASTER_SPI_CFG_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_spi_cfg_converter
// Description:
// class for converting master_cfg configurations into struct configurations
//--------------------------------------------------------------------------------------------
class master_spi_cfg_converter extends uvm_object;
  `uvm_object_utils(master_spi_cfg_converter)

  static int cpol;
  static int cpha;
  static int c2t;
  static int t2c;
  static int baudrate;
  static int wdelay;

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_spi_cfg_converter");

  extern static function void from_class(input master_spi_cfg_converter input_conv_h,output spi_transfer_cfg_s output_conv);
  //extern static function void to_class(input spi_transfer_cfg_s input_conv, output master_tx output_conv_h);
  extern function void do_print(uvm_printer printer);

endclass : master_spi_cfg_converter

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - master_spi_cfg_converter
//--------------------------------------------------------------------------------------------
function master_spi_cfg_converter::new(string name = "master_spi_cfg_converter");
  super.new(name);
endfunction : new


//--------------------------------------------------------------------------------------------
// function: from_class
// converting master_cfg configurations into structure configurations
//--------------------------------------------------------------------------------------------

function void master_spi_cfg_converter::from_class(input master_spi_cfg_converter input_conv_h,
                                                        output spi_transfer_cfg_s output_conv);
    output_conv.c2t = input_conv_h.c2t;
    output_conv.t2c = input_conv_h.t2c;
    output_conv.baudrate = input_conv_h.baudrate;
    output_conv.cpol = input_conv_h.cpol;
    output_conv.cpha = input_conv_h.cpha;
    output_conv.wdelay = input_conv_h.wdelay;

endfunction: from_class 

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void master_spi_cfg_converter::do_print(uvm_printer printer);

  spi_transfer_cfg_s spi_st;
  super.do_print(printer);
  printer.print_field( "c2t", spi_st.c2t , $bits(spi_st.c2t),UVM_DEC);
  printer.print_field( "t2c", spi_st.t2c , $bits(spi_st.t2c),UVM_DEC);
  printer.print_field( "baudrate", spi_st.baudrate , $bits(spi_st.baudrate),UVM_DEC);
  printer.print_field( "cpol", spi_st.cpol , $bits(spi_st.cpol),UVM_DEC);
  printer.print_field( "cphase", spi_st.cpha , $bits(spi_st.cpha),UVM_DEC);

endfunction : do_print

`endif

