# CVC www.cvcblr.com Trying COCOTB & Pyhton
# This is NEWBIE code in Python, so don't expect too much
# Simple test for an AND Gate module
#

# Use the ccotb framework
import cocotb

# Use Timer to model Verilog like #delays
from cocotb.triggers import Timer

# Use Reporting mechanism, a la UVM messaging
from cocotb.result import TestFailure

# Start a testcase
@cocotb.test()
def dir_test (dut): # dut is the defult, pre-defined pointer to DUT top Verilog module, done already by Cocotb for us
    
    
    
    dut.log.info("Start of test!")
    # Wait for 10 ns, Cocotb's Timer argument is in PS i.e. timer_ps
    yield Timer(10000)
    dut.log.info("All zeros test")
    
    dut.bus = 0b0000
    
    # Wait for 10 ns
    yield Timer(10000)
    
    if ((dut.allzeros != 1) and (dut.alloness != 0) and (dut.anyzeros != 1) and (dut.anyones != 0) ) :
        raise TestFailure("FAIL") 
    else: 
        dut.log.info("PASS!")

        
    
    dut.log.info("All ones test")
    dut.bus = 15
    
    # Wait for 10 ns
    yield Timer(10000)
    
    if ((dut.allzeros != 0) and (dut.alloness != 1) and (dut.anyzeros != 0) and (dut.anyones != 1) ) :
        raise TestFailure("FAIL") 
    else: 
        dut.log.info("PASS!")
        
    dut.log.info("Any one and any zero test")
    dut.bus = 9
    
    # Wait for 10 ns
    yield Timer(10000)
    
    if ((dut.allzeros != 0) and (dut.alloness != 0) and (dut.anyzeros != 1) and (dut.anyones != 1) ) :
        raise TestFailure("FAIL") 
    else: 
        dut.log.info("PASS!")

