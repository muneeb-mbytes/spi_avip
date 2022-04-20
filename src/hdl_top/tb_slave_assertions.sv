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
  
  // pclk generation
  initial begin 
    pclk =0;
    sclk =0;
  end
  always #10 pclk = ~pclk;
  always #10 sclk = ~sclk;
  
  task sclk_gen_pos();
    forever #20 sclk = sclk;
  endtask

  task sclk_gen_neg();
    forever #20 sclk = !sclk;
  endtask
  
  // sclk generation
  //always begin
    // @(posedge pclk) sclk = ~sclk;
  //end
  
  task areset_gen(sclk_local,cs_local,no_of_slaves);
    areset = 0;

    @(posedge pclk);
    if(no_of_slaves == 0) begin
      //cs = 'cs_local;
      cs = '1;
    end
    else begin
      cs[0] = cs_local;
    end
    sclk = sclk_local; //cpol

    repeat(1) begin
      @(posedge pclk); 
    end
    
    areset = 1;
    $display("ARESET_GEN");
  endtask 

  // Calling tasks 

  initial begin
    $display("TB_SLAVE_ASSERTIONS");
    //if_signals_are_stable_negative_1();
    //if_signals_are_stable_negative_2();
    //if_signals_are_stable_positive();
  //  slave_miso0_valid_seq_positive;
  //   cpol_1_cpha_0_positive();
       cpol_1_cpha_0_negative();
  end

 /* task areset_gen(sclk_local,cs_local,no_of_slaves);
    areset = 0;

    @(posedge pclk);
    if(no_of_slaves == 0) begin
      //cs = 'cs_local;
      cs = '1;
    end
    else begin
      cs[0] = cs_local;
    end
    sclk = sclk_local; //cpol

    repeat(1) begin
      @(posedge pclk); 
    end
    
    areset = 1;

  endtask
  */
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
 
task cpol_0_cpha_0_positive;
    bit [7:0]mosi_data;
    bit [7:0]miso_data;
    areset_gen(1,0,1);
    sclk_gen_neg();
        //Driving mosi and miso data
    for(int i=0 ; i<8; i++) begin
      //bit mosi_local,miso_local;

      @(negedge sclk);
      //mosi0 = 'miso_local; 

      mosi0 = mosi_data[i];
      miso0 = miso_data[i];
    end

  endtask

  task cpol_0_cpha_0_negative_1;
    bit [31:0]mosi_data;
    bit [31:0]miso_data;
    
    $display("HEY-----NEG1");
    areset_gen(1,0,1);
    
    $display($time,"POSCLK1");
    $display("HEY-----NEG2");
    //sclk_gen_neg();
    
    $display($time,"POSCLK2");
    $display("HEY-----NEG3");
    //@(posedge sclk);
    mosi_data = $urandom;
    miso_data = $urandom;
    
    //Driving mosi and miso data
    for(int i=0 ; i<31; i++) begin
      //bit mosi_local,miso_local;

      @(posedge sclk);

      mosi0 = mosi_data[i];
      miso0 = miso_data[i];
    end

  endtask
  
  task cpol_0_cpha_1_positive;
    bit [7:0]mosi_data;
    bit [7:0]miso_data;
    areset_gen(1,0,1);
    sclk_gen_neg();

    @(posedge sclk)
    mosi_data = $urandom;
    miso_data = $urandom;

        //Driving mosi and miso data
    for(int i=0 ; i<8; i++) begin
      //bit mosi_local,miso_local;

      @(negedge sclk);
      //mosi0 = 'miso_local; 
      mosi0 = mosi_data[i];
      miso0 = miso_data[i];
    end

  endtask
  
  task cpol_1_cpha_0_positive;
    bit [7:0]mosi_data;
    bit [7:0]miso_data;
    areset_gen(1,0,1);
    //sclk_gen_neg();
        //Driving mosi and miso data
    for(int i=0 ; i<8; i++) begin
      //bit mosi_local,miso_local;

      @(negedge sclk);
      //mosi0 = 'miso_local; 

      mosi0 = mosi_data[i];
      miso0 = miso_data[i];
    end

  endtask
  
  task cpol_1_cpha_0_negative;
    bit [7:0]mosi_data;
    bit [7:0]miso_data;
    areset_gen(1,0,1);
   // sclk_gen_pos();
    mosi_data=$urandom;
    miso_data=$urandom;
        //Driving mosi and miso data
    for(int i=0 ; i<8; i++) begin
      //bit mosi_local,miso_local;

      @(negedge sclk);
      //mosi0 = 'miso_local; 

      mosi0 = mosi_data[i];
      miso0 = miso_data[i];
    end

  endtask




  initial begin 
    //$monitor("TB_SLAVE_ASSERTIONS,%0t: pclk=%0d, sclk=%0d, areset=%0d, cs=%0d, mosi0=%0d, miso0=%0d",$time, pclk, sclk, areset, cs, mosi0, miso0);
    $display("TB_SLAVE_ASSERTIONS");
  end

  // Instantiation of slave assertion module
  /*slave_assertions slave_assertions_h (.pclk(pclk),
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
                                       */
endmodule : tb_slave_assertions





`endif
