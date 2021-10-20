`ifndef TEST_PKG_INCLUDED
`define TEST_PKG_INCLUDED

//-----------------------------------------------------------------------------------------
//Package: Test
//Description:
//Includes all the files written to run the simulation
//-------------------------------------------------------------------------------------------
  package test_pkg;

//-------------------------------------------------------
// Import uvm package
//-------------------------------------------------------
 `include "uvm_macros.svh"
  import uvm_pkg::*;

//-------------------------------------------------------
// Importing the required packages
//-------------------------------------------------------
  import spi_master_pkg::*;
  import spi_slave_pkg::*;
  import spi_env_pkg::*;

 //including _virtual_sequence which consists of master sequences                  
 `include "master_virtual_sequence.sv"
 //including base_test for testing
 `include "base_test.sv"

  endpackage :test_pkg
 `endif
