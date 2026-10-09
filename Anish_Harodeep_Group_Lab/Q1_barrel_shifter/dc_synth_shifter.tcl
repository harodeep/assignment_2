# ==============================================================================
# Synopsys Design Compiler - Q1: 4-Bit Barrel Shifter
# Path: /home/synopsis/Anish_Harodeep_Group_Lab/Q1_barrel_shifter/dc_synth_shifter.tcl
# ==============================================================================

# Set target libraries
set target_library    /home/synopsis/Anish_Harodeep_Group_Lab/NangateOpenCellLibrary_fast.db
set synthetic_library /home/synopsis/Anish_Harodeep_Group_Lab/dw_foundation.sldb
set link_library      [concat "*" $target_library $synthetic_library]

# Set working directory (flat structure)
set reports_dir /home/synopsis/Anish_Harodeep_Group_Lab/Q1_barrel_shifter

# Set output netlist file names
set synthesized_verilog_file $reports_dir/barrel_shifter_syn.v
set flattened_verilog_file   $reports_dir/barrel_shifter_flat.v

# Analyze and elaborate design
analyze -format verilog $reports_dir/barrel_shifter_4bit.v
elaborate barrel_shifter_4bit
current_design barrel_shifter_4bit
link
uniquify

# Timing & Optimization Constraints (Pure Combinational)
# Virtual clock for I/O budgeting
create_clock -name vclk -period 1.0
set_input_delay  0.1 -clock vclk [all_inputs]
set_output_delay 0.1 -clock vclk [all_outputs]

# 1.a: Optimize for minimal critical path delay
set_max_delay 0.8 -from [all_inputs] -to [all_outputs]

# 1.b: Synthesis for minimum gate count / area
set_max_area 0
set_max_fanout 64 [all_nets]

# Design checks & synthesis compilation
check_design -multiple_designs
compile -map_effort high -area_effort high

# Optional GUI Launch (uncomment if inspecting in Design Vision)
# gui_start

# Write synthesized netlist with hierarchy
write -f verilog -hierarchy -o $synthesized_verilog_file

# Generate Reports
report_timing -nosplit > $reports_dir/timing.log
report_area > $reports_dir/area.log
report_cell > $reports_dir/cells.log
report_power -analysis_effort high -hier > $reports_dir/powerheir.log
report_power -analysis_effort high > $reports_dir/power.log

# Flatten the design and write flattened netlist
ungroup -all -flatten
write -f verilog -o $flattened_verilog_file

# Report power at cell level and generate SAIF
report_power -cell > $reports_dir/powercell.log
write_saif -output $reports_dir/barrel_shifter.saif -propagated

exit