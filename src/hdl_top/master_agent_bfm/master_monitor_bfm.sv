<<<<<<< HEAD
//--------------------------------------------------------------------------------------------
// Inteface       : Master Monitor BFM
// Description  : Connects the master monitor bfm with the monitor proxy
// to call the tasks and functions from monitor bfm to monitor proxy
//--------------------------------------------------------------------------------------------
    interface master_monitor_bfm (spi_if.MON_MP intf);
    int i;    
    //-------------------------------------------------------
    // Creating the handle for proxy driver
    //-------------------------------------------------------
    import spi_master_pkg::master_monitor_proxy;
         master_monitor_proxy mon_proxy;
         initial begin
         $display("master Monitor BFM");
         end


    //--------------------------------------------------------------------------------------------
    //Task  : sample_mosi_pos_00
    //assigning the sample_miso_pos_cb to proxy miso
    //sampling happen on the posedge
    //--------------------------------------------------------------------------------------------

    task sample_miso_pos_00 (bit [7:0]data,bit miso);
        if(!intf.cs)begin
        for(i=0;i<7;i++)begin 
        @(intf.sample_miso_pos_cb)
        miso=intf.sample_miso_pos_cb.miso0;
      
        data = data << 1;
        data[i] = miso;
        end 
        end
      
    endtask : sample_miso_pos_00

    //--------------------------------------------------------------------------------------------
    //Task  : sample_mosi_neg_01
    //assigning the sampled_miso_neg_cb signal to proxy miso
    //sampling happen on the negedge
    //--------------------------------------------------------------------------------------------
 
    task sample_miso_neg_01 (bit [7:0]data,bit miso);
        
        if(!intf.cs)begin
        for(i=0;i<7;i++)begin 
        @(intf.sample_miso_neg_cb)
        miso=intf.sample_miso_neg_cb.miso0;
        
        data = data << 1;
        data[i] = miso;

        // data = data >> 1;
        // data[7] = mosi;
        end
        end     
        
      endtask : sample_miso_neg_01
    //--------------------------------------------------------------------------------------------
    //Task  :sample_miso_pos_10
    //assigning the sample_miso_pos_cb signal to proxy mosi
    //sampling happen on the posedge
    //--------------------------------------------------------------------------------------------
    task sample_miso_pos_10 (bit [7:0]data,bit miso);
      
        if(!intf.cs)begin
        for(i=0;i<7;i++)begin 
        @(intf.sample_miso_pos_cb)
        miso=intf.sample_miso_pos_cb.miso0;
      
        data = data << 1;
        data[i] = miso;
        end
        end
        
      endtask : sample_miso_pos_10

      //--------------------------------------------------------------------------------------------
      ///Task  : sample_miso_neg_11
      //assigning the sample_miso_pos_cb.miso signal to proxy miso
      //sampling happens on the negedge
      //--------------------------------------------------------------------------------------------
      task sample_miso_neg_11 (bit [7:0]data,bit miso);
      
        if(!intf.cs)begin
        for(i=0;i<7;i++)begin 
        @(intf.sample_miso_neg_cb)
        miso=intf.sample_miso_neg_cb.miso0;
        
        data = data << 1;
        data[i] = miso;
        end
        end
      endtask : sample_miso_neg_11

      endinterface : master_monitor_bfm
=======
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
    
      if(!cs) begin 

      data.mosi0 <= intf.mosi_pos_cb.mosi0;
      //data.miso0 <= intf.miso_pos_cb.miso0;  
    
    //task 2
    task po0_ph1(bit [7:0]mosi);
      data.mosi1 <= intf.mosi_pos_cb.mosi1;
      //data.miso1 <= intf.miso_neg_cb.miso1; 

    //task 3
    task po1_ph0(bit [7:0]mosi);
      data.mosi2 <= intf.mosi_neg_cb.mosi2;
      //data.miso2 <= intf.miso_pos_cb.miso2; 
 
    //task 4 
    task po1_ph1(bit [7:0]mosi);
      data.mosi3 <= intf.mosi_neg_cb.mosi3;
      //data.miso3 <= intf.miso_neg_cb.miso3

    initial begin
    $display("Master Monitor BFM");
    end

endmodule: master_monitor_bfm

>>>>>>> 966a5b0eb70ad0a709d68f63396f50824679929f
