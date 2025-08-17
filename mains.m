clear; close all; clc;
addpath('utils');

%% Simulation Parameters
no_of_bits = 20000;
samples_per_symbol = 7;
SYMBOL_SIZE = no_of_bits / 2;
bit_pattern = randi([0 1], 1, no_of_bits);

%% QPSK Signal Generation
Pulse_peak_power = -10; % in dBm
Fm = 100e6; % modulation rate (bit rate)
Duty_ratio = 1;
launched_signal = QPSK_SIGNAL(Fm, Duty_ratio, samples_per_symbol, bit_pattern, Pulse_peak_power);

%% SMF Channel Simulation
signal_after_fiber = smf_channel_simulation(launched_signal);

%% Add AWGN for Required OSNR
Required_OSNR = 18;
P_peak_lin = (10^(Pulse_peak_power / 10)) * 1e-3;
signal_power = P_peak_lin;
noise_power = signal_power / (10^(Required_OSNR / 10));
noise = sqrt(noise_power / 2) * (randn(size(signal_after_fiber)) + 1i * randn(size(signal_after_fiber)));
signal_noisy = signal_after_fiber + noise;

%% Coherent Detection (Optical Hybrid with LO)
N = length(signal_noisy);
E_LO = local_oscillator(N, Pulse_peak_power);
[current_upper, current_lower] = Optical_Hybrid(signal_noisy, E_LO);
demod_signal = current_upper + 1i * current_lower;

%% Frequency Offset Compensation
[compensated_signal, Freq_offset] = freq_offset_compensation_block_ssb(launched_signal, demod_signal, 2.5e9);

%% IQ Imbalance Correction
[current_upper, current_lower] = deal(real(compensated_signal), imag(compensated_signal));
[I_corr, Q_corr, rx_corrected] = IQ_Imbalance_And_Correction(current_upper, current_lower);

%% Sampling and Demodulation
sample_position = 3;
bit_pointer = 1;
upper_arm_sampled_current = zeros(1, round(SYMBOL_SIZE));
lower_arm_sampled_current = zeros(1, round(SYMBOL_SIZE));
for i = 1:SYMBOL_SIZE
    upper_arm_sampled_current(i) = I_corr(((bit_pointer - 1) * samples_per_symbol) + sample_position);
    lower_arm_sampled_current(i) = Q_corr(((bit_pointer - 1) * samples_per_symbol) + sample_position);
    bit_pointer = bit_pointer + 1;
end
down_sample_current_values = upper_arm_sampled_current + 1i * lower_arm_sampled_current;
Recovered_Bit_Stream = QPSK_Demod(down_sample_current_values, SYMBOL_SIZE);

%% BER Calculation
Error_bits = sum(xor(Recovered_Bit_Stream, bit_pattern));
BER = Error_bits / no_of_bits;

%% Output Results
fprintf('Bit Error Rate (BER): %.6f\n', BER);
scatterplot(rx_corrected);
title('Corrected Signal after IQ Imbalance and FO Compensation');
