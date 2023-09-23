%% Import Data
GrayMaterial = importdata("D:\Delft University of Technology\EE4630\TimeDomainInstruction\Group 1\Gray-525um-300avgs.txt") ;
TimeGray = GrayMaterial.data(:,1);
SignalGray = GrayMaterial.data(:,2);

Air = importdata("D:\Delft University of Technology\EE4630\TimeDomainInstruction\Group 1\Air-300avgs.txt") ;
TimeAir = Air.data(:,1);
SignalAir = Air.data(:,2);

%% Time Domain Processing: Instruction Lecture EE4730
close all

%% Constants
dGray = 525e-6 ;
SoL = 3e8 ;

%% Gray Material
Time_ps(isnan(Time_ps)) = 0 ;
THzSignal_Au(isnan(THzSignal_Au)) = 0 ;

figure
subplot(1,2,1)
hold on 
plot(TimeGray,SignalGray,'DisplayName','GrayMaterial') ;
plot(TimeAir,SignalAir,'DisplayName','Air') ;
hold off
xlabel('Time[ps]') ;
ylabel('Strength') ;
title('Gray Material,525um') ;
legend('Location','best')
xlim([-220 -180])
grid on
grid minor

[~,yG] = max(findpeaks(SignalGray) );
[~,yA] = max(findpeaks(SignalAir) ); 

tDif = ( TimeGray(yG)-TimeAir(yA) ) *1e-12 ;
er_G = (SoL .*(tDif+dGray/SoL)/dGray)^2 ;

fftGray = abs(fft( SignalGray ) ) ;
ssb_fftGray = fftGray(1:length(fftGray)/2) ;
dt = TimeGray(4) -  TimeGray(3);
BW = 1./dt ;

fftAir = abs(fft( SignalAir ) ) ;
ssb_fftAir = fftAir(1:length(fftAir)/2) ;
dt = TimeAir(4) -  TimeAir(3);
BWAir = 1./dt ;

subplot(1,2,2)
hold on
plot(10.*log10(ssb_fftGray) ,'DisplayName','GrayMaterial') ;
% plot(fft(abs(Gray525um300avgs.THzSignalau) ),'DisplayName','GrayMaterial') ;
plot(10.*log10(ssb_fftAir) ,'DisplayName','Air') ;
xlabel('Frequency[THz]') ;
ylabel('Strength') ;
title('Gray Material,525um') ;
legend('Location','best')
grid on
grid minor



% subplot(1,2,2)
% hold on
% plot(Gray525um300avgsfft.FrequencyTHz,Gray525um300avgsfft.THzSignalau,'DisplayName','GrayMaterial') ;
% plot(Air300avgsfft.FrequencyTHz,Air300avgsfft.THzSignalau,'DisplayName','Air') ;
% xlabel('Frequency[THz]') ;
% ylabel('Strength') ;
% title('Gray Material,525um') ;
% legend('Location','best')
% xlim([0 2])
% grid on
% grid minor
