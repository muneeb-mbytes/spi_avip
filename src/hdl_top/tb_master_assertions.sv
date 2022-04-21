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
  bit cpol;
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
    sclk =1;
  end
  always #10 pclk = !pclk;
  always #20 sclk = !sclk;
  // Generate/drive SCLK
  
  task sclk_gen_pos();
    forever #20 sclk = sclk;
  endtask
  
  task sclk_gen_neg();
    forever #20 sclk = !sclk;
  endtask
  
  initial begin
    //Include this to verify if signals are stable
    //if_signals_are_stable();

    //Include this to verify master cs low check assertion
    //master_cs_low_check();

   //include this to verify cpol_idle_state_low
   cpol_idle_state_low_positive();
   cpol_idle_state_low_negative();

   //include this to verify cpol_idle_state_high
   cpol_idle_state_high_positive();
   cpol_idle_state_high_negative();

   //Uncomment this when you want to verify cpol 0 and cpha 0
   cpol_0_cpha_0();
  // cpol_1_cpha_0();
  end

  task if_signals_are_stable;
    //if_signals_are_stable_negative_1();
    //if_signals_are_stable_negative_2();
    if_signals_are_stable_positive();
  endtask

  task master_cs_low_check;
    //master_cs_low_check_positive();
    //master_cs_low_check_negative_1();
  endtask

  task cpol_0_cpha_0;
    //cpol_0_cpha_0_positive();
    cpol_0_cpha_0_negative_1();
  endtask

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

  task if_signals_are_stable_negative_1();
    bit[7:0] mosi_data;
    bit[7:0] miso_data;
    
    //areset generation
    areset_gen(1,1,1);

    //sclk generation
    sclk_gen_neg();

    //Randomising mosi and miso data
    $display($time,"POSCLK1");
    @(posedge sclk);
    mosi_data = $urandom;
    miso_data = $urandom;
    $display($time,"POSCLK2");

    //Driving mosi and miso data
    for(int i=0 ; i<8; i++) begin
      @(posedge sclk);
      mosi0 = mosi_data[i];
      miso0 = miso_data[i];
    end
  endtask

  task if_signals_are_stable_negative_2();
    
    //Declaring mosi and miso data
    bit[7:0] mosi_data;
    bit[7:0] miso_data;
    
    //areset_generation
    areset_gen(1,1,1);

    //sclk generation
    sclk_gen_neg();

    //randomising miso and mosi data
    @(posedge sclk);
    mosi_data = $urandom;
    miso_data = $urandom;

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

    //areset generation
    areset_gen(1,1,1);

    // random mosi data
    mosi_data = $urandom;
    miso_data = $urandom;
    
    //sclk generation
    sclk_gen_pos();

    //Driving mosi and miso data
    for(int i=0 ; i<8; i++) begin
      @(posedge sclk);
      mosi0 = mosi_data[i];
      miso0 = miso_data[i];
    end

  endtask 
 /* 
  task master_cs_low_check_positive();
    
    //Initialising mosi data
    bit [7:0]mosi_data;
    bit [7:0]miso_data;
    
    //areset generation
    areset_gen(1,0,1);
    
    //sclk generation
    sclk_gen_neg();

    //Random mosi data
    mosi_data = $urandom;
    miso_data = $urandom;

    //Driving mosi and miso data
    for(int i=0 ; i<8; i++) begin
      @(posedge sclk);
      mosi0 = mosi_data[i];
      miso0 = miso_data[i];
    end
  endtask : master_cs_low_check_positive
*/
  task master_cs_low_check_negative_1();
    
    //Initialising mosi data
    bit [7:0]mosi_data;
    bit [7:0]miso_data;
    
    //areset generation
    areset_gen(1,0,1);
    
    //sclk generation
    sclk_gen_neg();

    //Random mosi data
    mosi_data = $urandom;
    miso_data = $urandom;
  
    //Driving mosi and miso data
    for(int i=0 ; i<8; i++) begin
      //bit mosi_local,miso_local;

      @(posedge sclk);
      //mosi0 = 'miso_local; 

      mosi0 = mosi_data[i];
      miso0 = miso_data[i];
    end
  endtask : master_cs_low_check_negative_1
  
  task cpol_idle_state_low_positive();
    cs='b1;
    cpol=1'b0;
    sclk=1'b0;
   // for(int i=0 ; i<8; i++) begin
    //  @(posedge pclk);
     //  sclk = !sclk;
    //end
  endtask : cpol_idle_state_low_positive

  task cpol_idle_state_low_negative();
    cs = 'b0;
    //cpol=1'b0;
    sclk=1'b0;
    //for(int i=0 ; i<8; i++) begin
     // @(posedge pclk);
     // sclk = !sclk;
    //end
  endtask

  task cpol_idle_state_high_positive();
    cs='b1;
    cpol=1'b0;
    sclk=1'b0;
   // for(int i=0 ; i<8; i++) begin
    //  @(posedge pclk);
     //  sclk = !sclk;
    //end
  endtask : cpol_idle_state_high_positive

  task cpol_idle_state_high_negative();
    cs = 'b0;
    cpol=1'b0;
    sclk=1'b0;
    //for(int i=0 ; i<8; i++) begin
     // @(posedge pclk);
     // sclk = !sclk;
    //end
  endtask : cpol_idle_state_high_negative


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

  task cpol_0_cpha_0_negative;
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


  task cpol_0_cpha_1_positive;
    bit [7:0]mosi_data;
    bit [7:0]miso_data;
    
    areset_gen(1,1,1);
    
    sclk_gen_neg();

    @(posedge sclk);
    mosi_data = $urandom;
    miso_data = $urandom;
    
    //Driving mosi and miso data
    for(int i=0 ; i<8; i++) begin

      @(negedge sclk);
      //mosi0 = 'miso_local; 
      mosi0 = mosi_data[i];
      miso0 = miso_data[i];
    end

  endtask

   task cpol_0_cpha_1_negative;
    bit [7:0]mosi_data;
    bit [7:0]miso_data;
    areset_gen(1,1,1);
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


   task cpol_1_cpha_0_negative;
    bit [7:0]mosi_data;
    bit [7:0]miso_data;
    areset_gen(1,0,1);
    sclk_gen_pos();
    mosi_data=$urandom;
    miso_data=$urandom;
        //Driving mosi and miso data
    for(int i=0 ; i<8; i++) begin
      //bit mosi_local,miso_local;

      @(posedge sclk);
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

  /*master_assertions M_A (.pclk(pclk),
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
                         */
endmodule

`endif

