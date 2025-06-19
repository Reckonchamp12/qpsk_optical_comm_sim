# Optical QPSK Communication System Simulation

This repository simulates a complete optical Quadrature Phase Shift Keying (QPSK) communication system over a single-mode fiber (SMF) channel. It includes modeling of fiber dispersion, coherent detection, phase noise, frequency offset, and IQ imbalance correction.

## 📁 Project Structure

```
qpsk_optical_comm_sim/
├── main.m                     % Entry point for running the simulation
├── README.md                 % This file
├── .gitignore                % Files/folders to ignore in Git
├── LICENSE                   % MIT License
└── utils/                    % Modular components for simulation
    ├── QPSK_SIGNAL.m
    ├── QPSK_Demod.m
    ├── smf_channel_simulation.m
    ├── Optical_Hybrid.m
    ├── local_oscillator.m
    ├── freq_offset_compensation_block_ssb.m
    └── IQ_Imbalance_And_Correction.m
```

## 🚀 Features
- QPSK modulation and demodulation
- Single-mode fiber dispersion simulation
- OSNR-based noise addition
- Optical hybrid-based coherent detection
- Frequency offset estimation and compensation
- IQ imbalance simulation and correction (Gram-Schmidt)
- BER calculation
- Constellation plots

## 📦 Requirements
- MATLAB R2019b or newer

## ▶️ Usage
Clone the repository and run:
```matlab
main
```
Output includes constellation plots and Bit Error Rate (BER).

## 📊 Sample Output
- Scatter plot of IQ signal post-correction
- Printed BER in MATLAB console

## 📜 License
MIT License. See `LICENSE` file.
