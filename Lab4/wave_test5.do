onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /CameronCPU_testbench/clk
add wave -noupdate -radix unsigned /CameronCPU_testbench/reset
add wave -noupdate -radix unsigned /CameronCPU_testbench/dut/ifStage/pc/PCout
add wave -noupdate -radix unsigned /CameronCPU_testbench/dut/ifStage/PCRF
add wave -noupdate /CameronCPU_testbench/dut/ifStage/BrTaken
add wave -noupdate -expand -group {IF outputs} -radix decimal /CameronCPU_testbench/dut/ifStage/BrAddr26
add wave -noupdate -expand -group {IF outputs} -radix unsigned /CameronCPU_testbench/dut/ifStage/Rd
add wave -noupdate -expand -group {IF outputs} -radix unsigned /CameronCPU_testbench/dut/ifStage/Rm
add wave -noupdate -expand -group {IF outputs} -radix unsigned /CameronCPU_testbench/dut/ifStage/Rn
add wave -noupdate -expand -group {IF outputs} -radix unsigned /CameronCPU_testbench/dut/ifStage/imm12
add wave -noupdate -expand -group {RF outputs} -radix unsigned /CameronCPU_testbench/dut/rfStage/Rn
add wave -noupdate -expand -group {RF outputs} /CameronCPU_testbench/dut/rfStage/registers/ReadData1
add wave -noupdate -expand -group {RF outputs} -radix unsigned /CameronCPU_testbench/dut/rfStage/Da
add wave -noupdate -expand -group {RF outputs} -radix unsigned /CameronCPU_testbench/dut/rfStage/imm12
add wave -noupdate -expand -group {RF outputs} -radix unsigned /CameronCPU_testbench/dut/rfStage/ALUin
add wave -noupdate -expand -group {RF outputs} -radix unsigned /CameronCPU_testbench/dut/DaRF
add wave -noupdate -expand -group {RF outputs} -radix unsigned /CameronCPU_testbench/dut/ALUinRF
add wave -noupdate /CameronCPU_testbench/dut/RF2EX/insetFlag
add wave -noupdate /CameronCPU_testbench/dut/RF2EX/outsetFlag
add wave -noupdate /CameronCPU_testbench/dut/exStage/setFlag
add wave -noupdate /CameronCPU_testbench/dut/setFlagEX
add wave -noupdate -group {EX outputs} -radix unsigned /CameronCPU_testbench/dut/exStage/Da
add wave -noupdate -group {EX outputs} -radix unsigned /CameronCPU_testbench/dut/exStage/Db
add wave -noupdate -group {EX outputs} -radix unsigned /CameronCPU_testbench/dut/exStage/ALUout
add wave -noupdate /CameronCPU_testbench/dut/exStage/flags
add wave -noupdate /CameronCPU_testbench/dut/exStage/carry_out
add wave -noupdate /CameronCPU_testbench/dut/exStage/overflow
add wave -noupdate /CameronCPU_testbench/dut/exStage/zero
add wave -noupdate /CameronCPU_testbench/dut/exStage/negative
add wave -noupdate -group {MEM outputs} -radix unsigned /CameronCPU_testbench/dut/memStage/ALUout
add wave -noupdate -group {MEM outputs} -radix unsigned /CameronCPU_testbench/dut/memStage/wrBout
add wave -noupdate -group {WB outputs} -radix unsigned /CameronCPU_testbench/dut/rfStage/RegWrite
add wave -noupdate -group {WB outputs} -radix unsigned /CameronCPU_testbench/dut/rfStage/AwWB
add wave -noupdate -group {WB outputs} -radix unsigned /CameronCPU_testbench/dut/wbStage/wrBout
add wave -noupdate -group {WB outputs} /CameronCPU_testbench/dut/wbStage/MOVsel
add wave -noupdate -group {WB outputs} -radix unsigned -childformat {{{/CameronCPU_testbench/dut/wbStage/Dw[63]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[62]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[61]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[60]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[59]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[58]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[57]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[56]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[55]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[54]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[53]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[52]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[51]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[50]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[49]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[48]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[47]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[46]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[45]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[44]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[43]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[42]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[41]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[40]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[39]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[38]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[37]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[36]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[35]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[34]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[33]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[32]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[31]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[30]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[29]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[28]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[27]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[26]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[25]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[24]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[23]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[22]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[21]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[20]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[19]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[18]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[17]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[16]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[15]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[14]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[13]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[12]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[11]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[10]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[9]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[8]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[7]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[6]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[5]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[4]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[3]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[2]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[1]} -radix unsigned} {{/CameronCPU_testbench/dut/wbStage/Dw[0]} -radix unsigned}} -subitemconfig {{/CameronCPU_testbench/dut/wbStage/Dw[63]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[62]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[61]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[60]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[59]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[58]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[57]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[56]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[55]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[54]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[53]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[52]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[51]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[50]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[49]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[48]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[47]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[46]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[45]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[44]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[43]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[42]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[41]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[40]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[39]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[38]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[37]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[36]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[35]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[34]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[33]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[32]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[31]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[30]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[29]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[28]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[27]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[26]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[25]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[24]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[23]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[22]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[21]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[20]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[19]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[18]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[17]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[16]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[15]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[14]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[13]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[12]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[11]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[10]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[9]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[8]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[7]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[6]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[5]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[4]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[3]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[2]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[1]} {-height 15 -radix unsigned} {/CameronCPU_testbench/dut/wbStage/Dw[0]} {-height 15 -radix unsigned}} /CameronCPU_testbench/dut/wbStage/Dw
add wave -noupdate -group Forwarding -radix unsigned /CameronCPU_testbench/dut/rfStage/Rd
add wave -noupdate -group Forwarding -radix unsigned /CameronCPU_testbench/dut/rfStage/forward/AaRF
add wave -noupdate -group Forwarding -radix unsigned /CameronCPU_testbench/dut/rfStage/forward/AwEX
add wave -noupdate -group Forwarding -radix unsigned /CameronCPU_testbench/dut/rfStage/forward/AwMEM
add wave -noupdate -group Forwarding -radix unsigned /CameronCPU_testbench/dut/rfStage/forward/DaSEL
add wave -noupdate -group Forwarding -radix unsigned /CameronCPU_testbench/dut/rfStage/forward/DbSEL
add wave -noupdate -radix unsigned -childformat {{{/CameronCPU_testbench/dut/rfStage/registers/regData[31]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[30]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[29]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[28]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[27]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[26]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[25]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[24]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[23]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[22]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[21]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[20]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[19]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[18]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[17]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[16]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[15]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[14]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[13]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[12]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[11]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[10]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[9]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[8]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[7]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[6]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[5]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[4]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[3]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[2]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[1]} -radix decimal} {{/CameronCPU_testbench/dut/rfStage/registers/regData[0]} -radix decimal}} -subitemconfig {{/CameronCPU_testbench/dut/rfStage/registers/regData[31]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[30]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[29]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[28]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[27]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[26]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[25]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[24]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[23]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[22]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[21]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[20]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[19]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[18]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[17]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[16]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[15]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[14]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[13]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[12]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[11]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[10]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[9]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[8]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[7]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[6]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[5]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[4]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[3]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[2]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[1]} {-height 15 -radix decimal} {/CameronCPU_testbench/dut/rfStage/registers/regData[0]} {-height 15 -radix decimal}} /CameronCPU_testbench/dut/rfStage/registers/regData
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {993744 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 170
configure wave -valuecolwidth 59
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
WaveRestoreZoom {796250 ps} {1259006 ps}
