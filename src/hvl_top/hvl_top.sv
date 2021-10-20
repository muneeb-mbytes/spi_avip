//--------------------------------------------------------------------------------------------
// Module: Hvl top module
//--------------------------------------------------------------------------------------------
module hvl_top;

  //-------------------------------------------------------
  // Package : Importing Uvm Pakckage and Test Package
  //-------------------------------------------------------
  import test_pkg::*;
  import uvm_pkg::*;

  //-------------------------------------------------------
  // Declaring SPI and Slave_driver_bfm Interface
  //-------------------------------------------------------
  spi_if vif();
  slave_driver_bfm v_drv_bfm(vif.SLV_DRV_MP);

  //-------------------------------------------------------
  // run_test for simulation
  //-------------------------------------------------------
  initial begin
    //-------------------------------------------------------
    // Setting SPI Interface
    //-------------------------------------------------------
    uvm_config_db #(virtual spi_if)::set(null,"*","spi_if",vif); 
    
    //-------------------------------------------------------
    // Setting Slave_driver_bfm Interface
    //-------------------------------------------------------
    uvm_config_db #(virtual slave_driver_bfm)::set(null,"*","slave_driver_bfm",v_drv_bfm); 

    run_test("base_test");
  end

endmodule : hvl_top
