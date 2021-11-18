onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hdl_top/intf/pclk
add wave -noupdate /hdl_top/intf/areset
add wave -noupdate /hdl_top/intf/sclk
add wave -noupdate -color Yellow -subitemconfig {{/hdl_top/intf/cs[0]} {-color Yellow}} /hdl_top/intf/cs
add wave -noupdate -color Blue /hdl_top/intf/mosi0
add wave -noupdate -color Blue /hdl_top/intf/miso0
add wave -noupdate -expand /hdl_top/master_agent_bfm_h/master_drv_bfm_h/drive_msb_first_pos_edge/data_packet
add wave -noupdate -expand /hdl_top/master_agent_bfm_h/master_drv_bfm_h/drive_msb_first_pos_edge/cfg_pkt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {410 ns} 1} {{Cursor 2} {132 ns} 1} {{Cursor 3} {170 ns} 1} {{Cursor 4} {300 ns} 1}
quietly wave cursor active 4
configure wave -namecolwidth 198
configure wave -valuecolwidth 106
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {968 ns}
