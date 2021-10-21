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

  parameter int DATA_WIDTH = 8;
  
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

  task mosi_pos_miso_neg(bit[7:0] data);
        
    drive_msb_first(data);
          
    drv_intf.MDR_CB.mosi0 = tx.data_master_in_slave_out;
  
  endtask : mosi_pos_miso_neg
  
  // MSB is driven first
  task drive_msb_first(input bit[7:0] data);
    for(int i=DATA_WIDTH; i>0 ; i--) begin
      @(drv_intf.sample_mosi_pos_cb.sclk);
      drv_intf.MDR_CB.mosi0 = data[i-1];
    end
  endtask: drive_msb_first

  
  // LSB is driven first
  task drive_lsb_first(input bit[7:0] data);
  for(int i=0; i < DATA_WIDTH; i++) begin
    @(drv_intf.sample_mosi_pos_cb.sclk);
    drv_intf.MDR_CB.mosi0 = data[i];
  end
  
  /*
  task slave_driver::drive_mosi_neg_miso_pos();
  task slave_driver::drive_mosi_pos_miso_neg();
  task slave_driver::drive_mosi_neg_miso_pos();
  */

endinterface : slave_driver_bfm

`endif
