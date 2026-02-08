"""
Modern cocotb 2.0 testbench for the Controller module.
Uses async/await syntax and modern pythonic patterns.
"""

import os
from pathlib import Path

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge
from cocotb.types import LogicArray

from cocotb_tools.runner import get_runner

class ControllerTester:
    """Helper class for Controller module testing."""
    
    def __init__(self, dut):
        self.dut = dut
        self.clk = dut.clk
        self.rst_n = dut.rst_n
        self.button = dut.button
        self.save_A = dut.save_A
        self.save_B = dut.save_B
        self.show_result = dut.show_result
    
    async def reset(self):
        """Apply reset pulse."""
        self.rst_n.value = 0
        await RisingEdge(self.clk)
        self.rst_n.value = 1
        await RisingEdge(self.clk)
    
    async def wait_cycles(self, num_cycles: int):
        """Wait for specified number of clock cycles."""
        for _ in range(num_cycles):
            await RisingEdge(self.clk)
    
    async def press_button(self, cycles: int = 1):
        """Press and release button for specified cycles."""
        self.button.value = 1
        await self.wait_cycles(cycles)
        self.button.value = 0
        await self.wait_cycles(1)
    
    async def check_outputs(self, save_a: int = 0, save_b: int = 0, show_res: int = 0):
        """Check output values."""
        assert self.save_A.value == save_a, \
            f"Expected save_A={save_a}, got {self.save_A.value}"
        assert self.save_B.value == save_b, \
            f"Expected save_B={save_b}, got {self.save_B.value}"
        assert self.show_result.value == show_res, \
            f"Expected show_result={show_res}, got {self.show_result.value}"


@cocotb.test()
async def test_reset(dut):
    """Test: Verify controller initializes to IDLE state after reset."""
    tester = ControllerTester(dut)
    
    # Start clock
    clock = Clock(dut.clk, 10, units="us")
    await cocotb.start(clock.start())
    
    # Apply reset
    await tester.reset()
    
    # Verify all outputs are 0 in IDLE state
    await tester.check_outputs(save_a=0, save_b=0, show_res=0)
    dut._log.info("✓ Reset test passed")


@cocotb.test()
async def test_single_button_press_saves_a(dut):
    """Test: First button press in IDLE should assert save_A and transition to WAIT_B."""
    tester = ControllerTester(dut)
    
    clock = Clock(dut.clk, 10, units="us")
    await cocotb.start(clock.start())
    await tester.reset()
    
    # Press button while in IDLE state
    dut.button.value = 1
    await RisingEdge(dut.clk)
    
    # save_A should be asserted combinationally
    await tester.check_outputs(save_a=1, save_b=0, show_res=0)
    
    # Release button
    dut.button.value = 0
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    
    # Now in WAIT_B state, button not pressed
    await tester.check_outputs(save_a=0, save_b=0, show_res=0)
    dut._log.info("✓ Single button press saves A test passed")


@cocotb.test()
async def test_full_sequence(dut):
    """Test: Complete sequence - press button three times through all states."""
    tester = ControllerTester(dut)
    
    clock = Clock(dut.clk, 10, units="us")
    await cocotb.start(clock.start())
    await tester.reset()
    
    # First press: IDLE -> WAIT_B, save_A asserted
    dut.button.value = 1
    await RisingEdge(dut.clk)
    await tester.check_outputs(save_a=1, save_b=0, show_res=0)
    dut.button.value = 0
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    
    # Second press: WAIT_B -> WAIT_RESULT, save_B asserted
    dut.button.value = 1
    await RisingEdge(dut.clk)
    await tester.check_outputs(save_a=0, save_b=1, show_res=0)
    dut.button.value = 0
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    
    # Third press: WAIT_RESULT -> IDLE, show_result asserted
    dut.button.value = 1
    await RisingEdge(dut.clk)
    await tester.check_outputs(save_a=0, save_b=0, show_res=1)
    dut.button.value = 0
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    
    # Back in IDLE state
    await tester.check_outputs(save_a=0, save_b=0, show_res=0)
    dut._log.info("✓ Full sequence test passed")


