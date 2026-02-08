# Student Instructions – Mini Calculator ASIC

## Goal

Design a small digital ASIC Chip implementing a mini adder controlled by a single button and a finite state machine (FSM).

The system sequentially captures two 4-bit operands, computes their sum, and displays the result on two 7-segment displays.

The control button is considered ideal, meaning it produces a single-clock-cycle pulse synchronized to clk (see below).

## External Interface

### Inputs

1. `clk` - System clock
2. `rst_n` - Active-low synchronous reset (High value means no reset)
3. `btn_next` - Ideal button: synchronized, debounced, single-cycle pulse
4. `in[4:0]` - 4-bit input bus

### Outputs

1. `seg0[6:0]` - 7-segment display for first digit (4-bit value, active-low)
2. `seg1[6:0]` - 7-segment display for last digit (4-bit value, active-low)

## Functional Behavior

The system operates in a sequential manner using a simple FSM and a single control button. The intended usage sequence is:

1. The user sets the input bus in[3:0] to operand A
2. The user presses the control button → operand A is stored
3. The user sets the input bus in[3:0] to operand B
4. The user presses the control button → operand B is stored
5. The system computes A + B and displays the result
6. On the next button press, the system returns to step 1

This sequence repeats indefinitely.

## Example Waveform

The waveform below shows how chip will work:

![Waveform](wavedrom.svg)

## Functional Behavior

The system is based on a circular FSM. Each press of `btn_next` captures the current input and advances the state.
Two 7-segment displays show the complete values in hexadecimal form (two hex digits).

**Initial State:** Upon reset (`rst_n` = 0), the FSM must initialize to the `GET_A` state.

### FSM sequence

1. `GET_A`
    - Display the current value of `in[4:0]` in real-time on both 7-segment displays (live feed)
    - When `btn_next` is pressed: capture the current value of `in[4:0]` into register `A` and advance to `GET_B`

2. `GET_B`
    - Display the current value of `in[4:0]` in real-time on both 7-segment displays (live feed)
    - When `btn_next` is pressed: capture the current value of `in[4:0]` into register `B` and advance to `GET_OP`

3. `GET_OP`
    - Display the current value of `in[4:0]` in real-time on the 7-segment displays (live feed)
    - When `btn_next` is pressed: capture the current value of `in[1:0]` into operation register and advance to `SHOW_RESULT`

4. `SHOW_RESULT`
    - Display the complete 5-bit ALU result in hexadecimal on both displays
    - Next button press returns to `GET_A`

The FSM always progresses forward; no backward navigation or editing is required.

## Specifications

### Button Specification

The `btn_next` signal is considered IDEAL, meaning:
- Already synchronized to the `clk` domain
- Already debounced (no mechanical bouncing)
- Produces exactly **one** clock cycle pulse per button press
- No additional debouncing or edge detection circuitry is required

### Display Specification

- **Two** 7-segment displays are used (ACTIVE-LOW outputs):
  * `seg0[6:0]`: displays the first value (bits 3:0) in hexadecimal
  * `seg1[6:0]`: displays the last value (bits 7:4) in hexadecimal
  * `seg` encoding: `seg[6:0] = {a, b, c, d, e, f, g}` (alphabetical order)
  * Active-low: 0 = segment ON, 1 = segment OFF

- The displays dynamically show values based on the FSM state:
  * In `GET_A`: shows the **live input** `in[4:0]` in real-time (e.g., as user changes input to 0xC → display shows "0C")
  * In `GET_B`: shows the **live input** `in[4:0]` in real-time (e.g., as user changes input to 0x3 → display shows "03")
  * In `GET_OP`: shows the **live input** `in[1:0]` in real-time (e.g., as user changes input to 2 → display shows "02")
  * In `SHOW_RESULT`: shows the **calculated result** from the ALU (e.g., Result=0x1F → display shows "1F")

**Key Behavior:**
In `GET_A`, `GET_B`, and `GET_OP` states, the display acts as a "live preview" of the input bus.
The values are only **captured into registers** when `btn_next` is pressed, which also advances to the next state.

### Reset Specification

- `rst_n` is active-low and synchronous
- When `rst_n` = 0: system initializes to `GET_A` state with all registers cleared
- When `rst_n` = 1: normal operation

## Architecture

![Architecture](architecture.drawio.svg)

