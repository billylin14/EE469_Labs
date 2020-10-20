transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/USER/Desktop/UW/courses/20\ AU/EE\ 469/EE469_Labs/Lab1 {C:/Users/USER/Desktop/UW/courses/20 AU/EE 469/EE469_Labs/Lab1/register.sv}
vlog -sv -work work +incdir+C:/Users/USER/Desktop/UW/courses/20\ AU/EE\ 469/EE469_Labs/Lab1 {C:/Users/USER/Desktop/UW/courses/20 AU/EE 469/EE469_Labs/Lab1/decoder2x4.sv}
vlog -sv -work work +incdir+C:/Users/USER/Desktop/UW/courses/20\ AU/EE\ 469/EE469_Labs/Lab1 {C:/Users/USER/Desktop/UW/courses/20 AU/EE 469/EE469_Labs/Lab1/decoder3x8.sv}
vlog -sv -work work +incdir+C:/Users/USER/Desktop/UW/courses/20\ AU/EE\ 469/EE469_Labs/Lab1 {C:/Users/USER/Desktop/UW/courses/20 AU/EE 469/EE469_Labs/Lab1/decoder1x2.sv}
vlog -sv -work work +incdir+C:/Users/USER/Desktop/UW/courses/20\ AU/EE\ 469/EE469_Labs/Lab1 {C:/Users/USER/Desktop/UW/courses/20 AU/EE 469/EE469_Labs/Lab1/mux32x1.sv}
vlog -sv -work work +incdir+C:/Users/USER/Desktop/UW/courses/20\ AU/EE\ 469/EE469_Labs/Lab1 {C:/Users/USER/Desktop/UW/courses/20 AU/EE 469/EE469_Labs/Lab1/mux2x1.sv}
vlog -sv -work work +incdir+C:/Users/USER/Desktop/UW/courses/20\ AU/EE\ 469/EE469_Labs/Lab1 {C:/Users/USER/Desktop/UW/courses/20 AU/EE 469/EE469_Labs/Lab1/mux8x1.sv}
vlog -sv -work work +incdir+C:/Users/USER/Desktop/UW/courses/20\ AU/EE\ 469/EE469_Labs/Lab1 {C:/Users/USER/Desktop/UW/courses/20 AU/EE 469/EE469_Labs/Lab1/decoder5x32.sv}
vlog -sv -work work +incdir+C:/Users/USER/Desktop/UW/courses/20\ AU/EE\ 469/EE469_Labs/Lab1 {C:/Users/USER/Desktop/UW/courses/20 AU/EE 469/EE469_Labs/Lab1/regfile.sv}

