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


  // Assertion for if signals are stable
  // When cs is high, the signals sclk, mosi, miso should be stable.
  property if_signals_are_stable(logic miso0_local, logic mosi_local);
    @(posedge pclk)
    //@(posedge pclk) disable iff(!areset)
    cs == '1 |-> $stable(sclk) && $stable(mosi0_local) && $stable(miso0_local);
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

endinterface : slave_assertions

`endif
