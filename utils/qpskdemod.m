function Recovered_Bit_Stream = QPSK_Demod(signal, SYMBOL_SIZE)
    bits_real = real(signal) > 0;
    bits_imag = imag(signal) > 0;
    Recovered_Bit_Stream = zeros(1, 2 * SYMBOL_SIZE);
    Recovered_Bit_Stream(1:2:end) = bits_real;
    Recovered_Bit_Stream(2:2:end) = bits_imag;
end
