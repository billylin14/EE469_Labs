transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/wutzk/Desktop/EE469_Labs/Lab2 {C:/Users/wutzk/Desktop/EE469_Labs/Lab2/fullAdder.sv}
vlog -sv -work work +incdir+C:/Users/wutzk/Desktop/EE469_Labs/Lab2 {C:/Users/wutzk/Desktop/EE469_Labs/Lab2/fullAdder64bit.sv}
vlog -sv -work work +incdir+C:/Users/wutzk/Desktop/EE469_Labs/Lab2 {C:/Users/wutzk/Desktop/EE469_Labs/Lab2/norGate64x1.sv}

