# Board oscillator connected to CLOCK0_50 (PIN_DJ35).
create_clock -name CLOCK0_50 -period 20.000 [get_ports {CLOCK0_50}]

# The LED pins drive on-board indicators, not a synchronous external receiver.
# Model their board-level output delay as zero so the timing intent is explicit.
set_output_delay -clock CLOCK0_50 -max 0.000 [get_ports {LEDR[*]}]
set_output_delay -clock CLOCK0_50 -min 0.000 [get_ports {LEDR[*]}]
