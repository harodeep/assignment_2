#!/bin/bash
# ==============================================================================
# Complete Synopsys Automation Script: VCS Simulation followed by DC Synthesis
# Location: /home/synopsis/Anish_Harodeep_Group_Lab/run_all.sh
# ==============================================================================

set -e # Exit immediately if a command exits with a non-zero status

BASE_DIR="/home/synopsis/Anish_Harodeep_Group_Lab"

echo "=================================================================="
echo " STAGE 1: SYNOPSYS VCS BEHAVIORAL SIMULATION & VERIFICATION"
echo "=================================================================="

# ------------------------------------------------------------------------------
# Q1: 4-Bit Barrel Shifter VCS Simulation
# ------------------------------------------------------------------------------
echo "[-] Running VCS Simulation for Q1: 4-Bit Barrel Shifter..."
cd "$BASE_DIR/Q1_barrel_shifter"
vcs -full64 -sverilog barrel_shifter_4bit.v tb_barrel_shifter.v \
    -debug_access+all \
    -l vcs_compile.log \
    -o simv_q1
./simv_q1 -l simulation.log
echo "[✓] Q1 Simulation completed successfully."
echo ""

# ------------------------------------------------------------------------------
# Q2: 4-Input Priority Arbiter VCS Simulation
# ------------------------------------------------------------------------------
echo "[-] Running VCS Simulation for Q2: 4-Input Priority Arbiter..."
cd "$BASE_DIR/Q2_priority_arbiter"
vcs -full64 -sverilog priority_arbiter_4.v tb_priority_arbiter_4.v \
    -debug_access+all \
    -l vcs_compile.log \
    -o simv_q2
./simv_q2 -l simulation.log
echo "[✓] Q2 Simulation completed successfully."
echo ""

# ------------------------------------------------------------------------------
# Q3: Clock Gating Circuit VCS Simulation
# ------------------------------------------------------------------------------
echo "[-] Running VCS Simulation for Q3: Glitch-Free Clock Gater..."
cd "$BASE_DIR/Q3_clock_gater"
vcs -full64 -sverilog clock_gater.v tb_clock_gater.v \
    -debug_access+all \
    -l vcs_compile.log \
    -o simv_q3
./simv_q3 -l simulation.log
echo "[✓] Q3 Simulation completed successfully."
echo ""

# ------------------------------------------------------------------------------
# Q4: Dual 8-Bit Registers (Freeze & Swap) VCS Simulation
# ------------------------------------------------------------------------------
echo "[-] Running VCS Simulation for Q4: Dual Registers (Swap/Freeze)..."
cd "$BASE_DIR/Q4_dual_reg_swap"
vcs -full64 -sverilog dual_reg_swap.v tb_dual_reg_swap.v \
    -debug_access+all \
    -l vcs_compile.log \
    -o simv_q4
./simv_q4 -l simulation.log
echo "[✓] Q4 Simulation completed successfully."
echo ""


echo "=================================================================="
echo " STAGE 2: SYNOPSYS DESIGN COMPILER (DC_SHELL) LOGIC SYNTHESIS"
echo "=================================================================="

# ------------------------------------------------------------------------------
# Q1: 4-Bit Barrel Shifter DC Synthesis
# ------------------------------------------------------------------------------
echo "[-] Synthesizing Q1: 4-Bit Barrel Shifter with DC..."
cd "$BASE_DIR/Q1_barrel_shifter"
dc_shell -f dc_synth_shifter.tcl | tee dc_synth_shifter.log
echo "[✓] Q1 Synthesis and reports generated."
echo ""

# ------------------------------------------------------------------------------
# Q2: 4-Input Priority Arbiter DC Synthesis
# ------------------------------------------------------------------------------
echo "[-] Synthesizing Q2: 4-Input Priority Arbiter with DC..."
cd "$BASE_DIR/Q2_priority_arbiter"
dc_shell -f dc_synth_arbiter.tcl | tee dc_synth_arbiter.log
echo "[✓] Q2 Synthesis and reports generated."
echo ""

# ------------------------------------------------------------------------------
# Q3: Clock Gating Circuit DC Synthesis
# ------------------------------------------------------------------------------
echo "[-] Synthesizing Q3: Glitch-Free Clock Gater with DC..."
cd "$BASE_DIR/Q3_clock_gater"
dc_shell -f dc_synth_clock_gater.tcl | tee dc_synth_clock_gater.log
echo "[✓] Q3 Synthesis and reports generated."
echo ""

# ------------------------------------------------------------------------------
# Q4: Dual 8-Bit Registers (Freeze & Swap) DC Synthesis
# ------------------------------------------------------------------------------
echo "[-] Synthesizing Q4: Dual Registers (Swap/Freeze) with DC..."
cd "$BASE_DIR/Q4_dual_reg_swap"
dc_shell -f dc_synth_dual_reg.tcl | tee dc_synth_dual_reg.log
echo "[✓] Q4 Synthesis and reports generated."
echo ""

echo "=================================================================="
echo " ALL SIMULATIONS AND SYNTHESIS RUNS COMPLETED SUCCESSFULLY"
echo "=================================================================="