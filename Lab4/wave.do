onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /BillyCPU_testbench/clk
add wave -noupdate /BillyCPU_testbench/reset
add wave -noupdate /BillyCPU_testbench/dut/pc/instructionMemory/instruction
add wave -noupdate -expand /BillyCPU_testbench/dut/instrDec/Rn
add wave -noupdate /BillyCPU_testbench/dut/instrDec/Rm
add wave -noupdate /BillyCPU_testbench/dut/instrDec/Rd
add wave -noupdate /BillyCPU_testbench/dut/dataP/Dw
add wave -noupdate -expand -group {Control Signals} /BillyCPU_testbench/dut/instrDec/UncondBr
add wave -noupdate -expand -group {Control Signals} /BillyCPU_testbench/dut/instrDec/BrTaken
add wave -noupdate -expand -group {Control Signals} /BillyCPU_testbench/dut/instrDec/RegWrite
add wave -noupdate -expand -group {Control Signals} /BillyCPU_testbench/dut/instrDec/Reg2Loc
add wave -noupdate -expand -group {Control Signals} /BillyCPU_testbench/dut/instrDec/MemWrite
add wave -noupdate -expand -group {Control Signals} /BillyCPU_testbench/dut/instrDec/MemToReg
add wave -noupdate -expand -group {Control Signals} /BillyCPU_testbench/dut/instrDec/wrByte
add wave -noupdate -expand -group {Control Signals} /BillyCPU_testbench/dut/instrDec/immSel
add wave -noupdate -expand -group {Control Signals} /BillyCPU_testbench/dut/instrDec/shiftSel
add wave -noupdate -expand -group {Control Signals} /BillyCPU_testbench/dut/instrDec/ALUsrc
add wave -noupdate -expand -group {Control Signals} /BillyCPU_testbench/dut/instrDec/ALUop
add wave -noupdate -expand -group {Control Signals} /BillyCPU_testbench/dut/instrDec/KZsel
add wave -noupdate -expand -group {Control Signals} /BillyCPU_testbench/dut/instrDec/MOVsel
add wave -noupdate /BillyCPU_testbench/dut/instrDec/imm12
add wave -noupdate /BillyCPU_testbench/dut/instrDec/imm16
add wave -noupdate /BillyCPU_testbench/dut/instrDec/DAddr9
add wave -noupdate /BillyCPU_testbench/dut/instrDec/CondAddr19
add wave -noupdate /BillyCPU_testbench/dut/instrDec/BrAddr26
add wave -noupdate /BillyCPU_testbench/dut/instrDec/SHAMT
add wave -noupdate /BillyCPU_testbench/dut/instrDec/LDURBsel
add wave -noupdate -expand -group Flags /BillyCPU_testbench/dut/dataP/zero
add wave -noupdate -expand -group Flags /BillyCPU_testbench/dut/dataP/negative
add wave -noupdate -expand -group Flags /BillyCPU_testbench/dut/dataP/overflow
add wave -noupdate -expand -group Flags /BillyCPU_testbench/dut/dataP/carry_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {98520 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 204
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
WaveRestoreZoom {0 ps} {87005 ps}
