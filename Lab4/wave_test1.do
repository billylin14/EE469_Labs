onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /CameronCPU_testbench/clk
add wave -noupdate /CameronCPU_testbench/reset

TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {97951 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 173
configure wave -valuecolwidth 200
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 50
configure wave -gridperiod 100
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {165764 ps}
