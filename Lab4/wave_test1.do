onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /CameronCPU_testbench/clk
add wave -noupdate /CameronCPU_testbench/reset
add wave -noupdate -radix unsigned /CameronCPU_testbench/dut/ifStage/pc/PCout
add wave -noupdate -radix decimal /CameronCPU_testbench/dut/rfStage/imm12
add wave -noupdate -expand -group {IF outputs} -radix unsigned /CameronCPU_testbench/dut/ifStage/Rd
add wave -noupdate -expand -group {IF outputs} -radix unsigned /CameronCPU_testbench/dut/ifStage/Rm
add wave -noupdate -expand -group {IF outputs} -radix unsigned /CameronCPU_testbench/dut/ifStage/Rn
add wave -noupdate -expand -group {RF outputs} -radix unsigned /CameronCPU_testbench/dut/DaRF
add wave -noupdate -expand -group {RF outputs} -radix unsigned /CameronCPU_testbench/dut/ALUinRF
add wave -noupdate -radix decimal /CameronCPU_testbench/dut/rfStage/Da
add wave -noupdate -expand -group {EX outputs} -radix decimal /CameronCPU_testbench/dut/rfStage/ALUoutEX
add wave -noupdate -expand -group {EX outputs} -radix unsigned /CameronCPU_testbench/dut/exStage/ALUout
add wave -noupdate -expand -group {WB outputs} -radix unsigned /CameronCPU_testbench/dut/wbStage/Dw
add wave -noupdate -expand -group Forwarding -radix unsigned /CameronCPU_testbench/dut/rfStage/Rm
add wave -noupdate -expand -group Forwarding -radix unsigned /CameronCPU_testbench/dut/rfStage/Rd
add wave -noupdate -expand -group Forwarding -radix unsigned /CameronCPU_testbench/dut/rfStage/forward/AaRF
add wave -noupdate -expand -group Forwarding -radix unsigned /CameronCPU_testbench/dut/rfStage/forward/AbRF
add wave -noupdate -expand -group Forwarding -radix unsigned /CameronCPU_testbench/dut/rfStage/forward/AwEX
add wave -noupdate -expand -group Forwarding -radix unsigned /CameronCPU_testbench/dut/rfStage/forward/AwMEM
add wave -noupdate -expand -group Forwarding -radix unsigned /CameronCPU_testbench/dut/rfStage/forward/DaSEL
add wave -noupdate -expand -group Forwarding -radix unsigned /CameronCPU_testbench/dut/rfStage/forward/DbSEL
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {239501 ps} 0}
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
WaveRestoreZoom {0 ps} {2677500 ps}
