`ifndef MASTER_SPI_CFG_CONVERTER_INCLUDED_
`define MASTER_SPI_CFG_CONVERTER_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_spi_cfg_converterzo
// Description:
// class for converting master_cfg configurations into struct configurations
//--------------------------------------------------------------------------------------------
class master_spi_cfg_converter extends uvm_object;
  `uvm_object_utils(master_spi_cfg_converter)

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_spi_cfg_converter");

  extern static function void from_class(input master_agent_config input_conv_h, 
                                         output spi_transfer_cfg_s output_conv);

  //extern static function void to_class(input spi_transfer_cfg_s input_conv, output master_tx output_conv_h);
  extern function void do_print(uvm_printer printer);

endclass : master_spi_cfg_converter

//--------------------------------------------------------------------------------------------
// Construct: new
//
//
//
// Parameters:
//
//  name - master_spi_cfg_converter
//--------------------------------------------------------------------------------------------
function master_spi_cfg_converter::new(string name = "master_spi_cfg_converter");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// function: from_class
// converting master_cfg configurations into structure configurations
//--------------------------------------------------------------------------------------------
function void master_spi_cfg_converter::from_class(input master_agent_config input_conv_h,
                                                 output spi_transfer_cfg_s output_conv);
    bit cpol;
    bit cpha;
    {cpol,cpha} = operation_modes_e'(input_conv_h.spi_mode);
    output_conv.c2t = input_conv_h.c2tdelay;
    output_conv.t2c = input_conv_h.t2cdelay;
    output_conv.baudrate_divisor = input_conv_h.get_baudrate_divisor();
    `uvm_info("conv_bd",$sformatf("bd = \n %p",output_conv.baudrate_divisor),UVM_LOW)
    output_conv.cpol = cpol;
    output_conv.cpha = cpha;
    output_conv.msb_first = shift_direction_e'(input_conv_h.shift_dir);
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
  printer.print_field( "baudrate_divisor", spi_st.baudrate_divisor , $bits(spi_st.baudrate_divisor),UVM_DEC);
  printer.print_field( "cpol", spi_st.cpol , $bits(spi_st.cpol),UVM_DEC);
  printer.print_field( "cphase", spi_st.cpha , $bits(spi_st.cpha),UVM_DEC);
  printer.print_field( "msb_first", spi_st.msb_first , $bits(spi_st.msb_first),UVM_BIN);

endfunction : do_print

`endif

