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
  bit [NO_OF_SLAVES-1:0] cs;
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
  
<<<<<<< HEAD
  // pclk generation
  initial begin 
    pclk =0;
    sclk =0;
  end
  always #10 pclk = ~pclk;
=======
  initial begin
    pclk =0;
  end
  // pclk generation
  always #10 pclk = ~pclk;
  
  task sclk_gen_pos();
    forever #20 sclk = sclk;
  endtask
>>>>>>> 5844669adf61ed76b7a323ac0117e73895cc0154

  task sclk_gen_neg();
    forever #20 sclk = !sclk;
  endtask
  
  // sclk generation
  //always begin
    // @(posedge pclk) sclk = ~sclk;
  //end
  
  // Calling tasks 
  initial begin
<<<<<<< HEAD
    $display("TB_SLAVE_ASSERTIONS");
    //if_signals_are_stable_negative_1();
    //if_signals_are_stable_negative_2();
=======
    //if_signals_are_stable_negative_1();
    //if_signals_are_stable_negative_2();
    //if_signals_are_stable_positive();
    slave_miso0_valid_seq_positive;
>>>>>>> 5844669adf61ed76b7a323ac0117e73895cc0154
  end

  
  task if_signals_are_stable_negative_1();
    bit[7:0] mosi_data;
    bit[7:0] miso_data;
    $display("ASSERTION_DEBUG","IF_SIGNALS_ARE_STABLE");
    
    cs ='1;
    areset = 1'b0;
    
    @(posedge sclk);
    mosi_data = $urandom;
    miso_data = $urandom;
    $display("ASSERTION_DEBUG","mosi_data = 'h%0x", mosi_data);
    $display("ASSERTION_DEBUG","miso_data = 'h%0x", miso_data);

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
    areset = 1'b1;
    
    @(posedge sclk);
    mosi_data = $urandom;
    miso_data = $urandom;
    $display("ASSERTION_DEBUG","mosi_data = 'h%0x", mosi_data);
    $display("ASSERTION_DEBUG","miso_data = 'h%0x", miso_data);

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
    cs = '1;
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

  
  task slave_miso0_valid_seq_positive();
    //bit[7:0] mosi_data;
    bit[7:0] miso_data;
    $display("ASSERTION_DEBUG","SLAVE_MISO0_VALID_SEQ");
    
    cs =0;
    //areset = 1'b0;
    
    @(posedge sclk);
    //mosi_data = $urandom;
    miso_data = $urandom;
    //$display("ASSERTION_DEBUG","mosi_data = 'h%0x", mosi_data);
    $display("ASSERTION_DEBUG","miso_data = 'h%0x", miso_data);

    for(int i=0 ; i<8; i++) begin
      @(posedge sclk);
        //mosi0 = mosi_data[i];
        miso0 = miso_data[i];
    end
  endtask
  
  
  
  initial begin 
    //$monitor("TB_SLAVE_ASSERTIONS,%0t: pclk=%0d, sclk=%0d, areset=%0d, cs=%0d, mosi0=%0d, miso0=%0d",$time, pclk, sclk, areset, cs, mosi0, miso0);
    $display("TB_SLAVE_ASSERTIONS");
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
