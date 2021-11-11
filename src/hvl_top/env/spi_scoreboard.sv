`ifndef SPI_SCOREBOARD_INCLUDED_
`define SPI_SCOREBOARD_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: spi_scoreboard
// Scoreboard the data getting from monitor port that goes into the implementation port
//--------------------------------------------------------------------------------------------
class spi_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(spi_scoreboard)
  
  //Variable : master_tx_h
  //declaring master transaction handle
  master_tx master_tx_h;
  
  //Variable : slave_tx_h
  //declaring slave transaction handle
  slave_tx slave_tx_h;
  
  //Variable : env_cfg_h
  //declaring env config handle
  env_config env_cfg_h;

  //Variable : master_analysis_fifo
  //declaring analysis fifo
  uvm_tlm_analysis_fifo#(master_tx)master_analysis_fifo;
 
  //Variable : slave_analysis_fifo
  //declaring analysis fifo
  uvm_tlm_analysis_fifo#(slave_tx)slave_analysis_fifo;
  
  //Variable master_tx_count
  //to keep track of number of transaction for master spi
  int master_tx_count = 0;


  //Variable slave_tx_count
  //to keep track of number of transaction for slave spi
  int slave_tx_count = 0;


  //Variable data_cmp_verified_count
  //to keep track of number of compared verified data
  int data_cmp_verified_count = 0;

  //Variable data_cmp_failed_count
  //to keep track of number of compared failed data
  int data_cmp_failed_count = 0;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_scoreboard", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  extern virtual function void check_phase (uvm_phase phase);
  extern virtual function void report_phase(uvm_phase phase);
endclass : spi_scoreboard

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - spi_scoreboard
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function spi_scoreboard::new(string name = "spi_scoreboard", uvm_component parent = null);
  super.new(name, parent);
  //master_analysis_fifo = new("master_analysis_fifo",this);
  //slave_analysis_fifo = new("slave_analysis_fifo",this);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void spi_scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);

  master_analysis_fifo = new("master_analysis_fifo",this);
  slave_analysis_fifo = new("slave_analysis_fifo",this);
  
  master_tx_h = new("master_tx_h");
  slave_tx_h = new("slave_tx_h");
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void spi_scoreboard::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// All the comparision are done
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
task spi_scoreboard::run_phase(uvm_phase phase);

 super.run_phase(phase);

 forever begin
 
 `uvm_info(get_type_name(),$sformatf("before calling analysis fifo get method"),UVM_HIGH)
 master_analysis_fifo.get(master_tx_h);
 // TODO(mshariff): Keep a track on master transaction
 master_tx_count++;
 
 `uvm_info(get_type_name(),$sformatf("after calling analysis fifo get method"),UVM_HIGH) 
 `uvm_info(get_type_name(),$sformatf("printing master_tx_h, \n %s",master_tx_h.sprint()),UVM_HIGH)

 slave_analysis_fifo .get(slave_tx_h);
 // TODO(mshariff): Keep a track on slave transaction
 slave_tx_count++;
 
 `uvm_info(get_type_name(),$sformatf("after calling analysis fifo get method"),UVM_HIGH) 
 `uvm_info(get_type_name(),$sformatf("printing slave_tx_h, \n %s",slave_tx_h.sprint()),UVM_HIGH)
 
 // MSHA:   Displpay even the SLave id - it must be in the packet 
 
 // MSHA:   // TODO(mshariff): 
 // MSHA:   // Once you get the transcations, do the comparision per byte basis
 // MSHA:   // Master MOSI with Slave MISO and
 // MSHA:   // SLave MISO with Master MOSI
 // MSHA:   // Also, no_of_mosi_bits and no_of_miso_bits
  
 if (master_tx_h.master_out_slave_in == slave_tx_h.master_in_slave_out)begin 
 //if (master_tx_h.mosi0 == slave_tx_h.miso0)begin 
  `uvm_info (get_type_name(), $sformatf ("data0 comparision is successfull"),UVM_HIGH);
  data_cmp_verified_count++;
 end   
 else begin
   `uvm_error (get_type_name(),$sformatf( "data0 comparision failed"));
    data_cmp_failed_count++;
  end

//  if (master_tx_h.master_out_slave_in1 == slave_tx_h.master_in_slave_out1)begin
//    `uvm_info (get_type_name(), $sformatf ("data1 comparision is successfull"),UVM_HIGH);
//    data_cmp_verified_count++;
//  end
//  else begin
//    `uvm_error (get_type_name(),$sformatf ( "data1 comparision failed"));
//    data_cmp_failed_count++;
//  end
//
//  if (master_tx_h.master_out_slave_in2 == slave_tx_h.master_in_slave_out2)begin 
//    `uvm_info (get_type_name(), $sformatf ("data2 comparision is successfull"),UVM_HIGH);
//    data_cmp_verified_count++;
//  end
//  else begin
//    `uvm_error (get_type_name(),$sformatf( "data2 comparision failed"));
//    data_cmp_failed_count++;
//  end
//   
//  if (master_tx_h.master_out_slave_in3 == slave_tx_h. master_in_slave_out3) begin
//    `uvm_info (get_type_name(), $sformatf ("data3 comparision is successfull"),UVM_HIGH);
//     data_cmp_verified_count++;
//  end
//  else begin
//    `uvm_error (get_type_name(),$sformatf( "data3 comparision failed"));
//    data_cmp_failed_count++;
//  end

  if (slave_tx_h.master_in_slave_out == master_tx_h.master_out_slave_in) begin
  // if (slave_tx_h.miso == master_tx_h.mosi ) begin
    `uvm_info (get_type_name(), $sformatf ("data0 comparision is successfull"),UVM_HIGH);
    data_cmp_verified_count++;
  end
  else begin
    `uvm_error (get_type_name(),$sformatf( "data0 comparision failed"));
    data_cmp_failed_count++;
  
  end
  
