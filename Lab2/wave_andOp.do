onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /andOp_testbench/clk
add wave -noupdate /andOp_testbench/A
add wave -noupdate /andOp_testbench/B
add wave -noupdate -radix unsigned /andOp_testbench/result
add wave -noupdate /andOp_testbench/negative
add wave -noupdate /andOp_testbench/zero
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2695 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 125
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {3675 ps}
