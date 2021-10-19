//--------------------------------------------------------------------------------------------
// Module      : Slave Agent BFM
// Description : Instantiates driver and monitor
//--------------------------------------------------------------------------------------------

//-------------------------------------------------------
// Making a copy of the bfm files using `include
//-------------------------------------------------------
//module slave_agent_bfm(spi_if intf);
module slave_agent_bfm();
  
  initial begin
    $display("Slave Agent BFM");
  end

  spi_if intf();
  //-------------------------------------------------------
  //Slave driver bfm instantiation
  //-------------------------------------------------------
  slave_driver_bfm slave_driver_bfm_h(intf);

  //-------------------------------------------------------
  //Slave driver bfm instantiation
  //-------------------------------------------------------
  slave_monitor_bfm slave_monitor_bfm_h(intf);

endmodule : slave_agent_bfm
