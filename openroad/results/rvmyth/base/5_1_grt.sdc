###############################################################################
# Created by write_sdc
###############################################################################
current_design RV_CPU
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 10.3500 [get_ports {clk}]
set_clock_transition 0.5175 [get_clocks {clk}]
set_clock_uncertainty -setup 0.5175 clk
set_clock_uncertainty -hold 0.8280 clk
set_propagated_clock [get_clocks {clk}]
###############################################################################
# Environment
###############################################################################
set_input_transition 0.8280 [get_ports {reset}]
###############################################################################
# Design Rules
###############################################################################
