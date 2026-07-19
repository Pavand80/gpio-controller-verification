# GPIO Controller with Bidirectional I/O (RTL + Verification)

## 📌 Description

This project implements a **2-bit GPIO (General Purpose Input/Output) Controller** in SystemVerilog featuring true **bidirectional GPIO pins** using tri-state logic. The controller supports configurable input/output modes, edge-based interrupt generation, interrupt clearing, and a complete end-to-end SystemVerilog verification environment.

The design is fully synthesizable and verified through simulation using EDA Playground and EPWave.

---

## ⚙️ Features

- 2-bit Bidirectional GPIO Interface (`inout gpio_pin`)
- Configurable Input / Output Direction
- Tri-State Output Driver
- Input Sampling Logic
- Rising/Falling Edge Detection
- Interrupt Enable & Status Registers
- Interrupt Clear Mechanism
- Global IRQ Generation
- Fully Synthesizable RTL
- Complete SystemVerilog Verification

---

# 🧠 RTL Architecture

<p align="center">
    <img src="docs/block diagram.png" width="900">
</p>

The GPIO controller consists of:

- Direction Register
- Output Register
- Tri-State Driver
- Input Sampler
- Edge Detection Logic
- Interrupt Controller
- IRQ Generator

---

# 🔄 GPIO Operation Flow

<p align="center">
    <img src="docs/flow chart.png" width="700">
</p>

Operation sequence:

1. Reset initializes internal registers.
2. Direction register configures each GPIO pin.
3. Output mode drives data onto GPIO pins.
4. Input mode releases pins into High-Z.
5. Input sampler captures GPIO values.
6. Edge detector compares current and previous samples.
7. Interrupt status is updated.
8. IRQ is generated when enabled interrupts are active.

---

# 🧪 Verification Architecture

<p align="center">
    <img src="docs/test bench flow diagram.png" width="900">
</p>

The verification environment includes:

- Generator
- Mailbox
- Driver
- Interface
- DUT
- Monitor
- Coverage
- Scoreboard

This architecture verifies:

- Input Mode
- Output Mode
- Bidirectional GPIO Behaviour
- Edge Detection
- Interrupt Generation
- Interrupt Clear
- IRQ Assertion

---

# 📊 Simulation

Simulation performed using:

- EDA Playground
- EPWave

### Simulation Link

https://www.edaplayground.com/x/YW2c

Waveforms verify:

- Direction Switching
- Tri-State GPIO Behaviour
- Input Sampling
- Edge Detection
- Interrupt Status Update
- IRQ Generation

---

# 📁 Project Structure

```
rtl/
    gpio_controller.sv

tb/
    SystemVerilog Testbench

docs/
    block diagram.png
    flow chart.png
    test bench flow diagram.png

results/
    Waveforms

README.md
```

---

# 🛠️ Tools Used

- SystemVerilog
- EDA Playground
- EPWave
- QuestaSim (Compatible)

---

# 🚀 Applications

- FPGA Designs
- Embedded Systems
- SoC Peripheral Design
- GPIO IP Development
- Interrupt Controllers
- Digital System Verification

---

# 🔮 Future Improvements

- Parameterized GPIO Width
- APB/AHB Bus Interface
- Configurable Edge Selection
- Debounce Logic
- Low-Power GPIO Support

---

# 👨‍💻 Contributor

**Pavan D D**

---

## ⭐ If you found this project useful, consider giving it a Star.
