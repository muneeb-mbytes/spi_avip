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
