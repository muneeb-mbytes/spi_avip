
`ifndef MASTER_DRIVER_BFM_INCLUDED_
`define MASTER_DRIVER_BFM_INCLUDED_

 //--------------------------------------------------------------------------------------------
 // Interface:master_driver_bfm
 // It connects with master_driver_proxy
 //
 // Parameters:
 // intf - SPI Interface
 //--------------------------------------------------------------------------------------------
 interface master_driver_bfm (spi_if.MAS_DRV_MP m_drv_intf,spi_if.MON_MP mon_intf);


   parameter int DATA_WIDTH =8;

   //-------------------------------------------------------
   // creating handle for proxy driver.
   //-------------------------------------------------------
   import spi_master_pkg::master_driver_proxy;
   master_driver_proxy m_dry_proxy_h;


   import spi_master_pkg::master_tx;
   master_tx tx;
  
   initial begin
   tx = new;
   $display("Master Driver BFM");
   end


  
  //--------------------------------------------------------------------------------------------
  // Task for driving mosi signal and sampling miso signal for condition cpol==0,cpha==0
  //--------------------------------------------------------------------------------------------
  task drive_mosi_pos_miso_neg_cpol_0_cpha_0 (bit[7:0] data);
    drive_msb_first_cpol_0_chpa_0(data);
    drive_lsb_first_cpol_0_cpha_0(data);
    drv_intf.SLV_DRV_MP.miso0 = tx.data_master_out_slave_in;
  endtask : drive_mosi_pos_miso_neg_cpol_0_cpha_0
  
  // MSB is driven first
  task drive_msb_first_cpol_0_cpha_0 (input bit[7:0] data);
    for(int i=DATA_WIDTH; i>0 ; i--) begin
      @(drv_intf.sample_miso_pos_cb.sclk);
      drv_intf.SLV_DRV_MP.miso0 = data[i-1];
    end
  endtask : drive_msb_first_cpol_0_cpha_0
  
  // LSB is driven first
  task drive_lsb_first_cpol_0_cpha_0 (input bit[7:0] data);
    for(int i=0; i < DATA_WIDTH; i++) begin
      @(drv_intf.sample_miso_pos_cb.sclk);
      drv_intf.SLV_DRV_MP.miso0 = data[i];
    end
  endtask : drive_lsb_first_cpol_0_cpha_0
  //--------------------------------------------------------------------------------------------
  // Task for driving mosi signal and sampling miso signal for condition cpol==0,cpha==1
  //--------------------------------------------------------------------------------------------
  task drive_mosi_pos_miso_neg_cpol_0_cpha_1 (bit[7:0] data);
    drive_msb_first_cpol_0_chpa_1(data);
    drive_lsb_first_cpol_0_cpha_1(data);
    drv_intf.SLV_DRV_MP.miso1 = tx.data_master_out_slave_in;
  endtask : drive_mosi_pos_miso_neg_cpol_0_cpha_1
  
  // MSB is driven first
  task drive_msb_first_cpol_0_cpha_1 (input bit[7:0] data);
    for(int i=DATA_WIDTH; i>0 ; i--) begin
      @(drv_intf.sample_miso_pos_cb.sclk);
      drv_intf.SLV_DRV_MP.miso1 = data[i-1];
    end
  endtask : drive_msb_first_cpol_0_cpha_1
  
  // LSB is driven first
  task drive_lsb_first_cpol_0_cpha_1 (input bit[7:0] data);
    for(int i=0; i < DATA_WIDTH; i++) begin
      @(drv_intf.sample_miso_pos_cb.sclk);
      drv_intf.SLV_DRV_MP.miso1 = data[i];
    end
  endtask : drive_lsb_first_cpol_0_cpha_1
  //--------------------------------------------------------------------------------------------
  // Task for driving mosi signal and sampling miso signal for condition cpol==1,cpha==0
  //--------------------------------------------------------------------------------------------
  task drive_mosi_pos_miso_neg_cpol_1_cpha_0 (bit[7:0] data);
    drive_msb_first_cpol_1_chpa_0(data);
    drive_lsb_first_cpol_1_cpha_0(data);
    drv_intf.SLV_DRV_MP.miso2 = tx.data_master_out_slave_in;
  endtask : drive_mosi_pos_miso_neg_cpol_1_cpha_0
  
  // MSB is driven first
  task drive_msb_first_cpol_1_cpha_0 (input bit[7:0] data);
    for(int i=DATA_WIDTH; i>0 ; i--) begin
      @(drv_intf.sample_miso_pos_cb.sclk);
      drv_intf.SLV_DRV_MP.miso2 = data[i-1];
    end
  endtask : drive_msb_first_cpol_1_cpha_0
  
  // LSB is driven first
  task drive_lsb_first_cpol_1_cpha_0 (input bit[7:0] data);
    for(int i=0; i < DATA_WIDTH; i++) begin
      @(drv_intf.sample_miso_pos_cb.sclk);
      drv_intf.SLV_DRV_MP.miso2 = data[i];
    end
  endtask : drive_lsb_first_cpol_1_cpha_0

  //--------------------------------------------------------------------------------------------
  // Task for driving mosi signal and sampling miso signal for condition cpol==1,cpha==1
  //--------------------------------------------------------------------------------------------
  task drive_mosi_pos_miso_neg_cpol_1_cpha_1 (bit[7:0] data);
    drive_msb_first_cpol_1_chpa_1(data);
    drive_lsb_first_cpol_1_cpha_1(data);
    drv_intf.SLV_DRV_MP.miso3 = tx.data_master_out_slave_in;
  endtask : drive_mosi_pos_miso_neg_cpol_1_cpha_1
  
  // MSB is driven first
  task drive_msb_first_cpol_1_cpha_1 (input bit[7:0] data);
    for(int i=DATA_WIDTH; i>0 ; i--) begin
      @(drv_intf.sample_miso_pos_cb.sclk);
      drv_intf.SLV_DRV_MP.miso3 = data[i-1];
    end
  endtask : drive_msb_first_cpol_1_cpha_1
  
  // LSB is driven first
  task drive_lsb_first_cpol_1_cpha_1 (input bit[7:0] data);
    for(int i=0; i < DATA_WIDTH; i++) begin
      @(drv_intf.sample_miso_pos_cb.sclk);
      drv_intf.SLV_DRV_MP.miso3 = data[i];
    end
  endtask : drive_lsb_first_cpol_1_cpha_1

 endinterface:master_driver_bfm

`endif

