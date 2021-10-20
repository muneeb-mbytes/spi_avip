//--------------------------------------------------------------------------------------------
// Module       : Slave Monitor BFM
// // TODO(mshariff): 
// Description  : Connects the slave monitor bfm with the monitor proxy
//--------------------------------------------------------------------------------------------

module slave_monitor_bfm (spi_if.MON_MP intf);
  
  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import spi_slave_pkg::slave_monitor_proxy;
  slave_monitor_proxy mon_proxy;

  initial begin
    $display("Slave Monitor BFM");
  end

endmodule : slave_monitor_bfm
