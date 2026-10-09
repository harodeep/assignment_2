# VCS:

# Q1: 4-Bit Barrel Shifter
cd /home/synopsis/Anish_Harodeep_Group_Lab/Q1_barrel_shifter
vcs -full64 -sverilog barrel_shifter_4bit.v tb_barrel_shifter.v -debug_access+all -o simv && ./simv

# Q2: 4-Input Priority Arbiter
cd /home/synopsis/Anish_Harodeep_Group_Lab/Q2_priority_arbiter
vcs -full64 -sverilog priority_arbiter_4.v tb_priority_arbiter_4.v -debug_access+all -o simv && ./simv

# Q3: Glitch-Free Clock Gater
cd /home/synopsis/Anish_Harodeep_Group_Lab/Q3_clock_gater
vcs -full64 -sverilog clock_gater.v tb_clock_gater.v -debug_access+all -o simv && ./simv

# Q4: Dual 8-Bit Registers (Swap & Freeze)
cd /home/synopsis/Anish_Harodeep_Group_Lab/Q4_dual_reg_swap
vcs -full64 -sverilog dual_reg_swap.v tb_dual_reg_swap.v -debug_access+all -o simv && ./simv


# DC SHELL:

# Q1: 4-Bit Barrel Shifter
cd /home/synopsis/Anish_Harodeep_Group_Lab/Q1_barrel_shifter
dc_shell -f dc_synth_shifter.tcl | tee dc_shifter.log

# Q2: 4-Input Priority Arbiter
cd /home/synopsis/Anish_Harodeep_Group_Lab/Q2_priority_arbiter
dc_shell -f dc_synth_arbiter.tcl | tee dc_arbiter.log

# Q3: Glitch-Free Clock Gater
cd /home/synopsis/Anish_Harodeep_Group_Lab/Q3_clock_gater
dc_shell -f dc_synth_clock_gater.tcl | tee dc_clock_gater.log

# Q4: Dual 8-Bit Registers (Swap & Freeze)
cd /home/synopsis/Anish_Harodeep_Group_Lab/Q4_dual_reg_swap
dc_shell -f dc_synth_dual_reg.tcl | tee dc_dual_reg.log
