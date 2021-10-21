

`include "uvm_macros.svh"
import uvm_pkg::*;

`include "sspi_config.sv"
`include "slave_tx.sv"
`include "slave_seq.sv"

`include "../Master/mspi_config.sv"
`include "../Master/master_tx.sv"
`include "../Master/master_seq.sv"

`include "test.sv"
module tb2;
    test t;
     
     
    initial begin
        t = new("TEST",null);
        run_test();
      end
       
       
      endmodule
