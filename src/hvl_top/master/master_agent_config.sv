`ifndef MASTER_AGENT_CONFIG_INCLUDED_
`define MASTER_AGENT_CONFIG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: master_agent_config
// Used as the configuration class for master agent, for configuring number of slaves and number
// of active passive agents to be created
//--------------------------------------------------------------------------------------------
class master_agent_config extends uvm_object;
  `uvm_object_utils(master_agent_config)

  // Variable: is_active
  // Used for creating the agent in either passive or active mode
  uvm_active_passive_enum is_active=UVM_ACTIVE;  

  // Variable: no_of_slaves
  // Used for specifying the number of slaves connected to 
  // this master over SPI interface
  int no_of_slaves;

  // Variable: spi_mode 
  // Used for setting the opeartion mode 
  rand operation_modes_e spi_mode;

  // Variable: shift_dir
  // Shifts the data, LSB first or MSB first
  rand shift_direction_e shift_dir;

  // Variable: c2tdelay
  // Delay between CS assertion to clock generation
  // Used for setting the setup time 
  // Default value is 1
  //int c2tdelay = 1;
  rand int c2tdelay;

  // Variable: t2cdelay
  // Delay between end of clock to CS de-assertion
  // Used for setting the hold time 
  // Default value is 1
  //int t2cdelay = 1;
  rand int t2cdelay;

  // Variable: wdelay
  // Delay between the transfers 
  // Used for setting the time required between 2 transfers 
  // in terms of SCLK 
  // Default value is 1
  //int wdelay = 1;
  rand int wdelay;
  
  // Variable: primary_prescalar
  // Used for setting the primary prescalar value for baudrate_divisor
  rand protected bit[2:0] primary_prescalar;

  // Variable: secondary_prescalar
  // Used for setting the secondary prescalar value for baudrate_divisor
  rand protected bit[2:0] secondary_prescalar;

  // Variable: baudrate_divisor_divisor
  // Defines the date rate 
  //
  // baudrate_divisor_divisor = (secondary_prescalar+1) * (2 ** (primary_prescalar+1))
  // baudrate = busclock / baudrate_divisor_divisor;
  //
  // Default value is 2
  protected int baudrate_divisor;

  // Variable: has_coverage
  // Used for enabling the master agent coverage
  bit has_coverage;

  //spi_type_e enum declared in global pakage for simple,dual,quad 
  spi_type_e spi_type;

  constraint c2t_c{c2tdelay dist {[1:10]:=94, [11:$]:/6};}
  constraint t2c_c{t2cdelay dist {[1:10]:=94, [11:$]:/6};}
  constraint wdely_c{wdelay dist {[1:10]:=98, [11:$]:/2};}
  constraint delay_c{ c2tdelay>0; 
                      t2cdelay>0;
                      wdelay>0;
                    }
  constraint primary_prescalar_c{primary_prescalar dist {[0:1]:=80,[2:7]:/20};}
  constraint secondary_prescalar_c{secondary_prescalar dist {[0:1]:=80,[2:7]:/20};}

  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "master_agent_config");
  extern function void do_print(uvm_printer printer);
  extern function void set_baudrate_divisor(int primary_prescalar, int secondary_prescalar);
  extern function int get_baudrate_divisor();
  extern function void post_randomize();
endclass : master_agent_config

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - master_agent_config
//--------------------------------------------------------------------------------------------
function master_agent_config::new(string name = "master_agent_config");
  super.new(name);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: do_print method
// Print method can be added to display the data members values
//--------------------------------------------------------------------------------------------
function void master_agent_config::do_print(uvm_printer printer);
  super.do_print(printer);


  printer.print_string ("is_active",is_active.name());
  printer.print_field ("no_of_slaves",no_of_slaves,$bits(no_of_slaves), UVM_DEC);
  printer.print_string ("spi_mode",spi_mode.name());
  printer.print_string ("shift_dir",shift_dir.name());
  printer.print_field ("c2tdelay",c2tdelay, $bits(c2tdelay), UVM_DEC);
  printer.print_field ("t2cdelay",t2cdelay, $bits(t2cdelay), UVM_DEC);
  printer.print_field ("wdelay",wdelay, $bits(wdelay), UVM_DEC);
  printer.print_field ("primary_prescalar",primary_prescalar, 3, UVM_DEC);
  printer.print_field ("secondary_prescalar",secondary_prescalar, 3, UVM_DEC);
  printer.print_field ("baudrate_divisor",baudrate_divisor, 32, UVM_DEC);
  printer.print_field ("has_coverage",has_coverage, 1, UVM_DEC);
  printer.print_string ("spi_type",spi_type.name());
  
endfunction : do_print

//--------------------------------------------------------------------------------------------
// Function: set_baudrate_divisor
// Sets the baudrate divisor value from primary_prescalar and secondary_prescalar

// baudrate_divisor_divisor = (secondary_prescalar+1) * (2 ** (primary_prescalar+1))
// baudrate = busclock / baudrate_divisor_divisor;
//
// Parameters:
//  primary_prescalar - Primary prescalar value for baudrate calculation
//  secondary_prescalar - Secondary prescalar value for baudrate calculation
//--------------------------------------------------------------------------------------------
function void master_agent_config::set_baudrate_divisor(int primary_prescalar, int secondary_prescalar);
  this.primary_prescalar = primary_prescalar;
  this.secondary_prescalar = secondary_prescalar;

  baudrate_divisor = (this.secondary_prescalar + 1) * (2 ** (this.primary_prescalar + 1));

endfunction : set_baudrate_divisor

function void master_agent_config::post_randomize();
  set_baudrate_divisor(this.primary_prescalar,this.secondary_prescalar);
endfunction: post_randomize

function int master_agent_config::get_baudrate_divisor();
  return(this.baudrate_divisor);
endfunction: get_baudrate_divisor

`endif

