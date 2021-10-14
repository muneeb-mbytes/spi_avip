//--------------------------------------------------------------------------------------------
// Module      : HDL Top
// Description : Has a interface and slave agent bfm.
//--------------------------------------------------------------------------------------------

//-------------------------------------------------------
// Including SPI interface and Slave Agent BFM Files
//-------------------------------------------------------
`include "spi_if.sv"
`include "slave_agent_bfm.sv"

module hdl_top;

  initial begin
    $display("HDL_TOP");
  end
  
  //-------------------------------------------------------
  // SPI Interface Instantiation
  //-------------------------------------------------------
  spi_if intf();

  //-------------------------------------------------------
  // SPI BFM Agent Instantiation
  //-------------------------------------------------------
  slave_agent_bfm slave_agent_bfm_h(.intf(intf));

endmodule : hdl_top
