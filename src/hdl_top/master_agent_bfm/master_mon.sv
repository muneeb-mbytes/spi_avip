//-------------------------------------------------------
//Module : Master Monitor BFM
//
//Description : Connection is from the master monitor bfm to the monitor proxy 
//-------------------------------------------------------
module master_monitor_bfm (spi_if.MON_MP intf);

//--------------------------------------------------------------------------------------------
// Creating the handel for the proxy monitor
//--------------------------------------------------------------------------------------------
  import spi_master_pkg::master_monitor_proxy;
  master_monitor_proxy m_mon_proxy  
 
  task write(bit [7:0]mosi);
  
   

    data_sent.sclk = intf.mmon_cb.sclk;
 
    task 1

    data_sent.cs = intf.mmon_cb.ss;
    data_sent.mosi0 = intf.mmon_cb.mosi0;
    data_sent.miso0 = intf.mmon_cb.miso0;  
    
    task 2
    data_sent.mosi1 = intf.mmon_cb.mosi1;
    data_sent.miso1 = intf.mmon_cb.miso1; 

    task 3
    data_sent.mosi2 = intf.mmon_cb.mosi2;
    data_sent.miso2 = intf.mmon_cb.miso2; 
 
    task 4 
    data_sent.mosi3 = intf.mmon_cb.mosi3;
    data_sent.miso3 = intf.mmon_cb.miso3

  initial begin
  $display("Master Monitor BFM");
  end

endmodule: master_monitor_bfm

