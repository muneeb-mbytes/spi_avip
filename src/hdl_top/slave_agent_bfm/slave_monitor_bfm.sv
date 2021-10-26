//--------------------------------------------------------------------------------------------
// Inteface       : Slave Monitor BFM
// Description  : Connects the slave monitor bfm with the monitor proxy
// to call the tasks and functions from monitor bfm to monitor proxy
//--------------------------------------------------------------------------------------------
 
interface slave_monitor_bfm (spi_if intf);
  //variable DATA_WIDTH
  //DATA_WIDTH of data_mosi
  parameter DATA_WIDTH=8;
  
  //-------------------------------------------------------
  // Creating the handle for proxy driver
  //-------------------------------------------------------
  import spi_slave_pkg::slave_monitor_proxy;
  slave_monitor_proxy s_mon_proxy_h;

  initial begin
    $display("Slave Monitor BFM");
  end

//--------------------------------------------------------------------------------------------
//Task : mon_msb_first
//loop is used to iterate the data
//considering the first bit as most significant bit
//--------------------------------------------------------------------------------------------
task mon_msb_first_pos(bit mosi);
  bit[7:0]data_mosi;
  for(int i=DATA_WIDTH-1;i>0;i--) begin
    @(posedge intf.sclk);
    data_mosi = data_mosi << 1;
    data_mosi[i]=intf.mosi0;
    data_mosi[i] = mosi;
  end
  s_mon_proxy_h.read(data_mosi);

endtask : mon_msb_first_pos

//--------------------------------------------------------------------------------------------
//Task : mon_msb_first
//loop is used to iterate the data
//considering the first bit as most significant bit
//--------------------------------------------------------------------------------------------
task mon_msb_first_neg(bit mosi);
  bit[7:0]data_mosi;
  for(int i=DATA_WIDTH-1;i>0;i--) begin
    @(negedge intf.sclk);
    data_mosi = data_mosi << 1;
    data_mosi[i]=intf.mosi0;
    data_mosi[i] = mosi;
  end
  s_mon_proxy_h.read(data_mosi);

endtask : mon_msb_first_neg

//--------------------------------------------------------------------------------------------
//Task : mon_lsb_first
//loop is used to iterate the data
//data tranfering first bit as least significant bit
//--------------------------------------------------------------------------------------------

task mon_lsb_first_pos(bit mosi);
  bit[7:0]data_mosi;
  for(int i=0;i<DATA_WIDTH;i++) begin
    @(posedge intf.sclk)
    data_mosi = data_mosi << 1;
    data_mosi[i]=intf.mosi0;
    data_mosi[i] = mosi;
  end
  s_mon_proxy_h.read(data_mosi);

endtask : mon_lsb_first_pos

//--------------------------------------------------------------------------------------------
//Task : mon_lsb_first
//loop is used to iterate the data
//data tranfering first bit as least significant bit
//--------------------------------------------------------------------------------------------

task mon_lsb_first_neg(bit mosi);
  bit[7:0]data_mosi;
  for(int i=0;i<DATA_WIDTH;i++) begin
    @(negedge intf.sclk)
    data_mosi = data_mosi << 1;
    data_mosi[i]=intf.mosi0;
    data_mosi[i] = mosi;
  end
  s_mon_proxy_h.read(data_mosi);

endtask : mon_lsb_first_neg


//--------------------------------------------------------------------------------------------
//Task  : sample_cpol_0_cpha_0 
//assigning the sampled_mosi_neg_cb signal to proxy mosi
//sampling happen on the posedge
//calling the mon_msb_first and mon_lsb_first tasks inside 
//to do the data sampling based on clock polarity and clock phase 
//--------------------------------------------------------------------------------------------

task sample_cpol_0_cpha_0 (bit mosi);
  if(!intf.cs) begin
    @(posedge intf.sclk)
    mosi=intf.mosi0;
    mon_msb_first_pos(mosi);
    //mon_msb_first_neg(mosi);
    mon_lsb_first_pos(mosi);
   // mon_msb_first_neg(mosi);
  
  end
endtask : sample_cpol_0_cpha_0

//--------------------------------------------------------------------------------------------
//Task  : sample_cpol_0_cpha_1 
//assigning the sampled_mosi_neg_cb signal to proxy mosi
//sampling happen on the negedge
//calling the mon_msb_first and mon_lsb_first tasks inside 
//to do the data sampling based on clock polarity and clock phase 
//--------------------------------------------------------------------------------------------

task sample_cpol_0_cpha_1 (bit mosi);
  if(!intf.cs)begin
  @(negedge intf.sclk)
  mosi=intf.mosi0;
  // mon_msb_first_pos(mosi);
   mon_msb_first_neg(mosi);
 //  mon_lsb_first_pos(mosi);
   mon_msb_first_neg(mosi);

end
endtask : sample_cpol_0_cpha_1

//--------------------------------------------------------------------------------------------
//Task  :sample_cpol_1_cpha_0 
//assigning the sample_mosi_pos_cb signal to proxy mosi
//sampling happen on the posedge
//calling the mon_msb_first and mon_lsb_first tasks inside 
//to do the data sampling based on clock polarity and clock phase 
//--------------------------------------------------------------------------------------------

task sample_cpol_1_cpha_0 (bit mosi);
  if(!intf.cs)begin
  @(posedge intf.sclk)
  mosi=intf.mosi0;
  mon_msb_first_pos(mosi);
 // mon_msb_first_neg(mosi);
  mon_lsb_first_pos(mosi);
 // mon_msb_first_neg(mosi);
end
endtask : sample_cpol_1_cpha_0 

//--------------------------------------------------------------------------------------------
////Task  : sample_cpol_1_cpha_1
//assigning the sample_mosi_pos_cb.miso signal to proxy mosi
//sampling happens on the negedge
//calling the mon_msb_first and mon_lsb_first tasks inside 
//to do the data sampling based on clock polarity and clock phase 
//--------------------------------------------------------------------------------------------

task sample_cpol_1_cpha_1 (bit mosi);
  if(!intf.cs)begin
  @(negedge intf.sclk)
  mosi=intf.mosi0;
 // mon_msb_first_pos(mosi);
 // mon_lsb_first_pos(mosi);
  mon_msb_first_neg(mosi);
  mon_msb_first_neg(mosi);

end
endtask : sample_cpol_1_cpha_1 

endinterface : slave_monitor_bfm


