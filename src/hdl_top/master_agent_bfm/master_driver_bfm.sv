`ifndef MASTER_DRIVER_BFM_INCLUDED_
 `define MASTER_DRIVER_BFM_INCLUDED_

 //--------------------------------------------------------------------------------------------
 // Interface:master_driver_bfm
 // It connects with master_driver_proxy
 //
 // Parameters:
 // intf - SPI Interface
 //--------------------------------------------------------------------------------------------
 interface master_driver_bfm (spi_if.MDR_MP drv_intf);

   parameter int DATA_WIDTH =8;

   //-------------------------------------------------------
   // creating handle for proxy driver.
   //-------------------------------------------------------
   import spi_master_pkg::master_driver_proxy;
   master_driver_proxy mdry_proxy;


   initial 
   begin
     $display("Master driver BFM")
   end

   //mosi data driving on to the interface
   task mosi_pos_miso_neg(bit[7:0] data);
     drive_msb_first(data);
     drv_intf.MDR_CB.mosi = tx.data_master_in_slave_out;
   endtask:mosi_pos_miso_neg

   // MSB is driven first
   task drive_msb_first(input bit[7:0] data);
     for(int i=DATA_WIDTH;i>0;i--)begin
       @(drv_intf.sample_mosi_pos_cb.sclk);
       drv_intf.MDR_CB.mosi = data[i-1];
     end
   endtask:drive_msb_first


   // LSB is driven first
   task drive_lsb_first(input bit[7:0] data);
     for(int i=0;i<DATA_WIDTH;i++)begin
       @(drv_intf.sample_mosi_pos_cb.sclk);
       drv_intf.MDR_CB.mosi = data[i];
     end
   endtask:drive_lsb_first
 
 endinterface:master_driver_bfm

`endif


