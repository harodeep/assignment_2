# Set target libraries
set target_library /home/synopsis/H_N_P_EDA/NangateOpenCellLibrary_fast.db
set synthetic_library /home/synopsis/H_N_P_EDA/dw_foundation.sldb
set link_library "* $target_library $synthetic_library"

# # Set report directory
 set reports_dir /home/synopsis/H_N_P_EDA/Reports_barrel_shft
#
# # Set file names for the output netlists
 set synthesized_verilog_file $reports_dir/mac_syn_lib.sv
 set flattened_verilog_file $reports_dir/mac_syn_flat_lib.sv

# Analyze the Verilog source files
analyze -format verilog /home/synopsis/H_N_P_EDA/optimized_barrel.v

# Elaborate the design
elaborate barrel_shifter
current_design barrel_shifter
link
uniquify

# Set timing constraints
#create_clock -period 1 [get_ports {clk}]
# set_clock_uncertainty 0 [all_clocks]
# set_dont_touch_network [all_clocks]
#
# # Set maximum delay constraints
# set_max_delay 1.0 -to [all_outputs]
# set_max_delay 1.0 -from [remove_from_collection [all_inputs] [get_ports {clk_i}]] -to [all_registers -data_pins]
#
# # Set the maximum fanout limit to 64 for all nets
# set_max_fanout 64 [all_nets]

check_design -multiple_designs
compile

# Check design for consistency


gui_start

# # Write the synthesized netlist with hierarchy
write -f verilog -hierarchy -o $synthesized_verilog_file
#
# # Generate reports
 report_timing -nosplit > $reports_dir/timing.log
 report_area > $reports_dir/area.log
 report_power -analysis_effort high -hier > $reports_dir/powerheir.log
 report_power -analysis_effort high > $reports_dir/power.log
#
# # Flatten the design and write the flattened netlist
 ungroup -all -flatten
 write -f verilog -o $flattened_verilog_file
#
# # Report power at the cell level
 report_power -cell > $reports_dir/powercell.log
#
# # Generate switching activity information file (SAIF)
 write_saif -output $reports_dir/ckt1.saif -propagated
#
# # Exit the Design Compiler
# exit
