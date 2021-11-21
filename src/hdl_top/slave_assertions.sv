//--------------------------------------------------------------------------------------------
// Module : slave Assertions
// Used to write the assertion checks needed for the slave
//--------------------------------------------------------------------------------------------
`ifndef SLAVE_ASSERTION_INCLUDED_
`define SLAVE_ASSERTION_INCLUDED_

//-------------------------------------------------------
// Importing Global Package
//-------------------------------------------------------
import spi_globals_pkg::*;

interface slave_assertions(input pclk,
                           input areset,
                           input sclk,
                           input [NO_OF_SLAVES-1:0]cs,
                           input mosi0,
                           input mosi1,
                           input mosi2,
                           input mosi3,
                           input miso0,
                           input miso1,
                           input miso2,
                           input miso3);
  
  //-------------------------------------------------------
  // Importing Uvm Package
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh";
 //-------------------------------------------------------
 // Defining Macro
 //-------------------------------------------------------
  `define SIMPLE_SPI;
  `define DUAL_SPI;
  `define QUAD_SPI;

  //-------------------------------------------------------
  //
  //
  //-------------------------------------------------------
   Assertion for if signals are stable
   When cs is high, the signals sclk, mosi, miso should be stable.
  property if_signals_are_stable(logic miso_local, logic mosi_local);
    @(posedge pclk)
    //@(posedge pclk) disable iff(!areset)
    cs == '1 |-> $stable(sclk) && $stable(mosi_local) && $stable(miso_local);
  endproperty : if_signals_are_stable
 
  
  // Assertion Checking if mosi and miso is valid
  // when cs is low mosi and miso should be valid from next clock cycle.
  sequence slave_mosi_miso_valid_seq1;
    @(posedge pclk)
    cs == 0;
  endsequence : slave_mosi_miso_valid_seq1

  sequence slave_mosi_miso_valid_seq2(logic miso_local, logic mosi_local);
    @(posedge sclk)
    !$isunknown(miso_local) && !$isunknown(mosi_local);
  endsequence: slave_mosi_miso_valid_seq2

  property slave_miso_mosi_valid_p(logic miso_local, logic mosi_local);
    slave_mosi_miso_valid_seq1 |=> slave_mosi_miso_valid_seq2(miso_local,mosi_local)
  endproperty : slave_miso_mosi_valid_p
  SLAVE_MISO_MOSI_VALID_P: assert property (slave_miso_mosi_valid_p(mosi0,miso0));
  
  //-------------------------------------------------------
  // Assertion for cpol in idle state
  // when cpol is low, idle state should be logic low
  // when cpol is high,idle state should be logic high
  //-------------------------------------------------------
  property slave_cpol_idle_state_check_p;
    @(posedge pclk) disable iff(!areset)
    cs=='1 |-> slave_agent_bfm_h.spi_trans_h.cpol == sclk;
  endproperty : slave_cpol_idle_state_check_p


  //Assertion for mode_of_cfg_cpol_0_cpha_1
  //when cs is low immediately mosi data should be stable after at negedge miso should be stable 
  property mode_of_cfg_cpol_0_cpha_1(logic mosi_local, logic miso_local);
    @(posedge sclk) disable iff(!areset)
    cpol==0 && cpha==1 |-> $stable(mosi_local) && $stable(miso_local);
  endproperty: mode_of_cfg_cpol_0_cpha_1
  `ifdef SIMPLE_SPI
    CPOL_0_CPHA_1_SIMPLE_SPI: assert property (mode_of_cfg_cpol_0_cpha_1(mosi0,miso0));
  `endif
 `ifdef DUAL_SPI
    CPOL_0_CPHA_1_DUAL_SPI_1: assert property (mode_of_cfg_cpol_0_cpha_1(mosi0,miso0));
    CPOL_0_CPHA_1_DUAL_SPI_2: assert property (mode_of_cfg_cpol_0_cpha_1(mosi1,miso1));
  `endif
  `ifdef QUAD_SPI
    CPOL_0_CPHA_1_QUAD_SPI_1: assert property (mode_of_cfg_cpol_0_cpha_1(mosi0,miso0));
    CPOL_0_CPHA_1_QUAD_SPI_2: assert property (mode_of_cfg_cpol_0_cpha_1(mosi1,miso1)));
    CPOL_0_CPHA_1_QUAD_SPI_3: assert property (mode_of_cfg_cpol_0_cpha_1(mosi3,miso2));
    CPOL_0_CPHA_1_QUAD_SPI_4: assert property (mode_of_cfg_cpol_0_cpha_1(mosi3,miso3));
  `endif
  */
  //Assertion for mode_of_cfg_cpol_1_cpha_0
  //when cpol is 1 and cpha is 0 immediately mosi data and miso data should be valid at the samenegedge of sclk 
  property mode_of_cfg_cpol_1_cpha_0(logic mosi_local,logic miso_local);
    @(posedge sclk) disable iff(!areset)
    cpol==1 && cpha==0 |-> $stable(mosi_local) && $stable(miso_local);
  endproperty: mode_of_cfg_cpol_1_cpha_0
  `ifdef SIMPLE_SPI
    CPOL_1_CPHA_0_SIMPLE_SPI: assert property (mode_of_cfg_cpol_1_cpha_0(mosi0,miso0));
  `endif
 `ifdef DUAL_SPI
    CPOL_1_CPHA_0_DUAL_SPI_1: assert property (mode_of_cfg_cpol_1_cpha_0(mosi0,miso0));
    CPOL_1_CPHA_0_DUAL_SPI_2: assert property (mode_of_cfg_cpol_1_cpha_0(mosi1,miso1));
  `endif
  `ifdef QUAD_SPI
    CPOL_1_CPHA_0_QUAD_SPI_1: assert property (mode_of_cfg_cpol_1_cpha_0(mosi0,miso0));
    CPOL_1_CPHA_0_QUAD_SPI_2: assert property (mode_of_cfg_cpol_1_cpha_0(mosi1,miso1)));
    CPOL_1_CPHA_0_QUAD_SPI_3: assert property (mode_of_cfg_cpol_1_cpha_0(mosi3,miso2));
    CPOL_1_CPHA_0_QUAD_SPI_4: assert property (mode_of_cfg_cpol_1_cpha_0(mosi3,miso3));
  `endif



  /* 
  //Assertion for Checking if cs is stable during transfers
  //cs should be low and stable till data transfer is successful ($stable)
  property slave_cs_stable;
    @(posedge pclk) disable iff(!areset)
    cs == 0 |=> $stable(cs)[*DATA_WIDTH-1];
  endproperty : slave_cs_stable
  SLAVE_CS_LOW_FOR_CONT_CYCLES : assert property(slave_cs_stable);
  



 initial begin
    spi_type = '0;
  end
  //generate
  initial begin
  if(spi_type =='0) //begin
     assert property (if_signals_are_stable(mosi0,miso0));
 // end
  /*if(spi_type == 2'd1) begin
    IF_SIGNALS_ARE_STABLE_DUAL_SPI_1: assert property (if_signals_are_stable(mosi0,miso0));
    IF_SIGNALS_ARE_STABLE_DUAL_SPI_2: assert property (if_signals_are_stable(mosi1,miso1));
  end
  if(spi_type == 2'd2) begin
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_1: assert property (if_signals_are_stable(mosi0,miso0));
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_2: assert property (if_signals_are_stable(mosi1,miso1));
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_3: assert property (if_signals_are_stable(mosi2,miso2));
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_4: assert property (if_signals_are_stable(mosi3,miso3));
  end
 //end

 
 
  
  initial begin
    spi_type = '0;
  end
  //generate
  initial begin
  if(spi_type =='0) //begin
     assert property (slave_miso_mosi_valid_p(mosi0,miso0));
 // end
  if(spi_type == 2'd1) begin
    IF_SIGNALS_ARE_STABLE_DUAL_SPI_1: assert property (slave_miso_mosi_valid_p(mosi0,miso0));
    IF_SIGNALS_ARE_STABLE_DUAL_SPI_2: assert property (slave_miso_mosi_valid_p(mosi1,miso1));
  end
  if(spi_type == 2'd2) begin
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_1: assert property (slave_miso_mosi_valid_p(mosi0,miso0));
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_2: assert property (slave_miso_mosi_valid_p(mosi1,miso1));
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_3: assert property (slave_miso_mosi_valid_p(mosi2,miso2));
    IF_SIGNALS_ARE_STABLE_QUAD_SPI_4: assert property (slave_miso_mosi_valid_p(mosi3,miso3));
  end
// end
*/
  /*
  //Assertion for mode_of_cfg_cpol_0_cpha_0
  //when cpol is 0 and cpha is 0 immediately mosi data and miso data should be valid at the same posedge of sclk 
  property mode_of_cfg_cpol_0_cpha_0(logic mosi_local,logic miso_local);
    @(negedge sclk) disable iff(areset)
    cpol==0 && cpha==0 |-> $stable(mosi_local) && $stable(miso_local);
  endproperty: mode_of_cfg_cpol_0_cpha_0
  `ifdef SIMPLE_SPI
    CPOL_0_CPHA_0_SIMPLE_SPI: assert property (mode_of_cfg_cpol_0_cpha_0(mosi0,miso0));
  `endif
 `ifdef DUAL_SPI
    CPOL_0_CPHA_0_DUAL_SPI_1: assert property (mode_of_cfg_cpol_0_cpha_0(mosi0,miso0));
    CPOL_0_CPHA_0_DUAL_SPI_2: assert property (mode_of_cfg_cpol_0_cpha_0(mosi1,miso1));
  `endif
  `ifdef QUAD_SPI
    CPOL_0_CPHA_0_QUAD_SPI_1: assert property (mode_of_cfg_cpol_0_cpha_0(mosi0,miso0));
    CPOL_0_CPHA_0_QUAD_SPI_2: assert property (mode_of_cfg_cpol_0_cpha_0(mosi1,miso1)));
    CPOL_0_CPHA_0_QUAD_SPI_3: assert property (mode_of_cfg_cpol_0_cpha_0(mosi3,miso2));
    CPOL_0_CPHA_0_QUAD_SPI_4: assert property (mode_of_cfg_cpol_0_cpha_0(mosi3,miso3));
  `endif
*/
endinterface : slave_assertions

`endif
