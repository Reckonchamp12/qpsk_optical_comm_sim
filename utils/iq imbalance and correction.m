function [I_corr, Q_corr, rx_corrected] = IQ_Imbalance_And_Correction(current_upper, current_lower)
    gain_imbalance = 2;
    phase_imbalance_deg = 30;
    theta = deg2rad(phase_imbalance_deg);

    I_imb = current_upper;
    Q_imb = gain_imbalance * (cos(theta) * current_lower + sin(theta) * current_upper);

    % Gram-Schmidt Orthogonalization
    I_corr = I_imb;
    proj_Q_on_I = (dot(Q_imb, I_corr) / dot(I_corr, I_corr)) * I_corr;
    Q_orth = Q_imb - proj_Q_on_I;
    
    I_corr = I_corr / norm(I_corr);
    Q_corr = Q_orth / norm(Q_orth);

    rx_corrected = I_corr + 1j * Q_corr;
end
