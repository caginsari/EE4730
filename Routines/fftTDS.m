function [f,P1] = fftTDS(time,strength)

SignalLength = -time(length(time)) + time(1) ; 
f_samp = 30e12 ;
T = 1/f_samp ; 
% t = (0:SignalLength-1)*T;

Y = fft(strength) ;

P2 = abs(Y/SignalLength);
P1 = P2(1:SignalLength/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = f_samp*(0:(SignalLength/2))/SignalLength;

end
