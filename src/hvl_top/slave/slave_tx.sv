`ifndef SLAVE_TX_INCLUDED_
`define SLAVE_TX_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: slave_tx
<<<<<<< HEAD
// <Description_here>
=======
// It's a transaction class that holds the SPI data items for generating the stimulus
>>>>>>> e83a01ba7691ecc0a834df934e024d49f54a59af
//--------------------------------------------------------------------------------------------
class slave_tx extends uvm_sequence_item;
  `uvm_object_utils(slave_tx)

  rand bit miso;
 // rand bit [1:0] cs;
       bit cs;
       bit sclk;
       bit rst;
       bit [1:0]cphase;
       bit [1:0]cpol;

  rand bit [`DW-1:0] slave_data_in;

       bit mosi;
//-------------------------------------------------------
// Externally defined Tasks and Functions
//-------------------------------------------------------
  extern function new(string name = "slave_tx");
  extern function void do_print(uvm_printer printer);

//--------------------------------------------------------------------------------------------
// Constraints for SPI
//--------------------------------------------------------------------------------------------
//constraint cs2 {cs == 0;};
constraint rst2 { 
                   (rst == 1)->(cs==1);
                   }
constraint s_data_in {slave_data_in inside {[10:250]};}

endclass : slave_tx

//--------------------------------------------------------------------------------------------
// Construct: new
<<<<<<< HEAD
=======
// Constructs the slave_tx object
//  
>>>>>>> e83a01ba7691ecc0a834df934e024d49f54a59af
//
// Parameters:
//  name - slave_tx
//--------------------------------------------------------------------------------------------
function slave_tx::new(string name = "slave_tx");
  super.new(name);
endfunction : new

<<<<<<< HEAD

=======
// TODO(mshariff): Have print, cpoy compare methods
>>>>>>> e83a01ba7691ecc0a834df934e024d49f54a59af
function void slave_tx::do_print(uvm_printer printer);
  super.do_print(printer);
     
       printer.print_field( "sclk", sclk, 1,UVM_DEC);
       printer.print_field( "cs", cs , 1,UVM_DEC);
      // printer.print_field( "rst", rst , 1,UVM_DEC);
 
       printer.print_field( "cphase", cphase , 2,UVM_DEC);
       printer.print_field( "cpol", cpol , 2,UVM_DEC);
       printer.print_field("slave_data_in",slave_data_in,8,UVM_HEX);

       printer.print_field( "miso",  miso, 1,UVM_DEC);
       printer.print_field( "mosi",  mosi, 1,UVM_DEC);



endfunction:do_print

`endif
