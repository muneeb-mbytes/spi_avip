//--------------------------------------------------------------------------------------------
// Interface : slave_driver_bfm
//  Used as the HDL driver for SPI
//  It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
//  intf - SPI Interface
//--------------------------------------------------------------------------------------------
interface slave_driver_bfm(spi_if drv_intf, spi_if.MON_MP mon_intf);

  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import spi_slave_pkg::slave_driver_proxy;
  slave_driver_proxy drv_proxy;

  initial begin
    $display("Slave Driver BFM");
  end

endinterface : slave_driver_bfm
