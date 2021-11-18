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

  initial begin
    `uvm_info("slave_ASSERTIONS","slave ASSERTIONS",UVM_LOW);
  end  

/*
  // Assertion for if signals are stable
  // When cs is high, the signals sclk, mosi, miso should be stable.
  property if_signals_are_stable;
    @(posedge pclk)
    //@(posedge pclk) disable iff(!areset)
    cs == '1 |-> $stable(sclk) && $stable(mosi0) && $stable(miso0);
  endproperty : if_signals_are_stable
  IF_SIGNALS_ARE_STABLE: assert property (if_signals_are_stable);
 */
  
  // Assertion for slave_miso0_valid
  // when cs is low mosi should be valid from next clock cycle.
  sequence slave_miso0_valid_seq;
    cs==0;
  endsequence : slave_miso0_valid_seq

  property slave_miso0_valid_p;
    @(posedge sclk) disable iff(areset==0)
    slave_miso0_valid_seq |-> !$isunknown(miso0);
  endproperty : slave_miso0_valid_p
  SLAVE_CS_LOW_CHECK: assert property (slave_miso0_valid_p);
    
  
  /*
  //Assertion for Checking if cs is stable during transfers
  //cs should be low and stable till data transfer is successful ($stable)
  property slave_cs_stable;
    @(posedge pclk) disable iff(!areset)
    cs == 0 |=> $stable(cs)[*DATA_WIDTH-1];
  endproperty : slave_cs_stable
  SLAVE_CS_LOW_FOR_CONT_CYCLES : assert property(slave_cs_stable);
  

*/

endinterface : slave_assertions

`endif
