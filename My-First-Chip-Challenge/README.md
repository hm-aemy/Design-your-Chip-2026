# Student Instructions – Mini Calculator ASIC
## Goal
Create a small mini calculator, with single button and a 4-bit input X.

The system behavior is defined by a finite state machine (FSM) that sequentially captures two operands, adds them, and then displays the result on two 7-segment displays.

A sequence looks like this:

1. X is set to operand 1
2. button is pressed
3. X is set to operand 2
4. button is pressed
5. the result of the addition is shown

## External Interface

### Inputs
1. button - Control button
2. in[4:0] - 4-bit input bus
### Outputs
1. seg0[6:0] - 7-segment display for last digit
2. seg1[6:0] - 7-segment display for first digit