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
  //logic mosi0;
  bit mosi1;
  bit mosi2;
  bit mosi3;
  bit miso0;
  bit miso1;
  bit miso2;
  bit miso3;

  int ct2_delay, t2c_delay, baurdate;
  initial begin
    pclk =1;
  end
  always #10 pclk = ~pclk;
  // Generate/drive SCLK
  
  task sclk_gen_pos();
    forever #20 sclk = sclk;
  endtask

  task sclk_gen_neg();
    forever #20 sclk = !sclk;
  endtask
  /*always@(posedge pclk) begin
    //if(cs == '1) begin
      //sclk = sclk;
    //end
    //else begin
      sclk =!sclk;
    //end
  end*/
  
  initial begin
    //test1();
    if_signals_are_stable_negative_1();
    //if_signals_are_stable_negative_2();
    //if_signals_are_stable_positive();
    //master_cs_low_check_positive();
    $display("AN_SVA", "INTIAL BLOCK");
  end

  task if_signals_are_stable_negative_1();
    bit[7:0] mosi_data;
    bit[7:0] miso_data;
    //$display("ASSERTION_DEBUG","IF_SIGNALS_ARE_STABLE");
    //@(posedge pclk) begin

    areset = 0;

    @(posedge pclk); 
    cs = '1;
    sclk = 0; //cpol

    repeat(1) begin
      @(posedge pclk); 
    end
    
    areset = 1;

    //areset = 0;
    //end
    sclk_gen_neg();
    @(posedge sclk);
    mosi_data = $urandom;
    miso_data = $urandom;
    //$display("ASSERTION_DEBUG","mosi_data = 'h%0x", mosi_data);
    //$display("ASSERTION_DEBUG","miso_data = 'h%0x", miso_data);

    //$display("ASSERTION_DEBUG_CS","cs = %0b", cs);
    for(int i=0 ; i<8; i++) begin
      @(posedge sclk);
      mosi0 = mosi_data[i];
      miso0 = miso_data[i];
    end
  endtask

  task if_signals_are_stable_negative_2();
    bit[7:0] mosi_data;
    bit[7:0] miso_data;
    $display("ASSERTION_DEBUG","IF_SIGNALS_ARE_STABLE");
    sclk_gen_neg();
    areset = 1'b1;
    //sclk = sclk;
    @(posedge sclk);
    mosi_data = $urandom;
    miso_data = $urandom;
    $display("ASSERTION_DEBUG","mosi_data = 'h%0x", mosi_data);
    $display("ASSERTION_DEBUG","miso_data = 'h%0x", miso_data);

    $display("ASSERTION_DEBUG_CS","cs = %0b", cs);

   //bit j =mosi_data[i];
   //bit k =miso_data[i];
 
    for(int i=0 ; i<8; i++) begin
      cs = $urandom;
      @(posedge sclk);
        mosi0 = mosi_data[i];
        miso0 = miso_data[i];
    end
  endtask
  
  task if_signals_are_stable_positive();
    bit[7:0] mosi_data;
    bit[7:0] miso_data;

    $display("ASSERTION_DEBUG","TEST1");

    areset = 0;

    @(posedge pclk); 
    cs = '1;
    sclk = 0; //cpol

    repeat(1) begin
      @(posedge pclk); 
    end
    
    areset = 1;

    // MSHA:// initial data
    // MSHA:pclk = 0;
    // MSHA:cs = 1;

    // random mosi data
    mosi_data = $urandom;
    miso_data = $urandom;
    $display("ASSERTION_DEBUG","mosi_data = 'h%0x", mosi_data);
    $display("ASSERTION_DEBUG","miso_data = 'h%0x", miso_data);
    //@(posedge pclk) sclk = sclk;
    //sclk = sclk;
    sclk_gen_pos();
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
  endtask 
  
  task master_cs_low_check_positive();
    bit [7:0]mosi_data;
    cs[0] = 1'b0;
    sclk_gen_neg();
    mosi_data = 8'h23;
    $display("mosi_data = %0d",mosi_data);
    for(int i=0 ; i<8; i++) begin
      @(posedge sclk);
      mosi0 = mosi_data[i];
      $display("mosi=%d",mosi0);
    end
  endtask : master_cs_low_check_positive
  
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

