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
    forever #10 clk = ~clk;
  end

  //-------------------------------------------------------
  // System Reset Generation
  // Active low reset
  //-------------------------------------------------------
  initial begin
    rst = 1'b1;

    repeat (2) begin
      @(posedge clk);
    end
    rst = 1'b0;

    repeat (2) begin
      @(posedge clk);
    end
    rst = 1'b1;
  end
  
  // Variable : intf
  // SPI Interface Instantiation
  spi_if intf(.pclk(clk),
              .areset(rst));
  
  // Variable : slave_agent_bfm_h
  // SPI Slave BFM Agent Instantiation
  slave_agent_bfm slave_agent_bfm_h(intf);

  // Variable : master_agent_bfm_h
  //SPI Master BFM Agent Instantiation 
  master_agent_bfm master_agent_bfm_h(intf); 

  // Waveform dump for Cadence simulator
  // For Questa the makefile will generate the waveforms (.wlf)
/*  initial begin
    `ifdef WAVES_OFF
     `else
       string path_to_waveform;
       reg [2047:0] path_to_waveform_reg;

       if($value$plusargs("WAVEFORM_PATH=%s", path_to_waveform)) begin
         // The simulator will not support the string as input to shm_open system task.
         // To mitigate this you need to send reg variable to shm_open
         path_to_waveform_reg = reg'(path_to_waveform);
         end
       else path_to_waveform = "waves.shm";

       $shm_probe("AS");
     `endif
   end
   */

endmodule : hdl_top

`endif

