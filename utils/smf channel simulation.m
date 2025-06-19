function signal_out = smf_channel_simulation(UzT)
    SMF_length = 1;
    lambda = 1550e-9;
    D_SMF = 0.17e-3;
    S_SMF = 0.0578e6;
    Gamma_SMF = 0;  % Assuming no nonlinearity
    attn_SMF = 0.2;
    alpha_SMF = 10^(attn_SMF / 10);
    c = 299792458;
    Beta2_SMF = -((D_SMF * (lambda^2)) / (2 * pi * c));
    Beta3_SMF = ((S_SMF * (lambda^4)) / ((2 * pi * c)^2)) - ((lambda * Beta2_SMF) / (pi * c));

    N = length(UzT);
    Fs = 2.5e9;
    freq_step = Fs / N;
    x = 0:N-1;
    TrF_Dis_SMF = exp(((1i * SMF_length * Beta2_SMF * ((2 * pi * x * freq_step - (2 * pi * Fs / 2)).^2)) / 2) - ((1i * Beta3_SMF * SMF_length * ((2 * pi * x * freq_step - (2 * pi * Fs / 2)).^3)) / 6));

    for step = 1:SMF_length
        U0W = fftshift(fft(UzT));
        U0W = U0W .* TrF_Dis_SMF;
        UzT = ifft(fftshift(U0W));
        UzT = UzT .* exp(-SMF_length * alpha_SMF / 2);
    end

    signal_out = UzT;
end
