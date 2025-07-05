# ⚡️ 32-bit Kogge-Stone Adder in Verilog

This project implements a **32-bit Kogge-Stone Adder**, a fast parallel-prefix adder used in CPUs and other high-speed arithmetic circuits.

---

## 🚀 Overview

**Kogge-Stone Adder** computes carries in **parallel**, rather than sequentially, enabling **logarithmic delay** compared to simpler ripple-carry adders.

**Key Features:**
- 32-bit Verilog implementation
- Parallel prefix tree combining generate and propagate signals
- Self-checking testbench
- Simulation waveform verification

---


---

## 🧩 How It Works

✅ **Pre-Processing:**
Computes **Generate (G)** and **Propagate (P)** signals for each bit.

✅ **Parallel Prefix Tree:**
Combines G/P pairs across multiple stages to pre-calculate all carries.

✅ **Post-Processing:**
XORs the carries with propagates to get the final sum.

---

## 🎯 Testbench

The included testbench covers:
- Zero operands
- Maximum operands
- Alternating bit patterns
- Carry-out overflow

✅ The simulation prints **PASS/FAIL** for each case.

---

## 🖥️ Simulation Waveform

![Waveform](docs/waveform.png)

✅ The waveform confirms correct carry propagation and sum computation.

---

## 🏗️ Schematic

This schematic shows the **parallel prefix tree structure**, with each cell combining carry information for faster addition.

---

## 🛠️ Usage

**Compile & Simulate:**
```bash
iverilog -o kogge_tb src/kogge_stone_adder.v src/kogge_stone_adder_tb.v
vvp kogge_tb





