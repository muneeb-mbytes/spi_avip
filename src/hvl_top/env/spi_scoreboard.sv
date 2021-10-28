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
  //extern virtual task run_phase(uvm_phase phase);
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
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
/*task spi_scoreboard::run_phase(uvm_phase phase);
  phase.raise_objection(this, "spi_scoreboard");

  super.run_phase(phase);

  `uvm_info(get_type_name(),$sformatf("before calling analysis fifo get method"),UVM_LOW)
  master_analysis_fifo.get(master_tx_h);
  slave_analysis_fifo .get(slave_tx_h);

  `uvm_info(get_type_name(),$sformatf("after calling analysis fifo get method"),UVM_LOW) 
    `uvm_info(get_ype_name(),$sformatf("printing master_tx_h, \n %s",master_tx_h.sprint()),UVM_LOW
  phase.drop_objection(this);

endtask : run_phase*/

//--------------------------------------------------------------------------------------------
// Function: check_phase
// Display the result of simulation
//
// Parameters:
// phase - uvm phase
//--------------------------------------------------------------------------------------------
//function void spi_scoreboard::check_phase(uvm_phase phase);
//  super.check_phase(phase);
//  `uvm_info("scoreboard",$sformatf("")  
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
  
//endfunction : report_phase

`endif

