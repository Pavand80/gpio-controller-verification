# GPIO Controller (RTL + Verification)

## 📌 Description

This project implements a **2-bit GPIO Controller** using SystemVerilog RTL with **bidirectional GPIO pins (inout)**. The controller supports configurable input/output operation, edge-based interrupt generation, interrupt clearing, and complete functional verification using a modular SystemVerilog testbench.

---

## ⚙️ Features

- Bidirectional GPIO (inout)
- Input / Output Direction Control
- Tri-State Driver
- Edge Detection
- Interrupt Generation
- Interrupt Clear
- IRQ Output
- SystemVerilog RTL
- Complete Verification Environment

---

## 🧠 RTL Architecture

![Block Diagram](docs/block%20diagram.png)

---

## 🔄 Flow Chart

![Flow Chart](docs/flow%20chart.png)

---

## 🧪 Verification Architecture

![Testbench Flow](docs/test%20bench%20flow%20diagram.png)

The verification environment includes:

- Generator
- Driver
- Monitor
- Interface
- Environment
- Scoreboard
- Transaction
- Test
- Top Module

---

## 📊 Simulation Output

The simulation verifies the complete functionality of the GPIO Controller.

Verified scenarios include:

- Reset Operation
- GPIO Direction Configuration
- Bidirectional GPIO Operation
- Tri-State (High-Z) Behavior
- Input Sampling
- Edge Detection
- Interrupt Generation
- Interrupt Clear Operation
- IRQ Assertion

### Simulation Waveform

![Waveform](results/waveform.png)
---

## 📁 Project Structure

```
rtl/      → RTL Design
svtb/     → SystemVerilog Verification Environment
docs/     → Block Diagram, Flow Chart, Testbench Diagram
results/  → Waveforms
README.md
```

---

## 🛠️ Tools Used

- SystemVerilog
- EDA Playground
- EPWave

---

## 🚀 Applications

- FPGA Designs
- Embedded Systems
- GPIO IP Development
- SoC Design
- Interrupt Controllers

---

## 🔮 Future Improvements

- APB Interface
- Parameterized GPIO Width
- Configurable Interrupt Types
- Debounce Logic

---

## 👨‍💻 Contributors

- Pavan D D
