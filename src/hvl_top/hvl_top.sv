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
  // Declaring SPI Interface
  //-------------------------------------------------------
  spi_if vif();
  slave_monitor_bfm s_mon_bfm_h(vif.MON_MP);
  //-------------------------------------------------------
  // run_test for simulation
  //-------------------------------------------------------
  initial begin
    //-------------------------------------------------------
    // Setting SPI Interface
    //-------------------------------------------------------
    uvm_config_db #(virtual spi_if)::set(null,"*","vif",vif); 
    uvm_config_db #(virtual slave_monitor_bfm)::set(null,"*","s_mon_bfm_h",s_mon_bfm_h); 
    run_test("base_test");
  end

endmodule : hvl_top
