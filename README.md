# 🚀 Microwatt ML Accelerator (Simulation-Only)

### A Minimal System-on-Chip (SoC) with a Multiply–Accumulate (MAC) Based ML Accelerator  
Integrated and simulated alongside the **Microwatt soft-core CPU** framework using **VHDL-2008, GHDL, and GTKWave**.

---

## 🧠 Overview

This project demonstrates the **integration of a lightweight ML accelerator** into a **Microwatt-compatible SoC** using the Wishbone bus interface.

The accelerator performs a simple **Multiply–Accumulate (MAC)** operation:

\[
\text{Result} = (A \times B) + C
\]

The design was verified entirely in simulation — no FPGA hardware required.  
It forms a foundation for further ML accelerator extensions (vector MACs, systolic arrays, or CNN blocks).

---

## 🧩 System Architecture

The SoC contains three key components:

| Module | Description |
|:--------|:-------------|
| **`ml_accelerator.vhdl`** | Implements a 32-bit multiply-accumulate datapath with Wishbone interface. |
| **`soc.vhdl`** | Minimal SoC shell connecting the accelerator to clock, reset, and bus ports. |
| **`soc_tb.vhdl`** | Testbench to drive A, B, and C inputs, trigger computation, and read back results. |

The communication follows the **Wishbone** B4 protocol for register-level bus transactions (`cyc/stb/we/ack` handshakes).

---

## 🧰 Prerequisites

Install the following on **Ubuntu / WSL**:

```bash
sudo apt update
sudo apt install ghdl gtkwave
