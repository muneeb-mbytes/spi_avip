`ifndef MASTER_ASSERTIONS_INCLUDED_
`define MASTER_ASSERTIONS_INCLUDED_

//-------------------------------------------------------
// Importing SPI Global Package
//-------------------------------------------------------
import spi_globals_pkg::*;

//--------------------------------------------------------------------------------------------
// Interface : Master Assertions
// Used to write the assertion checks needed for the master
//--------------------------------------------------------------------------------------------

interface master_assertions ( input pclk,
                              input areset,
                              input sclk,
                              input [NO_OF_SLAVES-1:0] cs,
                              input mosi0,
                              input mosi1,
                              input mosi2,
                              input mosi3,
                              input miso0,
                              input miso1,
                              input miso2,
                              input miso3 );

  bit cpol;
  bit cpha;
  
  //-------------------------------------------------------
  // Importing Uvm Package
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh";

  initial begin
    `uvm_info("MASTER_ASSERTIONS","MASTER ASSERTIONS",UVM_LOW);
  end
 
  //-------------------------------------------------------
  // Defining Macro
  //-------------------------------------------------------
  `define SIMPLE_SPI
  //`define DUAL_SPI
  //`define QUAD_SPI
  
  //-------------------------------------------------------
  // Assertion for if_signals_are_stable
  // When cs is high, the signals sclk, mosi, miso should be stable.
  //-------------------------------------------------------
  property if_signals_are_stable(logic mosi_local, logic miso_local);
    @(posedge pclk) disable iff(!areset)
    cs=='1  |=> $stable(sclk) && $stable(mosi_local) && $stable(miso_local);
  endproperty : if_signals_are_stable

  `ifdef SIMPLE_SPI
    IF_SIGNALS_ARE_STABLE_SIMPLE_SPI: assert property (if_signals_are_stable(mosi0,miso0));
    IF_SIGNALS_ARE_STABLE_SIMPLE_SPI_C: cover property (if_signals_are_stable(mosi0,miso0));    
  `endif
  `ifdef DUAL_SPI
    IF_SIGNALS_ARE_STABLE_DUAL_SPI_1_C: assert property (if_signals_are_stable(mosi0,miso0));
    IF_SIGNALS_ARE_STABLE_DUAL_SPI_2_C: assert property (if_signals_are_stable(mosi1,miso1));
    
    IF_SIGNALS_ARE_STABLE_DUAL_SPI_1_C: cover property (if_signals_are_stable(mosi0,miso0));
    IF_SIGNALS_ARE_STABLE_DUAL_SPI_2_C: cover property (if_signals_are_stable(mosi1,miso1));
  `endif
  `ifdef QUAD_SPI
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_1: assert property (if_signals_are_stable(mosi0,miso0));
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_2: assert property (if_signals_are_stable(mosi1,miso1));
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_3: assert property (if_signals_are_stable(mosi2,miso2));
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_4: assert property (if_signals_are_stable(mosi3,miso3));
       
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_1_C: cover property (if_signals_are_stable(mosi0,miso0));
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_2_C: cover property (if_signals_are_stable(mosi1,miso1));
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_3_C: cover property (if_signals_are_stable(mosi2,miso2));
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_4_C: cover property (if_signals_are_stable(mosi3,miso3));
  `endif

  //-------------------------------------------------------
  // Assertion for mosi_miso_valid
  // when cs is low mosi should be valid from next clock cycle.
  //-------------------------------------------------------
  property mosi_miso_valid_p(logic mosi_local, logic miso_local);
    @(posedge pclk) disable iff(!areset)
    cs=='0 |=> !$isunknown(sclk) && !$isunknown(mosi_local) |-> !$isunknown(miso_local);
  endproperty : mosi_miso_valid_p
  
  `ifdef SIMPLE_SPI
      CS_LOW_CHECK_SIMPLE_SPI: assert property (mosi_miso_valid_p(mosi0,miso0));
      CS_LOW_CHECK_SIMPLE_SPI_C: cover property (mosi_miso_valid_p(mosi0,miso0));
  `endif
  `ifdef DUAL_SPI
      CS_LOW_CHECK_DUAL_SPI_1: assert property (mosi_miso_valid_p(mosi0,miso0));
      CS_LOW_CHECK_DUAL_SPI_2: assert property (mosi_miso_valid_p(mosi1,miso1));
          
      CS_LOW_CHECK_DUAL_SPI_1_C: cover property (mosi_miso_valid_p(mosi0,miso0));
      CS_LOW_CHECK_DUAL_SPI_2_C: cover property (mosi_miso_valid_p(mosi1,miso1));
  `endif
  `ifdef QUAD_SPI
      CS_LOW_CHECK_QUAD_SPI_1: assert property (mosi_miso_valid_p(mosi0,miso0));
      CS_LOW_CHECK_QUAD_SPI_2: assert property (mosi_miso_valid_p(mosi1,miso1));
      CS_LOW_CHECK_QUAD_SPI_3: assert property (mosi_miso_valid_p(mosi3,miso2));
      CS_LOW_CHECK_QUAD_SPI_4: assert property (mosi_miso_valid_p(mosi3,miso3));
              
      CS_LOW_CHECK_QUAD_SPI_1_C: cover property (mosi_miso_valid_p(mosi0,miso0));
      CS_LOW_CHECK_QUAD_SPI_2_C: cover property (mosi_miso_valid_p(mosi1,miso1));
      CS_LOW_CHECK_QUAD_SPI_3_C: cover property (mosi_miso_valid_p(mosi3,miso2));
      CS_LOW_CHECK_QUAD_SPI_4_C: cover property (mosi_miso_valid_p(mosi3,miso3));
  `endif

  //-------------------------------------------------------
  // Assertion for cpol in idle state
  // when cpol is low, idle state should be logic low
  // when cpol is high,idle state should be logic high
  //-------------------------------------------------------
  property cpol_idle_state_check_p;
    @(posedge pclk) disable iff(!areset)
    cs=='1 |-> sclk == cpol;
  endproperty : cpol_idle_state_check_p
  CPOL_IDLE_STATE_CHECK: assert property(cpol_idle_state_check_p);
    
  CPOL_IDLE_STATE_CHECK_C: cover property(cpol_idle_state_check_p);
 