@cocotb.test()
async def test_button_held_multiple_cycles(dut):
    """Test: Button held for multiple cycles - output should stay active."""
    tester = ControllerTester(dut)
    
    clock = Clock(dut.clk, 10, units="us")
    await cocotb.start(clock.start())
    await tester.reset()
    
    # Press and hold button for 3 cycles
    dut.button.value = 1
    await RisingEdge(dut.clk)
    await tester.check_outputs(save_a=1, save_b=0, show_res=0)
    
    await RisingEdge(dut.clk)
    # Still in IDLE state, button still pressed - save_A should still be asserted
    await tester.check_outputs(save_a=1, save_b=0, show_res=0)
    
    await RisingEdge(dut.clk)
    # Still asserted
    await tester.check_outputs(save_a=1, save_b=0, show_res=0)
    
    # Release button
    dut.button.value = 0
    await RisingEdge(dut.clk)
    dut._log.info("✓ Button held multiple cycles test passed")


@cocotb.test()
async def test_button_glitch_rejection(dut):
    """Test: Short button pulses (single cycle) should transition state."""
    tester = ControllerTester(dut)
    
    clock = Clock(dut.clk, 10, units="us")
    await cocotb.start(clock.start())
    await tester.reset()
    
    # Single cycle button pulse
    dut.button.value = 1
    await RisingEdge(dut.clk)
    dut.button.value = 0
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    
    # Should have transitioned to WAIT_B
    await tester.check_outputs(save_a=0, save_b=0, show_res=0)
    
    # Another single cycle pulse
    dut.button.value = 1
    await RisingEdge(dut.clk)
    await tester.check_outputs(save_a=0, save_b=1, show_res=0)
    dut._log.info("✓ Button glitch rejection test passed")


@cocotb.test()
async def test_reset_from_any_state(dut):
    """Test: Reset should work from any state."""
    tester = ControllerTester(dut)
    
    clock = Clock(dut.clk, 10, units="us")
    await cocotb.start(clock.start())
    
    # Test reset from IDLE
    tester.rst_n.value = 0
    await RisingEdge(dut.clk)
    tester.rst_n.value = 1
    await RisingEdge(dut.clk)
    await tester.check_outputs(save_a=0, save_b=0, show_res=0)
    
    # Transition to WAIT_B
    dut.button.value = 1
    await RisingEdge(dut.clk)
    dut.button.value = 0
    await RisingEdge(dut.clk)
    
    # Reset from WAIT_B
    tester.rst_n.value = 0
    await RisingEdge(dut.clk)
    tester.rst_n.value = 1
    await RisingEdge(dut.clk)
    await tester.check_outputs(save_a=0, save_b=0, show_res=0)
    
    # Transition to WAIT_RESULT
    dut.button.value = 1
    await RisingEdge(dut.clk)
    dut.button.value = 0
    await RisingEdge(dut.clk)
    dut.button.value = 1
    await RisingEdge(dut.clk)
    dut.button.value = 0
    await RisingEdge(dut.clk)
    
    # Reset from WAIT_RESULT
    tester.rst_n.value = 0
    await RisingEdge(dut.clk)
    tester.rst_n.value = 1
    await RisingEdge(dut.clk)
    await tester.check_outputs(save_a=0, save_b=0, show_res=0)
    dut._log.info("✓ Reset from any state test passed")


@cocotb.test()
async def test_continuous_button_presses(dut):
    """Test: Rapid consecutive button presses."""
    tester = ControllerTester(dut)
    
    clock = Clock(dut.clk, 10, units="us")
    await cocotb.start(clock.start())
    await tester.reset()
    
    # Simulate 3 rapid presses without long gaps
    for press in range(3):
        dut.button.value = 1
        await RisingEdge(dut.clk)
        await RisingEdge(dut.clk)
        dut.button.value = 0
        await RisingEdge(dut.clk)
    
    # Should be back in IDLE
    await tester.check_outputs(save_a=0, save_b=0, show_res=0)
    dut._log.info("✓ Continuous button presses test passed")

def test_controller_runner():
    sim = os.getenv("SIM", "icarus")

    proj_path = Path(__file__).resolve().parent.parent

    sources = [proj_path / "src" / "controller.sv"]

    runner = get_runner(sim)
    runner.build(
        sources=sources,
        hdl_toplevel="controller",
        always=True,
        waves=True,
        timescale=("1ns", "1ps"),
    )

    runner.test(hdl_toplevel="controller", test_module="test_controller")

if __name__ == "__main__":
    test_controller_runner()