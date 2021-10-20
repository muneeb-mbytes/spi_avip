`ifndef SLAVE_DRIVER_BFM_INCLUDED_
`define SLAVE_DRIVER_BFM_INCLUDED_

//--------------------------------------------------------------------------------------------
// Interface : slave_driver_bfm
//  Used as the HDL driver for SPI
//  It connects with the HVL driver_proxy for driving the stimulus
//
// Parameters:
//  intf - SPI Interface
//--------------------------------------------------------------------------------------------
//interface slave_driver_bfm(spi_if drv_intf, spi_if.SLV_DRV_MP drv_intf);
interface slave_driver_bfm(spi_if.SLV_DRV_MP drv_intf);

  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import spi_slave_pkg::slave_driver_proxy;
  slave_driver_proxy drv_proxy;
  
  //-------------------------------------------------------
  // Creating the handle for slave transaction
  //-------------------------------------------------------
  import spi_slave_pkg::slave_tx;
  slave_tx tx;
  
  initial begin
    $display("Slave Driver BFM");
  end

  if (drv_intf.tx.cs == 0) begin
    case ({drv_intf.tx.cpol,drv_intf.tx.cpha})
     2'b00: mosi_pos_miso_neg();
//   2'b01: mosi_neg_miso_pos();
//   2'b10: mosi_pos_miso_neg();
//   2'b11: mosi_neg_miso_pos();
    endcase
  end

  task mosi_pos_miso_neg();
    @(drv_intf.sample_mosi_pos_cb.sclk);
    for(int i=0; i<tx.data_master_in_slave_out; i++) begin
      tx.data_master_out_slave_in[0] = drv_intf.s_neg_drv_cb.miso0;
      $display ("right_shift_operation",tx.data_master_out_slave_in << 1'b1);
    end
      
    drv_intf.MDR_CB.mosi0 = tx.data_master_in_slave_out;
  
  endtask : mosi_pos_miso_neg

  /*
  task slave_driver::drive_mosi_neg_miso_pos();
  task slave_driver::drive_mosi_pos_miso_neg();
  task slave_driver::drive_mosi_neg_miso_pos();
  */

endinterface : slave_driver_bfm

`endif
