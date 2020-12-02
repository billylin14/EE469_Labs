onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /CameronCPU_testbench/clk
add wave -noupdate /CameronCPU_testbench/reset
add wave -noupdate -radix unsigned /CameronCPU_testbench/dut/ifStage/pc/PCout
add wave -noupdate -radix decimal /CameronCPU_testbench/dut/rfStage/imm12
add wave -noupdate -expand -group ALUout -radix unsigned /CameronCPU_testbench/dut/ALUoutRF
add wave -noupdate -expand -group ALUout -radix unsigned /CameronCPU_testbench/dut/ALUoutEX
add wave -noupdate -expand -group ALUout -radix unsigned /CameronCPU_testbench/dut/ALUoutMEM
add wave -noupdate -expand -group ALUout -radix unsigned /CameronCPU_testbench/dut/ALUoutWB
add wave -noupdate -expand -group Da -radix unsigned /CameronCPU_testbench/dut/DaRF
add wave -noupdate -expand -group Da -radix unsigned /CameronCPU_testbench/dut/DaEX
add wave -noupdate -expand -group Da -radix unsigned /CameronCPU_testbench/dut/DaMEM
add wave -noupdate -expand -group Da -radix unsigned /CameronCPU_testbench/dut/DaWB
add wave -noupdate -expand -group ALUin -radix unsigned /CameronCPU_testbench/dut/ALUinRF
add wave -noupdate -expand -group ALUin -radix unsigned /CameronCPU_testbench/dut/ALUinEX
add wave -noupdate -expand -group ALUin -radix unsigned /CameronCPU_testbench/dut/ALUinMEM
add wave -noupdate -expand -group ALUin -radix unsigned /CameronCPU_testbench/dut/ALUinWB
add wave -noupdate -expand -group Dw -radix unsigned /CameronCPU_testbench/dut/DwRF
add wave -noupdate -expand -group Dw -radix unsigned /CameronCPU_testbench/dut/DwEX
add wave -noupdate -expand -group Dw -radix unsigned /CameronCPU_testbench/dut/DwMEM
add wave -noupdate -expand -group Dw -radix unsigned /CameronCPU_testbench/dut/DwWB
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {281992 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 173
configure wave -valuecolwidth 78
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
WaveRestoreZoom {0 ps} {1338752 ps}
