`ifndef SPI_GLOBALS_PKG_INCLUDED_
`define SPI_GLOBALS_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: spi_globals_pkg
// Used for storing enums, parameters and defines
//--------------------------------------------------------------------------------------------
package spi_globals_pkg;

// Define: NO_OF_SLAVES
//
// Specifies the number of slaves connected over the SPI interface

parameter int NO_OF_SLAVES = 1;
  
parameter int DATA_WIDTH = 8;

//parameter SLAVE_DRIVER_ACTIVE = 0;

// Define: char_length
//
// Specifies the character length of the trasnfer

parameter int CHAR_LENGTH= 8;

// Define: depth_arry
//
// Specifies the depth of an array

//parameter int DEPTH_ARRY = 16;
// Define: NO_OF_ROWS
//
// Specifies the no of rows of an array

parameter int NO_OF_ROWS = 16;


// Enum: shift_direction_e
// 
// Specifies the shift direction
//
// LSB_FIRST - LSB is shifted out first
// MSB_FIRST - MSB is shifted out first

typedef enum bit {
  LSB_FIRST = 1'b0,
  MSB_FIRST = 1'b1
} shift_direction_e;

// Enum: operation_modes_e
//
// Specifies the operation moodes based on CPOL and CPHA
//
// CPOL0_CPHA0 - Polarity is 0 and Phase is 0
// CPOL0_CPHA1 - Polarity is 0 and Phase is 1
// CPOL1_CPHA0 - Polarity is 1 and Phase is 0
// CPOL1_CPHA1 - Polarity is 1 and Phase is 1

typedef enum bit[1:0] {
  CPOL0_CPHA0 = 2'b00,
  CPOL0_CPHA1 = 2'b01,
  CPOL1_CPHA0 = 2'b10,
  CPOL1_CPHA1 = 2'b11
} operation_modes_e;

// Enum: spi_type_e
//
// Specifies the type of SPI used
//
// SIMPLE_SPI - In this mosi0 and miso0 are used
// DUAL_SPI   - In this, mosi[1:0] and miso[1:0] are used
// QUAD_SPI   - In this, mosi[3:0] and miso[3:0] are used

typedef enum bit [2:0] {
  SIMPLE_SPI = 3'd1,
  DUAL_SPI   = 3'd2,
  QUAD_SPI   = 3'd4
} spi_type_e;

// struct: spi_transfer_char_s
//
// master_out_slave_in: array which holds the mosi seq_item transactions
// master_in_slave_out: array which holds the miso seq_item transactions
// cs : chip select
// no_of_mosi_bits_transfer: specifies how many mosi bits to trasnfer 
// no_of_miso_bits_transfer: specifies how many miso bits to trasnfer 
typedef struct {
  // mosi signals
  bit [NO_OF_SLAVES-1:0] cs;
  //bit [CHAR_LENGTH-1:0] master_out_slave_in[DEPTH_ARRY];
  bit [NO_OF_ROWS-1:0][CHAR_LENGTH-1:0] master_out_slave_in;
  int no_of_mosi_bits_transfer;
  
  //int c2t;
  //int t2c;
  //int baudrate;
  
  //miso signals
  //bit [CHAR_LENGTH-1:0] master_in_slave_out[DEPTH_ARRY];
  bit [NO_OF_ROWS-1:0][CHAR_LENGTH-1:0] master_in_slave_out;  
  int no_of_miso_bits_transfer;

} spi_transfer_char_s;
//struct: spi_transfer_cfg_s
//c2t : chip to transaction delay
//t2c : transaction to chip delay
//baudrate : specifies the speed of the transaction
//wdelay: delay between two tarnsactions
//cpol: clock polarity
//cpha: clock phase
typedef struct {
  
  int c2t;
  int t2c;
  int cpol;
  int cpha;
  int baudrate;
  int wdelay;

} spi_transfer_cfg_s;

endpackage: spi_globals_pkg

`endif
