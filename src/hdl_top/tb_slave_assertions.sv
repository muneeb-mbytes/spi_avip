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
 
  int ct2_delay, t2c_delay, baudrate;
  
  // pclk generation
  always begin
    #10 pclk = ~pclk;
  end

  // sclk generation
  always begin
  // repeat(8) begin
     @(posedge pclk) sclk = ~sclk;
  // end
  end
  
  // Stimulus
  initial begin
    test1();
    test2();
  end
 
  task test1();
    bit [7:0] mosi0_data;
    bit [7:0] miso0_data;
    areset = 1'b1;
    $display("SLAVE ASSERTION_DEBUG","TEST1");

    
    //drive the data
    //mosi and miso data
    repeat(4) begin
      mosi0_data = $urandom;
      miso0_data = 8'b10101010;
      $display("SLAVE_ASSERTION_DEBUG_TEST_1", "mosi_data = %0d", mosi0_data);
      $display("SLAVE_ASSERTION_DEBUG_TEST_1", "miso_data = %0d", miso0_data);

    for(int i=0 ; i<8; i++) begin
      @(posedge sclk);
      mosi0 = mosi0_data[i];
      miso0 = miso0_data[i];
    end
    end
  endtask : test1
  
  task test2();
    bit[7:0] mosi0_data;
    bit[7:0] miso0_data;
    areset = 1'b0;
    repeat(4) begin
      mosi0_data = $urandom;
      miso0_data = $urandom;
      $display("SLAVE_ASSERTION_DEBUG_TEST_2", "mosi_data = %0d", mosi0_data);
      $display("SLAVE_ASSERTION_DEBUG_TEST_2", "miso_data = %0d", miso0_data);

    for(int i=0 ; i<8; i++) begin
      @(posedge sclk);
      mosi0 = mosi0_data[i];
      miso0 = miso0_data[i];
    end
    end
  
    $display("SLAVE_ASSERTION_DEBUG","TEST2_DONE");
  endtask : test2

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
endmodule : tb_slave_assertions

`endif
