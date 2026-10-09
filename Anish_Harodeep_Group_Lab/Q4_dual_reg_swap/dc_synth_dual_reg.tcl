# ==============================================================================
# Synopsys Design Compiler - Q4: Dual 8-Bit Registers (Freeze & Swap)
# Path: /home/synopsis/Anish_Harodeep_Group_Lab/Q4_dual_reg_swap/dc_synth_dual_reg.tcl
# ==============================================================================

# Set target libraries
set target_library    /home/synopsis/Anish_Harodeep_Group_Lab/NangateOpenCellLibrary_fast.db
set synthetic_library /home/synopsis/Anish_Harodeep_Group_Lab/dw_foundation.sldb
set link_library      [concat "*" $target_library $synthetic_library]

# Set working directory (flat structure)
set reports_dir /home/synopsis/Anish_Harodeep_Group_Lab/Q4_dual_reg_swap

# Set output netlist file names
set synthesized_verilog_file $reports_dir/dual_reg_syn.v
set flattened_verilog_file   $reports_dir/dual_reg_flat.v

# Analyze and elaborate design
analyze -format verilog $reports_dir/dual_reg_swap.v
elaborate dual_reg_swap
current_design dual_reg_swap
link
uniquify

# Timing Constraints (1 GHz target / 1 ns clock period)
create_clock -period 1.0 [get_ports {clk}]
set_clock_uncertainty 0.05 [all_clocks]
set_dont_touch_network [all_clocks]

set_input_delay  0.2 -clock clk [remove_from_collection [all_inputs] [get_ports {clk}]]
set_output_delay 0.2 -clock clk [all_outputs]
set_max_fanout 64 [all_nets]

# Design checks & synthesis compilation
check_design -multiple_designs
compile

# Optional GUI Launch
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
write_saif -output $reports_dir/dual_reg.saif -propagated

exit