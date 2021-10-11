//-------------------------------------------------------
//Initiating the top module
//-------------------------------------------------------
  module hvl_top;

    import test_pkg::*;
    import uvm_pkg::*;

    bit reset;
    bit clock;

  //-------------------------------------------------------
  // Generating Clock
  //-------------------------------------------------------
    always
    begin
      #10 clock=1;
      #10 clock=0;    
    end

//-------------------------------------------------------
// Here the interface name is spi_i
//-------------------------------------------------------

    spi_if in0(clock);
//-------------------------------------------------------
//Setting interface in database with visibility to all lower components
//-------------------------------------------------------
    initial 
    begin
      uvm_config_db#(virtual spi_if)::set(null,"*","vif",in0);
      run_test();
    end
  endmodule
