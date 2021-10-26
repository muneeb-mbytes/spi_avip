`ifndef MASTER_DRIVER_BFM_INCLUDED_
`define MASTER_DRIVER_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
//Interface : master_driver_bfm
//Used as the HDL driver for SPI
//It connects with the HVL driver_proxy for driving the stimulus
//
//Parameters:
//intf - SPI Interface
//--------------------------------------------------------------------------------------------


interface master_driver_bfm(spi_if intf);
  
  import spi_master_pkg::master_driver_proxy;

  //--------------------------------------------------------------------------------------------
  // Creating handle for virtual Interface
  //--------------------------------------------------------------------------------------------
  // virtual spi_if v_intf;
 
  //--------------------------------------------------------------------------------------------
  //Creating the handle for proxy driver
  //--------------------------------------------------------------------------------------------
  master_driver_proxy master_drv_proxy_h;

  initial begin
    $display("Master driver BFM");
  end

endinterface : master_driver_bfm
`endif
