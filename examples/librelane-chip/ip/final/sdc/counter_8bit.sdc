###############################################################################
# Created by write_sdc
###############################################################################
current_design counter_8bit
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk_i -period 10.0000 [get_ports {clk_i}]
set_clock_transition 0.1500 [get_clocks {clk_i}]
set_clock_uncertainty 0.2500 clk_i
set_propagated_clock [get_clocks {clk_i}]
set_input_delay 2.0000 -clock [get_clocks {clk_i}] -add_delay [get_ports {rst_ni}]
set_output_delay 2.0000 -clock [get_clocks {clk_i}] -add_delay [get_ports {count_o[0]}]
set_output_delay 2.0000 -clock [get_clocks {clk_i}] -add_delay [get_ports {count_o[1]}]
set_output_delay 2.0000 -clock [get_clocks {clk_i}] -add_delay [get_ports {count_o[2]}]
set_output_delay 2.0000 -clock [get_clocks {clk_i}] -add_delay [get_ports {count_o[3]}]
set_output_delay 2.0000 -clock [get_clocks {clk_i}] -add_delay [get_ports {count_o[4]}]
set_output_delay 2.0000 -clock [get_clocks {clk_i}] -add_delay [get_ports {count_o[5]}]
set_output_delay 2.0000 -clock [get_clocks {clk_i}] -add_delay [get_ports {count_o[6]}]
set_output_delay 2.0000 -clock [get_clocks {clk_i}] -add_delay [get_ports {count_o[7]}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.0060 [get_ports {count_o[7]}]
set_load -pin_load 0.0060 [get_ports {count_o[6]}]
set_load -pin_load 0.0060 [get_ports {count_o[5]}]
set_load -pin_load 0.0060 [get_ports {count_o[4]}]
set_load -pin_load 0.0060 [get_ports {count_o[3]}]
set_load -pin_load 0.0060 [get_ports {count_o[2]}]
set_load -pin_load 0.0060 [get_ports {count_o[1]}]
set_load -pin_load 0.0060 [get_ports {count_o[0]}]
set_driving_cell -lib_cell sg13g2_buf_4 -pin {X} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {clk_i}]
set_driving_cell -lib_cell sg13g2_buf_4 -pin {X} -input_transition_rise 0.0000 -input_transition_fall 0.0000 [get_ports {rst_ni}]
###############################################################################
# Design Rules
###############################################################################
set_max_fanout 10.0000 [current_design]
