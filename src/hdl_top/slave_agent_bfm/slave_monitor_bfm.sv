//--------------------------------------------------------------------------------------------
// Inteface       : Slave Monitor BFM
// Description  : Connects the slave monitor bfm with the monitor proxy
// to call the tasks and functions from monitor bfm to monitor proxy
//--------------------------------------------------------------------------------------------
 
interface slave_monitor_bfm (spi_if.MON_MP intf);
  //variable DATA_WIDTH
  //DATA_WIDTH of data_mosi
  parameter DATA_WIDTH=8;
  
  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import spi_slave_pkg::slave_monitor_proxy;
  slave_monitor_proxy mon_proxy;

  initial begin
    $display("Slave Monitor BFM");
  end

   //variable data_mosi
   //data of master-out slave-in
   bit[7:0]data_mosi;

//--------------------------------------------------------------------------------------------
//Task : mon_msb_first
//loop is used to iterate the data
//considering the first bit as most significant bit
//--------------------------------------------------------------------------------------------
task mon_msb_first(bit mosi);
  for(int i=DATA_WIDTH-1;i>0;i--) begin
    @(intf.sample_mosi_pos_cb);
    data_mosi = data_mosi << 1;
    data_mosi[i]=intf.sample_mosi_pos_cb.mosi0;
    data_mosi[i] = mosi;
  end
  // mon_proxy.write(data_mosi);

endtask : mon_msb_first
//--------------------------------------------------------------------------------------------
//Task : mon_lsb_first
//loop is used to iterate the data
//data tranfering first bit as least significant bit
//--------------------------------------------------------------------------------------------

task mon_lsb_first(bit mosi);
  //mosi = 1;
  for(int i=0;i<DATA_WIDTH;i++) begin
    @(intf.sample_mosi_pos_cb);
    data_mosi = data_mosi << 1;
    data_mosi[i]=intf.sample_mosi_pos_cb.mosi0;
    data_mosi[i] = mosi;
  end
  // mon_proxy.write(data_mosi);

endtask : mon_lsb_first

//--------------------------------------------------------------------------------------------
//Task  : sample_mosi_pos_00
//assigning the sampled_mosi_neg_cb signal to proxy mosi
//sampling happen on the posedge
//calling the mon_msb_first and mon_lsb_first tasks inside 
//to do the data sampling based on clock polarity and clock phase 
//--------------------------------------------------------------------------------------------

task sample_mosi_pos_00 (bit mosi);
  if(!intf.cs) begin
    @(intf.sample_mosi_pos_cb)
    mosi=intf.sample_mosi_pos_cb.mosi0;
    mon_msb_first(mosi);
    //  mon_lsb_first(mosi);
  end
endtask : sample_mosi_pos_00

//--------------------------------------------------------------------------------------------
//Task  : sample_mosi_neg_01
//assigning the sampled_mosi_neg_cb signal to proxy mosi
//sampling happen on the negedge
//calling the mon_msb_first and mon_lsb_first tasks inside 
//to do the data sampling based on clock polarity and clock phase 
//--------------------------------------------------------------------------------------------

task sample_mosi_neg_01 (bit mosi);
  if(!intf.cs)begin
  @(intf.sample_mosi_neg_cb)
  mosi=intf.sample_mosi_neg_cb.mosi0;
  mon_msb_first(mosi);
  mon_lsb_first(mosi);
end
endtask : sample_mosi_neg_01

//--------------------------------------------------------------------------------------------
//Task  :sample_mosi_pos_10
//assigning the sample_mosi_pos_cb signal to proxy mosi
//sampling happen on the posedge
//calling the mon_msb_first and mon_lsb_first tasks inside 
//to do the data sampling based on clock polarity and clock phase 
//--------------------------------------------------------------------------------------------

task sample_mosi_pos_10 (bit mosi);
  if(!intf.cs)begin
  @(intf.sample_mosi_pos_cb)
  mosi=intf.sample_mosi_pos_cb.mosi0;
  mon_msb_first(mosi);
  mon_lsb_first(mosi);
end
endtask : sample_mosi_pos_10

//--------------------------------------------------------------------------------------------
////Task  : sample_mosi_neg_11
//assigning the sample_mosi_pos_cb.miso signal to proxy mosi
//sampling happens on the negedge
//calling the mon_msb_first and mon_lsb_first tasks inside 
//to do the data sampling based on clock polarity and clock phase 
//--------------------------------------------------------------------------------------------

task sample_mosi_neg_11 (bit mosi);
  if(!intf.cs)begin
  @(intf.sample_mosi_neg_cb)
  mosi=intf.sample_mosi_neg_cb.mosi0;
  mon_msb_first(mosi);
  mon_lsb_first(mosi);
end
endtask : sample_mosi_neg_11

endinterface : slave_monitor_bfm


