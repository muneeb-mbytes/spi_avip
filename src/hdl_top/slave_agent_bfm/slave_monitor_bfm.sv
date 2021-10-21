//--------------------------------------------------------------------------------------------
// Inteface       : Slave Monitor BFM
// Description  : Connects the slave monitor bfm with the monitor proxy
// to call the tasks and functions from monitor bfm to monitor proxy
//--------------------------------------------------------------------------------------------
 
interface slave_monitor_bfm (spi_if.MON_MP intf);
  
  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import spi_slave_pkg::slave_monitor_proxy;
  slave_monitor_proxy mon_proxy;

  initial begin
    $display("Slave Monitor BFM");
  end

//--------------------------------------------------------------------------------------------
//Task  : sample_mosi_pos_00
//assigning the sample_mosi_pos_cb to proxy mosi
//sampling happen on the posedge
//--------------------------------------------------------------------------------------------

task sample_mosi_pos_00 (bit mosi,bit miso, bit cs, bit [2:0]all);
  @(intf.sample_mosi_pos_cb)
  mosi=intf.sample_mosi_pos_cb.mosi0;
  mosi =1;
  miso =1;
  cs = 1;
  all = {mosi,miso,cs};
endtask : sample_mosi_pos_00

//--------------------------------------------------------------------------------------------
//Task  : sample_mosi_neg_01
//assigning the sampled_mosi_neg_cb signal to proxy mosi
//sampling happen on the negedge
//--------------------------------------------------------------------------------------------

task sample_mosi_neg_01 (bit mosi, bit miso, bit cs,bit [2:0]all);
  @(intf.sample_mosi_neg_cb)
  mosi=intf.sample_mosi_neg_cb.mosi0;
  mosi =1;
  miso =0;
  cs = 0;
  all = {mosi,miso,cs};
endtask : sample_mosi_neg_01
//--------------------------------------------------------------------------------------------
//Task  :sample_mosi_pos_10
//assigning the sample_mosi_pos_cb signal to proxy mosi
//sampling happen on the posedge
//--------------------------------------------------------------------------------------------

task sample_mosi_pos_10 (bit mosi, bit miso, bit cs,bit[2:0]all);
  @(intf.sample_mosi_pos_cb)
  mosi=intf.sample_mosi_pos_cb.mosi0;
  mosi =1;
  miso =1;
  cs = 0;
  all = {mosi,miso,cs};
endtask : sample_mosi_pos_10

//--------------------------------------------------------------------------------------------
////Task  : sample_mosi_neg_11
//assigning the sample_mosi_pos_cb.miso signal to proxy mosi
//sampling happens on the negedge
//--------------------------------------------------------------------------------------------

task sample_mosi_neg_11 (bit mosi, bit miso, bit cs, bit [2:0] all);
  @(intf.sample_mosi_neg_cb)
  mosi=intf.sample_mosi_neg_cb.mosi0;
  mosi =1;
  miso =0;
  cs = 1;
  all = {mosi,miso,cs};
endtask : sample_mosi_neg_11

endinterface : slave_monitor_bfm


