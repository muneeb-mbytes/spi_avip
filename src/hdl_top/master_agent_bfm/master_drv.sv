//-------------------------------------------------------
// master driver BFM
//-------------------------------------------------------

module master_drv(spi_if intf);

virtual spi_if vif;

initial 
  begin
    $display("Master driver BFM")
  end
endmodule
