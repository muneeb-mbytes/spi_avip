onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /hdl_top/intf/pclk
add wave -noupdate /hdl_top/intf/areset
add wave -noupdate /hdl_top/intf/sclk
add wave -noupdate /hdl_top/intf/cs
add wave -noupdate /hdl_top/intf/mosi0
add wave -noupdate /hdl_top/intf/mosi1
add wave -noupdate /hdl_top/intf/mosi2
add wave -noupdate /hdl_top/intf/mosi3
add wave -noupdate /hdl_top/intf/miso0
add wave -noupdate /hdl_top/intf/miso1
add wave -noupdate /hdl_top/intf/miso2
add wave -noupdate /hdl_top/intf/miso3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {346 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 198
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ns} {1941 ns}
