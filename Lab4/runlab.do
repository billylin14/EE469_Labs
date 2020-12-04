# Create work library
vlib work

# Compile Verilog
#     All Verilog files that are part of this design should have
#     their own "vlog" line below.
vlog "./register.sv"
vlog "./regfile.sv"
vlog "./mux32x1.sv"
vlog "./mux8x1.sv"
vlog "./mux2x1.sv"
vlog "./decoder5x32.sv"
vlog "./decoder1x2.sv"
vlog "./decoder2x4.sv"
vlog "./decoder3x8.sv"
vlog "./xorOp.sv"
vlog "./orOp.sv"
vlog "./norGate64x1.sv"
vlog "./fullAdder64bit.sv"
vlog "./fullAdder.sv"
vlog "./andOp.sv"
vlog "./alustim.sv"
vlog "./instructmem.sv"
vlog "./datamem.sv"
vlog "./pc.sv"
vlog "./se.sv"
vlog "./datapath.sv"
vlog "./PCIncrementor.sv"
vlog "./instrDecoder.sv"
vlog "./leftShift.sv"
vlog "./CameronCPU.sv"
vlog "./dff_real.sv"
vlog "./IF_stage.sv"
vlog "./RF_stage.sv"
vlog "./EX_stage.sv"
vlog "./MEM_stage.sv"
vlog "./WB_stage.sv"
vlog "./mux4x1.sv"
vlog "./pipeline_registers.sv"
vlog "./forwardingUnit.sv"

# Call vsim to invoke simulator
#     Make sure the last item on the line is the name of the
#     testbench module you want to execute.
vsim -voptargs="+acc" -t 1ps -lib work CameronCPU_testbench

# Source the wave do file
#     This should be the file that sets up the signal window for
#     the module you are testing.
do wave_test12.do

# Set the window types
view wave
view structure
view signals

# Run the simulation
run -all

# End
