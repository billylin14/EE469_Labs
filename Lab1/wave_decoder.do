onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /decoder_testbench/regWrite
add wave -noupdate /decoder_testbench/clk
add wave -noupdate -radix decimal /decoder_testbench/writeRegister
add wave -noupdate -radix binary -childformat {{{/decoder_testbench/regEnable[30]} -radix binary} {{/decoder_testbench/regEnable[29]} -radix binary} {{/decoder_testbench/regEnable[28]} -radix binary} {{/decoder_testbench/regEnable[27]} -radix binary} {{/decoder_testbench/regEnable[26]} -radix binary} {{/decoder_testbench/regEnable[25]} -radix binary} {{/decoder_testbench/regEnable[24]} -radix binary} {{/decoder_testbench/regEnable[23]} -radix binary} {{/decoder_testbench/regEnable[22]} -radix binary} {{/decoder_testbench/regEnable[21]} -radix binary} {{/decoder_testbench/regEnable[20]} -radix binary} {{/decoder_testbench/regEnable[19]} -radix binary} {{/decoder_testbench/regEnable[18]} -radix binary} {{/decoder_testbench/regEnable[17]} -radix binary} {{/decoder_testbench/regEnable[16]} -radix binary} {{/decoder_testbench/regEnable[15]} -radix binary} {{/decoder_testbench/regEnable[14]} -radix binary} {{/decoder_testbench/regEnable[13]} -radix binary} {{/decoder_testbench/regEnable[12]} -radix binary} {{/decoder_testbench/regEnable[11]} -radix binary} {{/decoder_testbench/regEnable[10]} -radix binary} {{/decoder_testbench/regEnable[9]} -radix binary} {{/decoder_testbench/regEnable[8]} -radix binary} {{/decoder_testbench/regEnable[7]} -radix binary} {{/decoder_testbench/regEnable[6]} -radix binary} {{/decoder_testbench/regEnable[5]} -radix binary} {{/decoder_testbench/regEnable[4]} -radix binary} {{/decoder_testbench/regEnable[3]} -radix binary} {{/decoder_testbench/regEnable[2]} -radix binary} {{/decoder_testbench/regEnable[1]} -radix binary} {{/decoder_testbench/regEnable[0]} -radix binary}} -expand -subitemconfig {{/decoder_testbench/regEnable[30]} {-radix binary} {/decoder_testbench/regEnable[29]} {-radix binary} {/decoder_testbench/regEnable[28]} {-radix binary} {/decoder_testbench/regEnable[27]} {-radix binary} {/decoder_testbench/regEnable[26]} {-radix binary} {/decoder_testbench/regEnable[25]} {-radix binary} {/decoder_testbench/regEnable[24]} {-radix binary} {/decoder_testbench/regEnable[23]} {-radix binary} {/decoder_testbench/regEnable[22]} {-radix binary} {/decoder_testbench/regEnable[21]} {-radix binary} {/decoder_testbench/regEnable[20]} {-radix binary} {/decoder_testbench/regEnable[19]} {-radix binary} {/decoder_testbench/regEnable[18]} {-radix binary} {/decoder_testbench/regEnable[17]} {-radix binary} {/decoder_testbench/regEnable[16]} {-radix binary} {/decoder_testbench/regEnable[15]} {-radix binary} {/decoder_testbench/regEnable[14]} {-radix binary} {/decoder_testbench/regEnable[13]} {-radix binary} {/decoder_testbench/regEnable[12]} {-radix binary} {/decoder_testbench/regEnable[11]} {-radix binary} {/decoder_testbench/regEnable[10]} {-radix binary} {/decoder_testbench/regEnable[9]} {-radix binary} {/decoder_testbench/regEnable[8]} {-radix binary} {/decoder_testbench/regEnable[7]} {-radix binary} {/decoder_testbench/regEnable[6]} {-radix binary} {/decoder_testbench/regEnable[5]} {-radix binary} {/decoder_testbench/regEnable[4]} {-radix binary} {/decoder_testbench/regEnable[3]} {-radix binary} {/decoder_testbench/regEnable[2]} {-radix binary} {/decoder_testbench/regEnable[1]} {-radix binary} {/decoder_testbench/regEnable[0]} {-radix binary}} /decoder_testbench/regEnable
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {84 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 218
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
WaveRestoreZoom {0 ps} {898 ps}
