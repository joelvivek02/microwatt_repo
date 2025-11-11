# Microwatt ML Accelerator (Simulation-Only)
A minimal SoC integrated with a Multiply–Accumulate (MAC) accelerator.
Simulated using GHDL and GTKWave.

## Run Instructions
```bash
ghdl --clean
ghdl -a --std=08 utils.vhdl
ghdl -a --std=08 decode_types.vhdl
ghdl -a --std=08 common.vhdl
ghdl -a --std=08 wishbone_types.vhdl
ghdl -a --std=08 ml_accelerator.vhdl
ghdl -a --std=08 soc.vhdl
ghdl -a --std=08 soc_tb.vhdl
ghdl -m --std=08 soc_tb
ghdl -r --std=08 soc_tb --wave=soc_tb.ghw
gtkwave soc_tb.ghw &
```
