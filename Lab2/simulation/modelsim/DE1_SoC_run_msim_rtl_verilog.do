transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/USER/Desktop/UW/courses/20\ AU/EE\ 469/EE469_Labs/Lab2 {C:/Users/USER/Desktop/UW/courses/20 AU/EE 469/EE469_Labs/Lab2/fullAdder.sv}
vlog -sv -work work +incdir+C:/Users/USER/Desktop/UW/courses/20\ AU/EE\ 469/EE469_Labs/Lab2 {C:/Users/USER/Desktop/UW/courses/20 AU/EE 469/EE469_Labs/Lab2/fullAdder64bit.sv}

