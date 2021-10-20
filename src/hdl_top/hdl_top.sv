`ifndef HDL_TOP_INCLUDED_
`define HDL_TOP_INCLUDED_

//--------------------------------------------------------------------------------------------
// Module      : HDL Top
// Description : Has a interface and slave agent bfm.
//--------------------------------------------------------------------------------------------

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
    rst = 1'b1;
    repeat (2) @(posedge clk)
    rst = 1'b0;
  end

  //-------------------------------------------------------
  // SPI Interface Instantiation
  //-------------------------------------------------------
  spi_if intf();

  //-------------------------------------------------------
  // SPI BFM Agent Instantiation
  //-------------------------------------------------------
  slave_agent_bfm slave_agent_bfm_h(intf);

endmodule : hdl_top

`endif

