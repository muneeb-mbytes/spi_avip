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
/*
task slave_driver_proxy::drive_to_dut(slave_tx tx);
//  `uvm_info(get_type_name(), $sformatf("Inside the slave_driver_proxy"), UVM_LOW)
  case: {cpol,cpha}
    2'b00: v_bfm.drive_pos_data_cpol_cpoh();
    2'b01: v_bfm.drive_negedge_data();
    2'b10: v_bfm.drive_negedge_data();
    2'b11: v_bfm.drive_negedge_data();
  endcase
endtask : drive_to_dut
*/
