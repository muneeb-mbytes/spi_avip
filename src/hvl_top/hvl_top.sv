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
<<<<<<< HEAD
  master_monitor_bfm m_mon_bfm_h(vif.MON_MP); 
=======

>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
  //-------------------------------------------------------
  // run_test for simulation
  //-------------------------------------------------------
  initial begin
    //-------------------------------------------------------
    // Setting SPI Interface
    //-------------------------------------------------------
    uvm_config_db #(virtual spi_if)::set(null,"*","vif",vif); 
<<<<<<< HEAD
    uvm_config_db #(virtual master_monitor_bfm)::set(null,"*","m_mon_bfm_h",m_mon_bfm_h);
=======
>>>>>>> dfc01ce26b0bff2778eb8b7ad3edf43a349d7b27
    run_test("base_test");
  end

endmodule : hvl_top
