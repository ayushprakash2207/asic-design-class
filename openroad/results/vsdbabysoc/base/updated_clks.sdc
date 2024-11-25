###############################################################################
# Created by write_sdc
###############################################################################
current_design vsdbabysoc
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 5.8633 [get_pins {pll/CLK}]
set_clock_transition 0.5175 [get_clocks {clk}]
set_clock_uncertainty -setup 0.5175 clk
set_clock_uncertainty -hold 0.8280 clk
###############################################################################
# Environment
###############################################################################
set_input_transition 0.8280 [get_ports {ENb_CP}]
set_input_transition 0.8280 [get_ports {ENb_VCO}]
set_input_transition 0.8280 [get_ports {REF}]
set_input_transition 0.8280 [get_ports {VCO_IN}]
set_input_transition 0.8280 [get_ports {VREFH}]
set_input_transition 0.8280 [get_ports {reset}]
###############################################################################
# Design Rules
###############################################################################
