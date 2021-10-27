//--------------------------------------------------------------------------------------------
// Inteface       : Slave Monitor BFM
// Description  : Connects the slave monitor bfm with the monitor proxy
// to call the tasks and functions from monitor bfm to monitor proxy
//--------------------------------------------------------------------------------------------
 
interface slave_monitor_bfm (input sclk,cs,mosi0,mosi1,mosi2,mosi3,miso0,miso1,miso2,miso3);
  //variable DATA_WIDTH
  //DATA_WIDTH of data_mosi and data_miso
  parameter  DATA_WIDTH=8;
  
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
//sampling happen on posedge clk and shifting happen in negedge clk
//considering the first bit as most significant bit
//--------------------------------------------------------------------------------------------
task mon_msb_first_pos();
  bit[DATA_WIDTH-1:0]data_miso;
  bit[DATA_WIDTH-1:0]data_mosi;
  bit[DATA_WIDTH-1:0]count;
  if(!cs)begin
  @(posedge sclk);
  data_mosi = data_mosi << 1;
  data_mosi[count]=mosi0;
  @(negedge sclk);
  data_miso = data_miso << 1;
  data_miso[count]=miso0;
  count++;
end
s_mon_proxy_h.read(data_mosi,data_miso,count);

endtask : mon_msb_first_pos

//--------------------------------------------------------------------------------------------
//Task : mon_msb_first
//sampling happen in negedge clk and shifting happen in posedge clk
//considering the first bit as most significant bit
//--------------------------------------------------------------------------------------------
task mon_msb_first_neg();
  bit[DATA_WIDTH-1:0]data_miso;
  bit[DATA_WIDTH-1:0]data_mosi;
  bit[DATA_WIDTH-1:0]count;
  if(!cs)begin
  @(negedge sclk);
  data_mosi = data_mosi << 1;
  data_mosi[count]=mosi0;
  @(posedge sclk);
  data_miso = data_miso << 1;
  data_miso[count]=miso0;
  count++;
end
s_mon_proxy_h.read(data_mosi,data_miso,count);
  

endtask : mon_msb_first_neg

//--------------------------------------------------------------------------------------------
//Task : mon_lsb_first
//sampling happen in posedge clk and shifting happen in negedge clk
//data tranfering first bit as least significant bit
//--------------------------------------------------------------------------------------------

task mon_lsb_first_pos();
  bit[DATA_WIDTH-1:0]data_miso;
  bit[DATA_WIDTH-1:0]data_mosi;
  bit[DATA_WIDTH-1:0]count;
  if(!cs)begin
  @(posedge sclk);
  data_mosi = data_mosi >>1;
  data_mosi[count]=mosi0;
  @(negedge sclk);
  data_miso = data_miso >> 1;
  data_miso[count]=miso0;
  count++;
end
s_mon_proxy_h.read(data_mosi,data_miso,count); 

endtask : mon_lsb_first_pos

//--------------------------------------------------------------------------------------------
//Task : mon_lsb_first
//sampling happen in negedge clk and shifting happen in posedge clk
//data tranfering first bit as least significant bit
//--------------------------------------------------------------------------------------------

task mon_lsb_first_neg();
  bit[DATA_WIDTH-1:0]data_miso;
  bit[DATA_WIDTH-1:0]data_mosi;
  bit[DATA_WIDTH-1:0]count;
  if(!cs)begin
  @(negedge sclk);
  data_mosi = data_mosi >> 1;
  data_mosi[count]=mosi0;
  @(posedge sclk);
  data_miso = data_miso >> 1;
  data_miso[count]=miso0;
  count++;
end
s_mon_proxy_h.read(data_mosi,data_miso,count); 
  
endtask : mon_lsb_first_neg


//--------------------------------------------------------------------------------------------
//Task  : sample_cpol_0_cpha_0 
//calling the mon_msb_first and mon_lsb_first tasks inside 
//to do the data sampling based on clock polarity and clock phase 
//--------------------------------------------------------------------------------------------

task sample_cpol_0_cpha_0 ();
  mon_msb_first_pos();
  mon_lsb_first_pos();
endtask : sample_cpol_0_cpha_0

//--------------------------------------------------------------------------------------------
//Task  : sample_cpol_0_cpha_1 
//calling the mon_msb_first and mon_lsb_first tasks inside 
//to do the data sampling based on clock polarity and clock phase 
//--------------------------------------------------------------------------------------------

task sample_cpol_0_cpha_1 ();
  mon_msb_first_neg();
  mon_lsb_first_neg();
endtask : sample_cpol_0_cpha_1

//--------------------------------------------------------------------------------------------
//Task  :sample_cpol_1_cpha_0 
//calling the mon_msb_first and mon_lsb_first tasks inside 
//to do the data sampling based on clock polarity and clock phase 
//--------------------------------------------------------------------------------------------

task sample_cpol_1_cpha_0 ();
  mon_msb_first_neg();
  mon_lsb_first_neg();
endtask : sample_cpol_1_cpha_0 

//--------------------------------------------------------------------------------------------
//Task  : sample_cpol_1_cpha_1
//calling the mon_msb_first and mon_lsb_first tasks inside 
//to do the data sampling based on clock polarity and clock phase 
//--------------------------------------------------------------------------------------------

task sample_cpol_1_cpha_1 ();
  mon_msb_first_pos();
  mon_msb_first_pos();
endtask : sample_cpol_1_cpha_1 

endinterface : slave_monitor_bfm


