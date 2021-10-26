`ifndef SPI_SCOREBOARD_INCLUDED_
`define SPI_SCOREBOARD_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: spi_scoreboard
// <Description_here>
//--------------------------------------------------------------------------------------------
class spi_scoreboard extends uvm_scoreboard;
 `uvm_component_utils(spi_scoreboard)

 //-------------------------------------------------------
 // Externally defined Tasks and Functions
 //-------------------------------------------------------
 extern function new(string name = "spi_scoreboard", uvm_component parent = null);
 extern virtual function void build_phase(uvm_phase phase);
 //extern virtual function void connect_phase(uvm_phase phase);
 //extern virtual function void end_of_elaboration_phase(uvm_phase phase);
 //extern virtual function void start_of_simulation_phase(uvm_phase phase);
 //extern virtual task run_phase(uvm_phase phase);

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
endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
//function void spi_scoreboard::connect_phase(uvm_phase phase);
//  super.connect_phase(phase);
//endfunction : connect_phase

//--------------------------------------------------------------------------------------------
// Function: end_of_elaboration_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
//function void spi_scoreboard::end_of_elaboration_phase(uvm_phase phase);
//  super.end_of_elaboration_phase(phase);
//endfunction  : end_of_elaboration_phase

//--------------------------------------------------------------------------------------------
// Function: start_of_simulation_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
//function void spi_scoreboard::start_of_simulation_phase(uvm_phase phase);
//  super.start_of_simulation_phase(phase);
//endfunction : start_of_simulation_phase

//--------------------------------------------------------------------------------------------
// Task: run_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
//task spi_scoreboard::run_phase(uvm_phase phase);
//
//  phase.raise_objection(this, "spi_scoreboard");
//
//  super.run_phase(phase);
//
//  // Work here
//  // ...
//
//  phase.drop_objection(this);
//
//endtask : run_phase

`endif

