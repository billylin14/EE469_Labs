onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /fullAdder64bit_testbench/clk
add wave -noupdate -radix decimal /fullAdder64bit_testbench/A
add wave -noupdate -radix decimal /fullAdder64bit_testbench/B
add wave -noupdate -radix decimal /fullAdder64bit_testbench/result
add wave -noupdate /fullAdder64bit_testbench/sel
add wave -noupdate /fullAdder64bit_testbench/cin
add wave -noupdate /fullAdder64bit_testbench/overflow
add wave -noupdate /fullAdder64bit_testbench/negative
add wave -noupdate /fullAdder64bit_testbench/zero
add wave -noupdate /fullAdder64bit_testbench/carryout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {99750 ps}
