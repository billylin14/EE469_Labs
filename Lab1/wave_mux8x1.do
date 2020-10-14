onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mux8x1_testbench/clk
add wave -noupdate /mux8x1_testbench/selector
add wave -noupdate /mux8x1_testbench/in
add wave -noupdate /mux8x1_testbench/out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8367 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 192
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {89250 ps}
