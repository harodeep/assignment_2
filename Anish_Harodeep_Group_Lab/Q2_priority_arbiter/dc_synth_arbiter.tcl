# ==============================================================================
# Synopsys Design Compiler - Q2: 4-Input Priority Arbiter
# Path: /home/synopsis/Anish_Harodeep_Group_Lab/Q2_priority_arbiter/dc_synth_arbiter.tcl
# ==============================================================================

# Set target libraries
set target_library    /home/synopsis/Anish_Harodeep_Group_Lab/NangateOpenCellLibrary_fast.db
set synthetic_library /home/synopsis/Anish_Harodeep_Group_Lab/dw_foundation.sldb
set link_library      [concat "*" $target_library $synthetic_library]

# Set working directory (flat structure)
set reports_dir /home/synopsis/Anish_Harodeep_Group_Lab/Q2_priority_arbiter

# Set output netlist file names
set synthesized_verilog_file $reports_dir/arbiter_syn.v
set flattened_verilog_file   $reports_dir/arbiter_flat.v

# Analyze and elaborate design
analyze -format verilog $reports_dir/priority_arbiter_4.v
elaborate priority_arbiter_4
current_design priority_arbiter_4
link
uniquify

# Timing Constraints (1 GHz target / 1 ns clock period)
create_clock -period 1.0 [get_ports {clk}]
set_clock_uncertainty 0.05 [all_clocks]
set_dont_touch_network [all_clocks]

set_input_delay  0.2 -clock clk [remove_from_collection [all_inputs] [get_ports {clk}]]
set_output_delay 0.2 -clock clk [all_outputs]

# Gate count minimization (< 20 logic gates)
set_max_area 0
set_max_fanout 64 [all_nets]

# Design checks & synthesis compilation
check_design -multiple_designs
compile -map_effort high

# Optional GUI Launch
# gui_start

# Write synthesized netlist with hierarchy
write -f verilog -hierarchy -o $synthesized_verilog_file

# Generate Reports
report_timing -nosplit > $reports_dir/timing.log
report_area > $reports_dir/area.log
report_cell > $reports_dir/cells.log
report_reference > $reports_dir/gate_count_reference.log
report_power -analysis_effort high -hier > $reports_dir/powerheir.log
report_power -analysis_effort high > $reports_dir/power.log

# Flatten the design and write flattened netlist
ungroup -all -flatten
write -f verilog -o $flattened_verilog_file

# Report power at cell level and generate SAIF
report_power -cell > $reports_dir/powercell.log
write_saif -output $reports_dir/arbiter.saif -propagated

exit