
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "mspi_config.sv"
`include "master_tx.sv"
`include "master_seq.sv"
`include "test.sv"

module tb2;
    test t;
     
     
    initial begin
        t = new("TEST",null);
        run_test();
      end
       
       
      endmodule
