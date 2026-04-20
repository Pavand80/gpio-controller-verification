# GPIO Controller (RTL + Verification)

## 📌 Description
This project implements a GPIO (General Purpose Input/Output) controller using SystemVerilog RTL and verifies it using a complete end-to-end SystemVerilog testbench architecture.

## ⚙️ Features
- GPIO direction control (input/output)
- Input sampling and output driving
- Interrupt generation support
- Configurable GPIO behavior

## 🧠 RTL Architecture
![Block Diagram](docs/block_diagram.png)

## 🔄 Verification Flow
![Testbench Flow](docs/tb_flow_diagram.png)

## 📊 Flowchart
![Flowchart](docs/flowchart.png)

## 🧪 Verification Overview
The design is verified using a modular SystemVerilog testbench including:
- Generator → creates stimulus
- Driver → drives inputs to DUT
- Monitor → observes outputs
- Scoreboard → checks correctness
- Environment → connects all components

## 🛠️ Current Status
- RTL design completed
- Testbench architecture designed
- Full verification files will be organized and added

## 📁 Project Structure
- rtl/ → RTL design files  
- docs/ → Block diagram, flow diagram, flowchart  
- tb/ → (To be added: verification environment)

## 👨‍💻 Contributors
- Pavan
