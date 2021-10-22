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

// Enum: shift_direction_e
// 
// Specifies the shift direction
//
// LSB_FIRST - LSB is shifted out first
// MSB_FIRST - MSB is shifted out first

typedef enum {
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

typedef enum {
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

typedef enum {
  SIMPLE_SPI = 2'd1,
  DUAL_SPI   = 2'd2,
  QUAD_SPI   = 2'd4
} spi_type_e;

endpackage: spi_globals_pkg

`endif
