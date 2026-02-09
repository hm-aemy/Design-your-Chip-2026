---
theme: simple
css: hm.css
controlsTutorial: true
---

# Your First Chip

## Help

Navigate left/right for the individual steps and up/down to dive deeper into topics or get more help.

## Preparation

You can use the librelane template repo from Moodle.

For the first part (*design and test*), do **not use the Librelane nix-shell**. Instead install icarus verilog in the Docker container or locally, e.g.,

```
apt install iverilog (Linux and Docker)
brew install icarus-verilog (MacOS)
```

## Architecture

The following image shows the chip architecture.

![](../assignment/architecture.drawio.svg)\

We will implement and test each of the modules and then combine it into one design.

Which one to start with?

# BCD converter

## Introduction

Binary coded decimal: each digit is a bit value, for example decimal 23:

| 2       | 3       |
| ------- | ------- |
| 4'b0010 | 4'b0011 |

*Note: `4'b0011` is the binary literal in Verilog: 4 is the size in bits, b is binary and then the number. The same number in hexadecimal (`h`) and decimal (`d`) representation is `4'h3` and `4'd3`.*

But what is the actual binary representation?

## Conversion from binary to BCD

Binary representation of 23 is `5'b10111`. This is how numbers are generally encoded.

**Goal: Convert from binary to two digit BCD**

Not trivial: `5'b10111` → `4'b0010` (tens) and `4'b0011`(ones). Converter is needed.

How to do this?

## Empty module with ports

```verilog
module bcd_converter(
    input logic [4:0] binary,
    output logic [3:0] tens,
    output logic [3:0] ones
);


endmodule
```

Need to put logic into it.

## Truth table

::: columns

:::: column

| `binary[4:0]` | `tens[3:0]` | `ones[3:0]` |
| -------------- | ------------- | ------------- |
| `00000`        | `0000`        | `0000`        |
| ..             | ..            | ..            |
| `01001`        | `0000`        | `1001`        |
| `01010`        | `0001`        | `0000`        |
| ..             | ..            | ..            |
| `10010`        | `0010`        | `0000`        |
| ..             | ..            | ..            |
| `11110`        | `0011`        | `0000`        |
| `11111`        | `0011`        | `0001`        |

::::

:::: { .column width=40% }

Need to derive logic function for each of the output bits.

Some are trivial:

- `tens[3] = 0` and `tens[2] = 0`
- `ones[0] = binary[0]` 

::::

:::


## Let's put it into Verilog

```verilog
module bcd_converter(
    input logic [4:0] binary,
    output logic [3:0] tens,
    output logic [3:0] ones
);

  assign tens[3] = 1'b0;
  assign tens[2] = 1'b0;
  assign tens[0] = binary[0];

endmodule
```

## What about the other bits?

Straight forward way: Minterms

Approach: Lookup all entries on the truth table where an output bit is set. The minterm is the disjunction (OR) of each of the input values.

Example for `tens[1]` (is one for numbers 20 and above):

$$t_1 = (x_4 \bar{x}_3 x_2 \bar{x}_1 \bar{x}_0) \vee (x_4 \bar{x}_3 x_2 \bar{x}_1 x_0) \vee (x_4 \bar{x}_3 x_2 x_1 \bar{x}_0) \vee (x_4 \bar{x}_3 x_2 x_1 x_0) \vee (x_4 x_3 \bar{x}_2 \bar{x}_1 \bar{x}_0) \vee (x_4 x_3 \bar{x}_2 \bar{x}_1 x_0) \vee (x_4 x_3 \bar{x}_2 x_1 \bar{x}_0) \vee (x_4 x_3 \bar{x}_2 x_1 x_0) \vee (x_4 x_3 x_2 \bar{x}_1 \bar{x}_0) \vee (x_4 x_3 x_2 \bar{x}_1 x_0) \vee (x_4 x_3 x_2 x_1 \bar{x}_0) \vee (x_4 x_3 x_2 x_1 x_0)$$

## Translate this into Verilog

$$t_1 = (x_4 \bar{x}_3 x_2 \bar{x}_1 \bar{x}_0) \vee (x_4 \bar{x}_3 x_2 \bar{x}_1 x_0) \vee (x_4 \bar{x}_3 x_2 x_1 \bar{x}_0) \vee (x_4 \bar{x}_3 x_2 x_1 x_0) \vee ...$$

