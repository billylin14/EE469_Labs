# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./register.sv"
vlog "./decoder5x32.sv"
vlog "./decoder1x2.sv"
vlog "./decoder2x4.sv"
vlog "./decoder3x8.sv"
vlog "./mux32x1.sv"
vlog "./mux8x1.sv"
vlog "./mux2x1.sv"
vlog "./regfile.sv"
vlog "./regstim.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work regstim

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do wave_regstim.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
