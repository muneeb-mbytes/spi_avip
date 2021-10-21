//-------------------------------------------------------
// master driver BFM
//-------------------------------------------------------

interface master_driver_bfm (spi_if intf);

virtual spi_if vif;

initial 
  begin
    $display("Master driver BFM");
  end
endinterface:master_driver_bfm