```verilog
assign tens[1] =
    (binary[4] & ~binary[3] & binary[2] & ~binary[1] & ~binary[0]) |
    (binary[4] & ~binary[3] & binary[2] & ~binary[1] &  binary[0]) |
    (binary[4] & ~binary[3] & binary[2] &  binary[1] & ~binary[0]) |
    (binary[4] & ~binary[3] & binary[2] &  binary[1] &  binary[0]) |
    ...   
```

## More compact version

```verilog
assign tens[1] = (binary==5'b10100) | (binary==5'b10101) |
    (binary==5'b10110) | (binary==5'b10111) | ...
```

. . .

We just enumerate the entries from the table here, and can make this even more intuitive:

. . .

```verilog
assign tens[1] = (binary==5'd20) | (binary==5'd21) | (binary==5'd22) | 
    (binary==5'd23) | (binary==5'd24) | (binary==5'd25) | ...
```

## Logic optimization

Use standard methods like K-map (*KV Diagramm*) to optimize boolean equation:

. . .

$$t_1 = x_4 x_3 \vee x_4 x_2 = x_4 (x_3 \vee x_2)$$

translated to Verilog:

```verilog
assign tens[1] = binary[4] & (binary[3] | binary[2]);
```

**Important: In the design process, the synthesis tool will perform optimizations, so that the result will be the same of all code variants above.**

## Tedious process

You can derive the entire logic like this, but it is an error prone and tedious process.

Verilog and other hardware description languages allow for various ways to express this.

. . .

For example, this is a simple expression for this bit:

```verilog
assign tens[1] = (binary >= 20);
```

But this approach also has limits for the other bits then..

```verilog
assign tens[0] = ((binary >=10) && (binary <= 19)) || (binary >= 30);
```

## Straight forward from truth table

Behavioral process in Verilog (is always called when any input changes), *lookup table (LUT)*:

```verilog
always_comb begin
  case (binary)
    5'd0: {tens, ones} = {4'd0, 4'd0};
    5'd1: {tens, ones} = {4'd0, 4'd1};
    /* ... */
    5'd9: {tens, ones} = {4'd0, 4'd9};
    5'd10:  {tens, ones} = {4'd1, 4'd0};
    /* ... */
    5'd20:  {tens, ones} = {4'd2, 4'd0};
    /* ... */
    5'd30:  {tens, ones} = {4'd3, 4'd0};
    5'd31:  {tens, ones} = {4'd3, 4'd1};
  endcase
end
```

This will also snythesize to the same result, probably most intuitive.

## Implement the module and test it

Use this (or one of the other) approaches in `M3_BCD/src/bcd_converter.sv`, or think about an even simpler one you think might exist.

Test the module from the `M3_BCD/test` folder:

```shell
python3 test_bcd_converter.py
```

