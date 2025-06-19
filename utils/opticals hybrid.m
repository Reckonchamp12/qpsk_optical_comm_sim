function [current_upper, current_lower] = Optical_Hybrid(E_sig, E_LO)
    % Mix incoming signal and LO (balanced detection)
    E_combined1 = E_sig + E_LO;
    E_combined2 = E_sig - E_LO;
    current_upper = abs(E_combined1).^2;
    current_lower = abs(E_combined2).^2;
end
