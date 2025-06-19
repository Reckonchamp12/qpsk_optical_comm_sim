function E_LO = local_oscillator(N, Pulse_peak_power)
    Freq_offset = 0.03; % GHz
    P_peak_lin = (10^(Pulse_peak_power / 10)) * 1e-3;
    Fs = 2.5e9;
    t = (0:N-1) / Fs;
    E_LO = 10 * sqrt(P_peak_lin) .* exp(1i * (2 * pi * Freq_offset * 1e9 * t));
end
