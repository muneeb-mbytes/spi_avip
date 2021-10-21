//--------------------------------------------------------------------------------------------
<<<<<<< HEAD
// Interface : slave_driver_bfm
//  Used as the HDL driver for SPI
//  It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
//  intf - SPI Interface
//--------------------------------------------------------------------------------------------
interface slave_driver_bfm(spi_if drv_vif, spi_if.MON_MP mon_vif);

  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import spi_slave_pkg::slave_driver_proxy;
  slave_driver_proxy drv_proxy;
=======
// Module       : Slave Driver BFM
// Description  : Connects the slave driver bfm with the driver proxy
//--------------------------------------------------------------------------------------------
module slave_driver_bfm(spi_if intf);
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27

  initial begin
    $display("Slave Driver BFM");
  end

<<<<<<< HEAD
endinterface : slave_driver_bfm
=======
endmodule : slave_driver_bfm
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
