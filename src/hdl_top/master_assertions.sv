//--------------------------------------------------------------------------------------------
// Module : Master Assertions
// Used to write the assertion checks needed for the master
//--------------------------------------------------------------------------------------------
`ifndef MASTER_ASSERTIONS_INCLUDED_
`define MASTER_ASSERTIONS_INCLUDED_

  //-------------------------------------------------------
  // Importing Uvm Package
  //-------------------------------------------------------
  import spi_globals_pkg::*;

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

  //-------------------------------------------------------
  // Importing Uvm Package
  //-------------------------------------------------------
  import uvm_pkg::*;
  `include "uvm_macros.svh";

  initial begin
    `uvm_info("MASTER_ASSERTIONS","MASTER ASSERTIONS",UVM_LOW);
  end
  
  // Assertion for if_signals_are_stable
  // When cs is high, the signals sclk, mosi, miso should be stable.
  property if_signals_are_stable;
    @(posedge sclk) disable iff(!areset)
    cs == 1 |-> $stable(sclk) && $stable(mosi0) && $stable(miso0);
  endproperty : if_signals_are_stable
  IF_SIGNALS_ARE_STABLE: assert property (if_signals_are_stable);


  // Assertion for master_mosi0_valid
  // when cs is low mosi should be valid from next clock cycle.
  sequence master_mosi0_valid_seq;
    cs==0;
  endsequence : master_mosi0_valid_seq

  property master_mosi0_valid_p;
    @(posedge sclk) disable iff(!areset)
    master_mosi0_valid_seq |-> !$isunknown(mosi0);
  endproperty : master_mosi0_valid_p
  MASTER_CS_LOW_CHECK: assert property (master_mosi0_valid_p);
  

  // Assertion for if_cs_is_stable_during_transfers
  // cs should be low and stable till data transfer is successful ($stable)
  sequence s1;
    @(posedge sclk)
    cs == 0;
  endsequence:s1

  sequence s2;
    @(posedge sclk)
    $stable(cs)[*8];
  endsequence:s2

  property if_cs_is_stable_during_transfers;
    @(posedge sclk) disable iff(!areset)
    s1 |-> s2;
  endproperty:if_cs_is_stable_during_transfers
  IF_CS_IS_STABLE_DURING_TRANSFERS: assert property (if_cs_is_stable_during_transfers);

endinterface : master_assertions

`endif