// if (slave_tx_h.master_in_slave_out1 == master_tx_h.master_out_slave_in1) begin
//    `uvm_info (get_type_name(), $sformatf ("data1 comparision is successfull"),UVM_HIGH);
//    data_cmp_verified_count++;
//  end
//  else begin
//    `uvm_error (get_type_name(),$sformatf( "data1 comparision failed"));
//    data_cmp_failed_count++;
//  end
//
//  if (slave_tx_h.master_in_slave_out2 == master_tx_h.master_out_slave_in2) begin 
//    `uvm_info (get_type_name(), $sformatf ("data2 comparision is successfull"),UVM_HIGH);
//    data_cmp_verified_count++;
//  end
//  else begin
//    `uvm_error (get_type_name(),$sformatf( "data2 comparision failed"));
//     data_cmp_failed_count++;
//  end 
//  if (slave_tx_h.master_in_slave_out3 == master_tx_h.master_out_slave_in3) begin
//    `uvm_info (get_type_name(), $sformatf ("data3 comparision is successfull"),UVM_HIGH);
//    data_cmp_verified_count++;
//  end 
//  else begin
//    `uvm_error (get_type_name(),$sformatf( "data3 comparision failed"));
//    data_cmp_failed_count++;
//  end
  
// Done this part in report phase
// MSHA:   // TODO(mshariff): After comparisions, keep a track of the sno of comparisions done
  end

endtask : run_phase

//--------------------------------------------------------------------------------------------
// Function: check_phase
// Display the result of simulation
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void spi_scoreboard::check_phase(uvm_phase phase);
  super.check_phase(phase);

// TODO(mshariff): Check the following:
// 1. Check if the comparisions counter is NON-zero
//    A non-zero value indicates that the comparisions never happened and throw error

  if (data_cmp_verified_count != 0 ) begin
    `uvm_info (get_type_name(), $sformatf ("data_cmp_verified_count : %0d",data_cmp_verified_count),UVM_HIGH);
    `uvm_info (get_type_name(), $sformatf ("comparisions happened"),UVM_HIGH);
  end
  else if (data_cmp_failed_count == 0) begin
    `uvm_info (get_type_name(), $sformatf ("data_cmp_failed_count : %0d", data_cmp_failed_count),UVM_HIGH);
    `uvm_info (get_type_name(), $sformatf ("all comparisions are succesful"),UVM_HIGH);
  end
  else begin
    `uvm_error (get_type_name(), $sformatf ("comparisions not happened"));
  end

// 2. Check if master packets received are same as slave packets received
//    To Make sure that we have equal number of master and slave packets
 
  if (master_tx_count == slave_tx_count ) begin
    `uvm_info (get_type_name(), $sformatf ("master_tx_count : %0d",master_tx_count ),UVM_HIGH);
    `uvm_info (get_type_name(), $sformatf ("slave_tx_count : %0d",slave_tx_count ),UVM_HIGH);
    `uvm_info (get_type_name(), $sformatf ("master and slave have equal no. of packets"),UVM_HIGH);
  end
  else begin
    `uvm_error (get_type_name(), $sformatf ("master and slave does have same no. of packets"));
  end 


// 3. Analyis fifos must be zero - This will indicate that all the packets have been compared
//    This is to make sure that we have taken all packets from both FIFOs and made the comparisions
  if ((master_analysis_fifo && slave_analysis_fifo) == 0)begin
    `uvm_info (get_type_name(), $sformatf ("all packets are compared"),UVM_HIGH);
  end
  else begin
    `uvm_error (get_type_name(),$sformatf( "all packets are not compared "));
  end
endfunction : check_phase

//--------------------------------------------------------------------------------------------
// Function: report_phase
// Display the result of simulation
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
function void spi_scoreboard::report_phase(uvm_phase phase);
  super.report_phase(phase);
  `uvm_info("scoreboard",$sformatf("Scoreboard Report"),UVM_HIGH);
  
  // TODO(mshariff): Print the below items:
  
  // Total number of packets received from the Master
  `uvm_info (get_type_name(),$sformatf("No. of packects received from master: %0d",master_tx_count),UVM_HIGH);

  //Total number of packets received from the Slave (with their ID)
  `uvm_info (get_type_name(),$sformatf("No. of packects received from slave: %0d", slave_tx_count),UVM_HIGH);
  
  //Number of comparisions done
  `uvm_info (get_type_name(),$sformatf("Total no. of packects compared %0d",
                 data_cmp_verified_count+data_cmp_failed_count),UVM_HIGH);

  //Number of comparisios passed
  `uvm_info (get_type_name(),$sformatf("No. of packects successfully compared %0d",
                data_cmp_verified_count),UVM_HIGH);

  //Number of compariosn failed
  `uvm_info (get_type_name(),$sformatf("No. of packects failed to compare %0d",
                data_cmp_failed_count),UVM_HIGH);

endfunction : report_phase

`endif

