//-------------------------------------------------------
// Initiating the top module
//-------------------------------------------------------

   import uvm_pkg::*;

   `include "uvm_macros.svh"

    module hdl_top;

    bit reset;

    bit clock;

//-------------------------------------------------------
// Generating CLock
//-------------------------------------------------------

      always 
      begin
       #10 clock=1;
       #10 clock=0;
      end

//-------------------------------------------------------
//  Here the interface name is spi_inf
//-------------------------------------------------------

     spi_in in1(clock);


    endmodule