/* 
  //-------------------------------------------------------
  // Assertion for mode_of_cfg_cpol_0_cpha_0
  // when cpol is 0 and cpha is 0,
  // mosi data and miso data should be valid at the same negedge of sclk 
  //-------------------------------------------------------
  property mode_of_cfg_cpol_0_cpha_0(logic mosi_local,logic miso_local);
    @(negedge sclk) disable iff(!areset)
    cpol==0 && cpha==0 |-> !$isunknown(mosi_local) && !$isunknown(miso_local);
  endproperty: mode_of_cfg_cpol_0_cpha_0

  `ifdef SIMPLE_SPI
    CPOL_0_CPHA_0_SIMPLE_SPI: assert property (mode_of_cfg_cpol_0_cpha_0(mosi0,miso0));
      
    CPOL_0_CPHA_0_SIMPLE_SPI_C: cover property (mode_of_cfg_cpol_0_cpha_0(mosi0,miso0));
  `endif
  `ifdef DUAL_SPI
    CPOL_0_CPHA_0_DUAL_SPI_1: assert property (mode_of_cfg_cpol_0_cpha_0(mosi0,miso0));
    CPOL_0_CPHA_0_DUAL_SPI_2: assert property (mode_of_cfg_cpol_0_cpha_0(mosi1,miso1));
      
    CPOL_0_CPHA_0_DUAL_SPI_1_C: cover property (mode_of_cfg_cpol_0_cpha_0(mosi0,miso0));
    CPOL_0_CPHA_0_DUAL_SPI_2_C: cover property (mode_of_cfg_cpol_0_cpha_0(mosi1,miso1));
  `endif
  `ifdef QUAD_SPI
    CPOL_0_CPHA_0_QUAD_SPI_1: assert property (mode_of_cfg_cpol_0_cpha_0(mosi0,miso0));
    CPOL_0_CPHA_0_QUAD_SPI_2: assert property (mode_of_cfg_cpol_0_cpha_0(mosi1,miso1));
    CPOL_0_CPHA_0_QUAD_SPI_3: assert property (mode_of_cfg_cpol_0_cpha_0(mosi3,miso2));
    CPOL_0_CPHA_0_QUAD_SPI_4: assert property (mode_of_cfg_cpol_0_cpha_0(mosi3,miso3));
      
    CPOL_0_CPHA_0_QUAD_SPI_1_C: cover property (mode_of_cfg_cpol_0_cpha_0(mosi0,miso0));
    CPOL_0_CPHA_0_QUAD_SPI_2_C: cover property (mode_of_cfg_cpol_0_cpha_0(mosi1,miso1));
    CPOL_0_CPHA_0_QUAD_SPI_3_C: cover property (mode_of_cfg_cpol_0_cpha_0(mosi3,miso2));
    CPOL_0_CPHA_0_QUAD_SPI_4_C: cover property (mode_of_cfg_cpol_0_cpha_0(mosi3,miso3));
  `endif

  //-------------------------------------------------------
  // Assertion for mode_of_cfg_cpol_0_cpha_1
  // when cpol is 0 and cpha is 1,
  // mosi data and miso data should be valid at the same negedge of sclk
  //-------------------------------------------------------
  property mode_of_cfg_cpol_0_cpha_1(logic mosi_local, logic miso_local);
    @(negedge sclk) disable iff(!areset)
   cpol==0 && cpha==1 |-> !$isunknown(mosi_local) && !$isunknown(miso_local);
  endproperty: mode_of_cfg_cpol_0_cpha_1
  
  `ifdef SIMPLE_SPI
    CPOL_0_CPHA_1_SIMPLE_SPI: assert property (mode_of_cfg_cpol_0_cpha_1(mosi0,miso0));
    CPOL_0_CPHA_1_SIMPLE_SPI_C: cover property (mode_of_cfg_cpol_0_cpha_1(mosi0,miso0));
  `endif
  `ifdef DUAL_SPI
    CPOL_0_CPHA_1_DUAL_SPI_1: assert property (mode_of_cfg_cpol_0_cpha_1(mosi0,miso0));
    CPOL_0_CPHA_1_DUAL_SPI_2: assert property (mode_of_cfg_cpol_0_cpha_1(mosi1,miso1));
      
    CPOL_0_CPHA_1_DUAL_SPI_1_C: cover property (mode_of_cfg_cpol_0_cpha_1(mosi0,miso0));
    CPOL_0_CPHA_1_DUAL_SPI_2_C: cover property (mode_of_cfg_cpol_0_cpha_1(mosi1,miso1));
  `endif
  `ifdef QUAD_SPI
    CPOL_0_CPHA_1_QUAD_SPI_1: assert property (mode_of_cfg_cpol_0_cpha_1(mosi0,miso0));
    CPOL_0_CPHA_1_QUAD_SPI_2: assert property (mode_of_cfg_cpol_0_cpha_1(mosi1,miso1));
    CPOL_0_CPHA_1_QUAD_SPI_3: assert property (mode_of_cfg_cpol_0_cpha_1(mosi3,miso2));
    CPOL_0_CPHA_1_QUAD_SPI_4: assert property (mode_of_cfg_cpol_0_cpha_1(mosi3,miso3));
      
    CPOL_0_CPHA_1_QUAD_SPI_1_C: cover property (mode_of_cfg_cpol_0_cpha_1(mosi0,miso0));
    CPOL_0_CPHA_1_QUAD_SPI_2_C: cover property (mode_of_cfg_cpol_0_cpha_1(mosi1,miso1));
    CPOL_0_CPHA_1_QUAD_SPI_3_C: cover property (mode_of_cfg_cpol_0_cpha_1(mosi3,miso2));
    CPOL_0_CPHA_1_QUAD_SPI_4_C: cover property (mode_of_cfg_cpol_0_cpha_1(mosi3,miso3));
  `endif

  //-------------------------------------------------------
  // Assertion for mode_of_cfg_cpol_1_cpha_0
  // when cpol is 1 and cpha is 0,
  // mosi data and miso data should be valid at the same posedge of sclk 
  //-------------------------------------------------------
  property mode_of_cfg_cpol_1_cpha_0(logic mosi_local,logic miso_local);
    @(posedge sclk) disable iff(!areset)
    cpol==1 && cpha==0 |-> !$isunknown(mosi_local) && !$isunkown(miso_local);
  endproperty: mode_of_cfg_cpol_1_cpha_0
  
  `ifdef SIMPLE_SPI
    CPOL_1_CPHA_0_SIMPLE_SPI: assert property (mode_of_cfg_cpol_1_cpha_0(mosi0,miso0));
    CPOL_1_CPHA_0_SIMPLE_SPI_C: cover property (mode_of_cfg_cpol_1_cpha_0(mosi0,miso0));
  `endif
  `ifdef DUAL_SPI
    CPOL_1_CPHA_0_DUAL_SPI_1: assert property (mode_of_cfg_cpol_1_cpha_0(mosi0,miso0));
    CPOL_1_CPHA_0_DUAL_SPI_2: assert property (mode_of_cfg_cpol_1_cpha_0(mosi1,miso1));
      
    CPOL_1_CPHA_0_DUAL_SPI_1_C: cover property (mode_of_cfg_cpol_1_cpha_0(mosi0,miso0));
    CPOL_1_CPHA_0_DUAL_SPI_2_C: cover property (mode_of_cfg_cpol_1_cpha_0(mosi1,miso1));
  `endif
  `ifdef QUAD_SPI
    CPOL_1_CPHA_0_QUAD_SPI_1: assert property (mode_of_cfg_cpol_1_cpha_0(mosi0,miso0));
    CPOL_1_CPHA_0_QUAD_SPI_2: assert property (mode_of_cfg_cpol_1_cpha_0(mosi1,miso1));
    CPOL_1_CPHA_0_QUAD_SPI_3: assert property (mode_of_cfg_cpol_1_cpha_0(mosi3,miso2));
    CPOL_1_CPHA_0_QUAD_SPI_4: assert property (mode_of_cfg_cpol_1_cpha_0(mosi3,miso3));
      
    CPOL_1_CPHA_0_QUAD_SPI_1_C: cover property (mode_of_cfg_cpol_1_cpha_0(mosi0,miso0));
    CPOL_1_CPHA_0_QUAD_SPI_2_C: cover property (mode_of_cfg_cpol_1_cpha_0(mosi1,miso1));
    CPOL_1_CPHA_0_QUAD_SPI_3_C: cover property (mode_of_cfg_cpol_1_cpha_0(mosi3,miso2));
    CPOL_1_CPHA_0_QUAD_SPI_4_C: cover property (mode_of_cfg_cpol_1_cpha_0(mosi3,miso3));
  `endif
  
  //-------------------------------------------------------
  // Assertion for mode_of_cfg_cpol_1_cpha_1
  // when cpol is 1 and cpha is 1,
  // mosi data and miso data should be valid at the same negedge of sclk 
  //-------------------------------------------------------
  property mode_of_cfg_cpol_1_cpha_1(logic mosi_local,logic miso_local);
    @(negedge sclk) disable iff(!areset)
    cpol==1 && cpha==1 |-> !$isunknown(mosi_local) && !$isunknown(miso_local);
  endproperty: mode_of_cfg_cpol_1_cpha_1
  
  `ifdef SIMPLE_SPI
    CPOL_1_CPHA_1_SIMPLE_SPI: assert property (mode_of_cfg_cpol_1_cpha_1(mosi0,miso0));
    CPOL_1_CPHA_1_SIMPLE_SPI_C: cover property (mode_of_cfg_cpol_1_cpha_1(mosi0,miso0));
  `endif
  `ifdef DUAL_SPI
    CPOL_1_CPHA_1_DUAL_SPI_1: assert property (mode_of_cfg_cpol_1_cpha_1(mosi0,miso0));
    CPOL_1_CPHA_1_DUAL_SPI_2: assert property (mode_of_cfg_cpol_1_cpha_1(mosi1,miso1));
      
    CPOL_1_CPHA_1_DUAL_SPI_1_C: cover property (mode_of_cfg_cpol_1_cpha_1(mosi0,miso0));
    CPOL_1_CPHA_1_DUAL_SPI_2_C: cover property (mode_of_cfg_cpol_1_cpha_1(mosi1,miso1));
  `endif
  `ifdef QUAD_SP1
    CPOL_1_CPHA_1_QUAD_SPI_1: assert property (mode_of_cfg_cpol_1_cpha_1(mosi0,miso0));
    CPOL_1_CPHA_1_QUAD_SPI_2: assert property (mode_of_cfg_cpol_1_cpha_1(mosi1,miso1));
    CPOL_1_CPHA_1_QUAD_SPI_3: assert property (mode_of_cfg_cpol_1_cpha_1(mosi3,miso2));
    CPOL_1_CPHA_1_QUAD_SPI_4: assert property (mode_of_cfg_cpol_1_cpha_1(mosi3,miso3));
      
    CPOL_1_CPHA_1_QUAD_SPI_1_C: cover property (mode_of_cfg_cpol_1_cpha_1(mosi0,miso0));
    CPOL_1_CPHA_1_QUAD_SPI_2_C: cover property (mode_of_cfg_cpol_1_cpha_1(mosi1,miso1));
    CPOL_1_CPHA_1_QUAD_SPI_3_C: cover property (mode_of_cfg_cpol_1_cpha_1(mosi3,miso2));
    CPOL_1_CPHA_1_QUAD_SPI_4_C: cover property (mode_of_cfg_cpol_1_cpha_1(mosi3,miso3));
  `endif

/*
  // Assertion for if_cs_is_stable_during_transfers
  // cs should be low and stable till data transfer is successful ($stable)
  sequence if_cs_is_stable_during_transfers_s1;
    @(posedge sclk)
    cs == 0;
  endsequence:if_cs_is_stable_during_transfers_s1

  sequence if_cs_is_stable_during_transfers_s2;
    @(posedge sclk)
    $stable(cs)[*8];
  endsequence:if_cs_is_stable_during_transfers_s2

  property if_cs_is_stable_during_transfers;
    @(posedge sclk) disable iff(!areset)
    if_cs_is_stable_during_transfers_s1 |-> if_cs_is_stable_during_transfers_s2;
  endproperty:if_cs_is_stable_during_transfers
  IF_CS_IS_STABLE_DURING_TRANSFERS: assert property (if_cs_is_stable_during_transfers);
 
  // Assertion for successful_data_transfers
  // cs should be low for multiples of 8 clock cycles for successful data transfer
   sequence successful_data_transfers_s1;
    @(posedge sclk)
    (!cs && !$isunknown(mosi0))[*8];
  endsequence:successful_data_transfers_s1

  property successful_data_transfers;
    @(posedge sclk) disable iff(!areset)
    successful_data_transfers_s1;
  endproperty:successful_data_transfers
  SUCCESSFUL_DATA_TRANSFERS: assert property (successful_data_transfers);
*/

endinterface : master_assertions

`endif

