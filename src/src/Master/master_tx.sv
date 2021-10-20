`ifndef MASTER_TX_INCLUDED_
`define MASTER_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_tx
// <Description_here>
//--------------------------------------------------------------------------------------------
class master_tx extends uvm_sequence_item;
  `uvm_object_utils(master_tx)

  rand bit mosi;
//  rand bit [1:0] cs;
       bit cs;
       bit sclk;
       bit rst;
       bit [1:0]cphase;
       bit [1:0]cpol;

  rand bit [`DW-1:0] master_data_in;

       bit miso;
//-------------------------------------------------------
// Externally defined Tasks and Functions
//-------------------------------------------------------
  extern function new(string name = "master_tx");
  extern function void do_print(uvm_printer printer);
//--------------------------------------------------------------------------------------------
// Constraints for SPI
//--------------------------------------------------------------------------------------------

//constraint cs1 {cs == 0;}

constraint rst1 { 
                   if(rst == 1)
                     cs == 1;  
                   }
constraint m_data_in{master_data_in inside {[10:250]};}

endclass : master_tx

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - master_tx
//--------------------------------------------------------------------------------------------
function master_tx::new(string name = "master_tx");
  super.new(name);
endfunction : new


function void master_tx::do_print(uvm_printer printer);
  super.do_print(printer);
     
       printer.print_field( "sclk", sclk, 1,UVM_DEC);
       printer.print_field( "cs", cs , 1,UVM_DEC);
     //  printer.print_field( "rst", rst , 1,UVM_DEC);

       printer.print_field( "cphase", cphase , 2,UVM_DEC);
       printer.print_field( "cpol", cpol , 2,UVM_DEC);
       printer.print_field("master_data_in",master_data_in,8,UVM_HEX);

       printer.print_field( "miso",  miso, 1,UVM_DEC);
       printer.print_field( "mosi",  mosi, 1,UVM_DEC);



endfunction:do_print

`endif

