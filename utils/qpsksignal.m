function launched_signal = QPSK_SIGNAL(Fm, Duty_ratio, samples_per_symbol, bit_pattern, Pulse_peak_power)
    SYMBOL_SIZE = length(bit_pattern) / 2;
    symbols = (2*bit_pattern(1:2:end)-1) + 1j*(2*bit_pattern(2:2:end)-1);

    P_peak_lin = (10^(Pulse_peak_power / 10)) * 1e-3;
    norm_factor = sqrt(P_peak_lin/2);
    symbols = symbols * norm_factor;

    upsampled = zeros(SYMBOL_SIZE * samples_per_symbol, 1);
    upsampled(1:samples_per_symbol:end) = symbols;

    pulse_shape = ones(samples_per_symbol, 1);
    launched_signal = conv(upsampled, pulse_shape, 'same');
end
