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

## 📊 Simulation

Simulation completed using:

- EDA Playground
- EPWave

### Simulation Link

https://www.edaplayground.com/x/YW2c

### Simulation Output

The waveform verifies the following functionalities:

- Reset Operation
- Bidirectional GPIO Configuration
- Input / Output Direction Control
- Tri-State (High-Z) Operation
- Input Sampling
- Edge Detection
- Interrupt Generation
- Interrupt Clear
- IRQ Assertion

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