We use a modern tool called [*cocotb*](https://cocotb.org) to test our hardware modules. Have a look at the test and ensure your module passes.

## Test output

Expexted output:

```{.smallcode}
    0.00ns INFO     cocotb                             Running tests
    0.00ns INFO     cocotb.regression                  running test_bcd_converter.test_all_values (1/1)
                                                        Test: Iterate through all binary values from 0 to 31 and check BCD outputs.
    1.00ns INFO     cocotb.bcd_converter               Checking value 0: expected tens 0, expected ones 0

     [...]
    
    32.00ns INFO     cocotb.bcd_converter               ✓ Full test passed
    32.00ns INFO     cocotb.regression                  test_bcd_converter.test_all_values passed
    32.00ns INFO     cocotb.regression                  ********************************************************************************************
                                                        ** TEST                                STATUS  SIM TIME (ns)  REAL TIME (s)  RATIO (ns/s) **
                                                        ********************************************************************************************
                                                        ** test_bcd_converter.test_all_values   PASS          32.00           0.00      15989.72  **
                                                        ********************************************************************************************
                                                        ** TESTS=1 PASS=1 FAIL=0 SKIP=0                       32.00           0.00      13999.97  **
                                                        ********************************************************************************************         
```

## Viewing the waveform

You can also inspect the waveform with the Surfer waveform viewer (available is vscode plugin).

To inspect the waveform, open `sim_build/bcd_converter.fst`.

If you struggle with the task, see the next slide for the most simple solution.

## Most simple implementation

```verilog
module bcd_converter(
    input logic [4:0] binary,
    output logic [3:0] tens,
    output logic [3:0] ones
);

    assign tens = binary / 10;
    assign ones = binary % 10;

endmodule
```

# Adder module

## Functionality

- The adder does not only add the two operands
- It also stores the operands when the button is pressed
- For this we need to create registers
- The result is a combinational output

## Module and Ports

```verilog
  module adder(
      input logic        clk,
      input logic [3:0]  operand,
      input logic        save_A, save_B,
      output logic [4:0] result
  );

  endmodule
```

Find out how to create two flip flops, A and B, to save the operands.

## Create registers

```verilog
    logic [3:0] A;
    logic [3:0] B;

    always_ff @(posedge clk) begin
        /* Fill logic here */
    end
```

We do not need to reset them to sane values here.

[//]: <> (TODO: Waveform?)

## Solution: Registers

```verilog
    logic [3:0] A;
    logic [3:0] B;

    always_ff @(posedge clk) begin
        if (save_A) A <= operand;
        if (save_B) B <= operand;
    end
```

Next: Add the combinational logic that sets the result to the addition of A and B.

Test the module again with `test/test_adder.py`. It tests the basic functionality and 10 random additions.

## Combinational logic

Very simple: You can just use the `+` operator, the synthesis tool will create an adder.

```verilog
    assign result = A + B;
```

Done, but maybe you want to make really sure it works correctly? Write a test that checks all possible combinations of values.

## Testing all cases

```python
    for a in range(16):
        for b in range(16):
            expect = a + b

            dut._log.info(f"Test {a}+{b}, expecting {expect}")

            await tester.set_operand(a, save_A=1, save_B=0)
            await RisingEdge(tester.clk)

            await tester.set_operand(b, save_A=0, save_B=1)  
            await RisingEdge(tester.clk)

            await tester.set_operand(0, save_A=0, save_B=0)  
            assert tester.result.value == expect,
                f"Test {i}: Expected {expect}, got {tester.result.value}"
```

# Seven segment

## Seven segment displays

Seven segment displays have 7 illuminated surfaces that can be used to display numbers.

![](M4_7segment/sevesegment.png)\

## Functionality

- Whenever the `update` signal is high at a positive clock edge: store `digit` into a register (for example `value`)
- Decode the **stored** digit and display the numbers
- Mapping: `seg[6]` (most significant bit) to a, `seg[0]`(least significant bit) to g 
- Hints: Using a lookup table is the most straightforward solution
- Again, you can test it with `test/test_seven_segment.py`

Continue to the next slides if you face any issues.

## Solution: Register

```verilog
    logic [3:0] value;

    always_ff @(posedge clk) begin
        if (update) value <= digit;
    end
```

## Solution: Lookup Table

```verilog
    always_comb begin
        case (value)
            4'd0: seg = 7'b1111110;
            4'd1: seg = 7'b0110000;
            4'd2: seg = 7'b1101101;
            4'd3: seg = 7'b1111001;
            4'd4: seg = 7'b0110011;
            4'd5: seg = 7'b1011011;
            4'd6: seg = 7'b1011111;
            4'd7: seg = 7'b1110000;
            4'd8: seg = 7'b1111111;
            4'd9: seg = 7'b1111011;
            default: seg = 7'bxxxxxxx;
        endcase
    end
```

# Controller

## Functionality

The controller uses a trivial finite state machine.

It is critical to adhere to the timing:

- On a button press, perform the action in the same cycle (`store_A`, `store_B`, `show_result`), and change the state in the next cycle.
- Ensure that the signals have proper default values.

## Waveform

![](M1_controller/doc/wavedrom.svg)\

## Coding state machines

```verilog
    enum {GET_A,GET_B, SHOW_RESULT} state, next_state;
```

## Coding state machines

```verilog
    always_comb begin : control_logic
        save_A = 0;
        save_B = 0;
        show_result = 0;

        next_state = state;

        case (state)
            GET_A: begin
                if (button) begin
                    // TODO:
                    next_state = GET_B;
                end
            end

        endcase
    end
```

## Coding state machines

```verilog
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= GET_A;
        end else begin
            state <= next_state;
        end
    end
```

## Complete and test

Once you have completed the module, run the tests `tests/test_controller.py`.

You can find the solution [here](https://github.com/hm-aemy/Design-your-Chip-2026/blob/main/My-First-Chip-Challenge/solution/M1_Controller/src/controller.sv).