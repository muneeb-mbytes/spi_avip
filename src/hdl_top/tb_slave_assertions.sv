`ifndef TB_SLAVE_ASSERTIONS_INCLUDED_
`define TB_SLAVE_ASSERTIONS_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module:      tb_slave_assertions
// Description: Includes interface   
//--------------------------------------------------------------------------------------------

module tb_slave_assertions;

  import spi_globals_pkg::*; 

  bit pclk;
  bit sclk;
  bit [NO_OF_SLAVES-1:0]cs;
  bit areset;
  bit mosi0;
  bit mosi1;
  bit mosi2;
  bit mosi3;
  bit miso0;
  bit miso1;
  bit miso2;
  bit miso3;
 
  // pclk generation
  always begin
    #10 pclk = ~pclk;
  end

  // sclk generation
  always begin
//    repeat(8) begin
     @(posedge pclk) sclk = ~sclk;
  //  end
  end

  // areset task
  task areset_t();
    @(posedge pclk);
    areset = 1'b0;
    @(posedge pclk);
    areset = 1'b1;
  endtask
    
  // Stimulus
  initial begin
    areset_t();
    test1();
  end
 
  task test1();
   //drive the data
   //mosi and miso data
   repeat(4) begin
     mosi0 = $urandom;
     miso0 = $urandom;
   end
  endtask

  initial begin
    $display("TB_SLAVE_ASSERTIONS,%0t: pclk=%0d, sclk=%0d, areset=%0d, cs=%0d, mosi0=%0d, miso0=%0d",
              $time, pclk, sclk, areset, cs, mosi0, miso0);
  end
   
  // Instantiation of slave assertion module
  slave_assertions slave_assertions_h (.pclk(pclk),
                                       .sclk(sclk),
                                       .cs(cs),
                                       .areset(areset),
                                       .mosi0(mosi0),
                                       .mosi1(mosi1),
                                       .mosi2(mosi2),
                                       .mosi3(mosi3),
                                       .miso0(miso0),
                                       .miso1(miso1),
                                       .miso2(miso2),
                                       .miso3(miso3) );
endmodule

`endif
