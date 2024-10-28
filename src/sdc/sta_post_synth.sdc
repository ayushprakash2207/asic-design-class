set_units -time ns
create_clock [get_pins {pll/CLK}] -name clk -period 10.35
set_clock_uncertainty [expr 0.05 * 10.35] -setup [get_clocks clk]
set_clock_uncertainty [expr 0.08 * 10.35] -hold [get_clocks clk]
set_clock_transition [expr 0.05 * 10.35] [get_clocks clk]
set_input_transition [expr 0.08 * 10.35] [all_inputs]