function [FO_compensated,Freq_offset] = freq_offset_compensation_block_ssb(tx_pilot_signal, demod_pilot_signal, Fs)
    Tx_fft = fftshift(fft(tx_pilot_signal));
    Rx_fft = fftshift(fft(demod_pilot_signal));
    N_fft = length(tx_pilot_signal);
    f_fft = (-Fs/2:Fs/N_fft:Fs/2-Fs/N_fft);

    [~, idx_tx] = max(abs(Tx_fft));
    [~, idx_rx] = max(abs(Rx_fft));

    Tx_max_freq = f_fft(idx_tx);
    Rx_max_freq = f_fft(idx_rx);

    Freq_offset = Tx_max_freq - Rx_max_freq;

    t = (0:N_fft-1) / Fs;
    FO_compensated = demod_pilot_signal .* exp(1i * 2 * pi * Freq_offset * t);
end
