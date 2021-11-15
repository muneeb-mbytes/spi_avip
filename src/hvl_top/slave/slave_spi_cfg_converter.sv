`ifndef SLAVE_SPI_CFG_CONVERTER_INCLUDED_
`define SLAVE_SPI_CFG_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_spi_cfg_converter
// Description:
// class for converting slave_cfg configurations into struct configurations
//--------------------------------------------------------------------------------------------
class slave_spi_cfg_converter extends uvm_object;
  `uvm_object_utils(slave_spi_cfg_converter)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "slave_spi_cfg_converter");
  extern static function void from_class(input slave_agent_config input_conv_h ,
                                         output spi_transfer_cfg_s output_conv);
  //extern static function void to_class(input spi_transfer_cfg_s input_conv, output slave_tx output_conv_h);
  extern function void do_print(uvm_printer printer);

endclass : slave_spi_cfg_converter

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - slave_spi_cfg_converter
//--------------------------------------------------------------------------------------------
function slave_spi_cfg_converter::new(string name = "slave_spi_cfg_converter");
  super.new(name);
endfunction : new


//--------------------------------------------------------------------------------------------
// function: from_class
// converting slave_cfg configurations into structure configurations
//--------------------------------------------------------------------------------------------
function void slave_spi_cfg_converter::from_class(input slave_agent_config input_conv_h ,
                                                  output spi_transfer_cfg_s output_conv);

  {output_conv.cpol, output_conv.cpha} = operation_modes_e'(input_conv_h.spi_mode);
  output_conv.msb_first = shift_direction_e'(input_conv_h.shift_dir);

endfunction: from_class 

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void slave_spi_cfg_converter::do_print(uvm_printer printer);

  spi_transfer_cfg_s spi_st;
  super.do_print(printer);
  printer.print_field( "c2t", spi_st.c2t , $bits(spi_st.c2t),UVM_DEC);
  printer.print_field( "t2c", spi_st.t2c , $bits(spi_st.t2c),UVM_DEC);
  printer.print_field( "wdelay", spi_st.wdelay , $bits(spi_st.wdelay),UVM_DEC);
  printer.print_field( "baudrate_divisor", spi_st.baudrate_divisor , $bits(spi_st.baudrate_divisor),UVM_DEC);
  printer.print_field( "cpol", spi_st.cpol , $bits(spi_st.cpol),UVM_DEC);
  printer.print_field( "cphase", spi_st.cpha , $bits(spi_st.cpha),UVM_DEC);

endfunction : do_print

`endif

