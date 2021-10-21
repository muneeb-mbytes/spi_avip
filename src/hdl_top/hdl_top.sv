<<<<<<< HEAD
// TODO(mshariff): 
=======
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
//--------------------------------------------------------------------------------------------
// Module      : HDL Top
// Description : Has a interface and slave agent bfm.
//--------------------------------------------------------------------------------------------

//-------------------------------------------------------
// Including SPI interface and Slave Agent BFM Files
//-------------------------------------------------------
<<<<<<< HEAD
module hdl_top;

  //-------------------------------------------------------
  // Clock Reset Initialization
  //-------------------------------------------------------
  bit clk;
  bit rst;

  //-------------------------------------------------------
  // Display statement for HDL_TOP
  //-------------------------------------------------------
  initial begin
    $display("HDL_TOP");
  end

  //-------------------------------------------------------
  // System Clock Generation
  //-------------------------------------------------------
  initial begin
    clk = 1'b0;
    forever #40 clk = ~clk;
  end

  //-------------------------------------------------------
  // System Reset Generation
  //-------------------------------------------------------
  initial begin
    rst = 1'b0;
    #80;
    rst = 1'b1;
  end

=======
`include "slave_agent_bfm.sv"

module hdl_top;

  initial begin
    $display("HDL_TOP");
  end
  
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
  //-------------------------------------------------------
  // SPI Interface Instantiation
  //-------------------------------------------------------
  spi_if intf();

  //-------------------------------------------------------
  // SPI BFM Agent Instantiation
  //-------------------------------------------------------
  slave_agent_bfm slave_agent_bfm_h(intf);

endmodule : hdl_top
