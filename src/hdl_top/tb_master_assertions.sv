//--------------------------------------------------------------------------------------------
// Module : Master Assertions_TB
// Used to write the assertion checks needed for the master
//--------------------------------------------------------------------------------------------
`ifndef TB_MASTER_ASSERTIONS_INCLUDED_
`define TB_MASTER_ASSERTIONS_INCLUDED_

module tb_master_assertions;
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

  int ct2_delay, t2c_delay, baurdate;

  always #10 pclk = ~pclk;
  // Generate/drive SCLK
  
  always@(posedge pclk) begin
    sclk =!sclk;
  end
  /*initial begin
      repeat(8) begin
      @(posedge pclk) sclk = ~sclk;
      $display("sclk=%0d",sclk);
    end
  end*/
  
  initial begin
    cs = '1;
    test1();
    $display("AN_SVA", "INTIAL BLOCK");
  end
  
  task test1();
    bit[7:0] mosi_data;
    bit[7:0] miso_data;
    $display("ASSERTION_DEBUG","TEST1");

    // random mosi data
    mosi_data = $urandom;
    miso_data = $urandom;
    $display("ASSERTION_DEBUG","mosi_data = 'h%0x", mosi_data);
    $display("ASSERTION_DEBUG","miso_data = 'h%0x", miso_data);

    cs[0]= 0;
    for(int i=0 ; i<8; i++) begin
      @(posedge sclk);
      mosi0 = mosi_data[i];
      miso0 = miso_data[i];
    end

    cs[0]=1'b1;
    $display("ASSERTION_DEBUG","TEST1_DONE");
// MSHA:    repeat(5) begin
// MSHA:  //  @(posedge sclk);
// MSHA:    mosi0 = 1'b1;
// MSHA:    //{mosi0, mosi1, mosi2, mosi3,
// MSHA:        //miso0, miso1, miso2, miso3} = $urandom;
// MSHA:      end  
// MSHA:    $display("ASSERTION_DEBUG"," mosi0=%d",mosi0);
  endtask : test1
  
  task test2();
    areset = 1'b0;
    repeat(5)begin
      //#10; areset = 1'b1;
      {mosi0, mosi1, mosi2, mosi3,
        miso0, miso1, miso2, miso3} = $urandom;
  
      end
  endtask : test2
  
  master_assertions M_A (.pclk(pclk),
                         .cs(cs),
                         .areset(areset),
                         .sclk(sclk),
                         .mosi0(mosi0),
                         .mosi1(mosi1),
                         .mosi2(mosi2),
                         .mosi3(mosi3),
                         .miso0(miso0),
                         .miso1(miso1),
                         .miso2(miso2),
                         .miso3(miso3));
endmodule

`endif

