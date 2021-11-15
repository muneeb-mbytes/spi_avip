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
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "spi_scoreboard", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);
  extern virtual task run_phase(uvm_phase phase);
  //extern virtual function void report_phase(uvm_phase phase);
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

  // MSHA: super.run_phase(phase);

  // MSHA: forever begin
  // MSHA:   `uvm_info(get_type_name(),$sformatf("before calling analysis fifo get method"),UVM_LOW)
  // MSHA:   master_analysis_fifo.get(master_tx_h);
  // MSHA:   // TODO(mshariff): Keep a track on master transaction
  // MSHA:   `uvm_info(get_type_name(),$sformatf("after calling analysis fifo get method"),UVM_LOW) 
  // MSHA:   `uvm_info(get_ype_name(),$sformatf("printing master_tx_h, \n %s",master_tx_h.sprint()),UVM_LOW)

  // MSHA:   slave_analysis_fifo .get(slave_tx_h);
  // MSHA:   // TODO(mshariff): Keep a track on slave transaction
  // MSHA:   `uvm_info(get_type_name(),$sformatf("after calling analysis fifo get method"),UVM_LOW) 
  // MSHA:   `uvm_info(get_ype_name(),$sformatf("printing slave_tx_h, \n %s",slave_tx_h.sprint()),UVM_LOW)
  // MSHA:   Displpay even the SLave id - it must be in the packet 
  //

  // MSHA:   // TODO(mshariff): 
  // MSHA:   // Once you get the transcations, do the comparisio per byte basis
  // MSHA:   // Master MOSI with Slave MISO and
  // MSHA:   // SLave MISO with Master MOSI
  // MSHA:   // Also, no_of_mosi_bits and no_of_miso_bits


  // MSHA:   // TODO(mshariff): After comparisions, keep a track of the sno of comparisions done
  // MSHA: end

endtask : run_phase

//--------------------------------------------------------------------------------------------
// Function: check_phase
// Display the result of simulation
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
//function void spi_scoreboard::check_phase(uvm_phase phase);
//  super.check_phase(phase);
// TODO(mshariff): Check the following:
// 1. Check if the comparisions counter is NON-zero
//    A non-zero value indicates that the comparisions never happened and throw error
// 2. Check if master packets received are same as slave packets received
//    To Make sure that we have equal number of master and slave packets
// 3. Analyis fifos must be zero - This wil indicate that all the packets have been compared
//    This is to make sure that we have taken al packets from both FIFOs and made the comparisions
//endfunction : check_phase

//--------------------------------------------------------------------------------------------
// Function: report_phase
// Display the result of simulation
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
//function void spi_scoreboard::report_phase(uvm_phase phase);
//  super.report_phase(phase);
//  `uvm_info("scoreboard",$sformatf("")
//  // TODO(mshariff): Print the below items:
//  Total number of packets received from the Master
//  Total number of packets received from the Slave (with their ID)
//  Number of comparisions done
//  Number of comparisios passed
//  Number of compariosn failed
//endfunction : report_phase

`endif

