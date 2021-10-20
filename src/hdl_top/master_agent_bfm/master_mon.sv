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
 
//
//    bit [2:0]cpol;
//    bit [2:0]cphs;
//
//
//    //task 1
//    task write(bit [7:0]mosi);
//    
//    if(!cs) begin
//      case(cpol,cphase);
//      
//      2'b00 : begin
//              data.mosi0 <= intf.mosi_pos_cb.mosi0;
//              data.miso0 <= intf.miso_pos_cb.miso0;
//              end
//
//      2'b01 : begin
//              data.mosi1 <= intf.mosi_pos_cb.mosi1;
//              data.miso1 <= intf.miso_neg_cb.miso1;
//              end
//
//      2'b10 : begin
//              data.mosi1 <= intf.mosi_neg_cb.mosi2;
//              data.miso1 <= intf.miso_pos_cb.miso2;
//              end
//
//      2'b11 : begin
//              data.mosi1 <= intf.mosi_neg_cb.mosi3;
//              data.miso1 <= intf.miso_neg_cb.miso3;
//              end

 //--------------------------------------------------------------------------------------------
 // 2nd part
 //--------------------------------------------------------------------------------------------
      
    //task 1
    task po0_ph0(bit [7:0]mosi);
