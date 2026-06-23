%  acs_CO2.m: Adaptive buffering of spontaneous fluctuations in end-tidal FCO2
%  Here, a simple dynamic simulation of the chemoreflex control of ventilation
%    is used to represent the spontaneously breathing subject;
%  Parameters of the adaptive controller are to be selected to produce the
%    optimal pattern of inspired FCO2 that would minimize the fluctuations
%    in end-tidal FCO2; see Section 8.5.2.
% (Note: PaCO2 = FetCO2*7.13 and PICO2 = FICO2*7.13, where FetCO2, FICO2 are in %)
%  Results are shown in terms of fluctuations around the baseline level:
%     DFetCO2 : fluctuation in FetCO2
%     DFICO2  : fluctuation in FICO2
%     DVe     : fluctuation in Ventilation

% The subject "breathes" spontaneously during the first half of the experiment;
%  then, during the second half, the adaptive CO2 controller is switched on
% The performance of the controller can be assessed by comparing the variance
%  and power spectrum of the FetCO2 fluctuations before and after the adaptive
%  controller takes effect.

% Initialization: Assign parameter values to simulation model
T = 1/15; % breath duration (in mins)
Gp = 1; % peripheral chemoreflex gain (in liters/min/mm Hg)
Gc = 1; % central chemoreflex gain (in liters/min/mm Hg)
Ip = 36;  % peripheral apneic threshold (in mm Hg)
Ic = 36;  % central apneic threshold (in mm Hg)
taup = 1/3;  % time constant of peripheral chemoreflex response (in mins)
tauc = 1.75;  % time constant of central chemoreflex response (in mins)
Ndel = 3;  % lung-to-chemoreceptor delay (in number of breaths)
Termp = exp(-T/taup);
Termc = exp(-T/tauc);
PvCO2 = 45; % mixed venous blood CO2 partial pressure (in mm Hg)
Q = 6;  % cardiac output (in liters/min)
S = 0.0065;  % slope of the CO2 dissociation curve
VL = 3;  % resting lung volume (in liters)
Vdsdot = 2.25; % deadspace ventilation (liters/min)
cov = 20; % coefficient of variation (in %) of ventilation (system noise)
Fact1 = 863*Q*S;
Fact2 = Fact1*PvCO2;
PaCO2base = 40.48; %initial PaCO2 (= Fact2/(Vebase-Vdsdot+Fact1));
Vpbase = 4.48; %initial peripheral ventilation component (=Gp*(PaCO2base - Ip));
Vcbase = 4.48; %initial central ventilation component (= Gc*(PaCO2base - Ic));
Vebase = 8.96; %initial ventilation (=Vpbase + Vcbase);
FICO2base = 2.5; % mean level of FICO2

a = 0.66; % initial "guess" of plant model parameters
b = -0.02; % initial "guess" of plant model parameters
c = 0.69; % initial "guess" of plant model parameters
theta = [a b c]'; % initialize parameter vector

% User inputs
disp(' ');
%alpha = input(' Enter alpha >> ');
%beta = input(' Enter beta >>');
%lambda = input(' Enter forgetting factor (range:0.97-0.995)>>');
N = 400; % Number of breaths in experiment
close all;

% Initialization
DFetCO2 = zeros(N,1);
DVe = zeros(N,1);
DFICO2 = zeros(N,1);
FetCO2=ones(N,1)*PaCO2base/7.13;
Ve=Vebase;
y = zeros(3,1);
wnoise = randn(N,1); wnoise = wnoise/std(wnoise);wnoise = wnoise*Vebase*cov/100;
t = [1:1:N]';
P0 = 100; % Initial parameter error variance
P = [P0 0 0; 0 P0 0; 0 0 P0]; % Initialize parameter error covariance matrix
figure(1);
subplot(2,1,1); axis([0 N 0 1]); ylabel('Est Param Var'); hold on;
subplot(2,1,2); axis([0 N -1 1]); ylabel('Est Plant Param'); 
xlabel(' Time (# breaths)'); hold on;

for i=1:N,
   
if i > N/2   
% Determine current output of adaptive controller, given past values of DFetCO2, 
%   DVe, a, b and c
   if i==1
      DFICO2(i) = 0;
   else
      DFICO2(i) = (-alpha^2*c/(alpha^2*c^2 + beta^2))*(a*DFetCO2(i-1) + b*DVe(i-1));  
   end
      
% Change in Predicted FetCO2
   if i==1
      DFetCO2pred = 0;
   else
      DFetCO2pred = a*DFetCO2(i-1) + b*DVe(i-1) + c*DFICO2(i);
   end;
   
% Form y-vector
   if i>1
      y = [DFetCO2(i-1) DVe(i-1) DFICO2(i)]';
   end;
end;  % if i > N/2 
   
% Simulation of chemoreflex control of ventilation (generate "observed" DFetCO2)
% Controller
   if i <= Ndel
      DPaCO2p = PaCO2base-Ip;
      DPaCO2c = PaCO2base-Ic;
   else
      DPaCO2p = FetCO2(i-Ndel)*7.13-Ip;
      DPaCO2c = FetCO2(i-Ndel)*7.13-Ic;
   end;
   if DPaCO2p < 0
      DPaCO2p = 0;
   end;
   if DPaCO2c < 0
      DPaCO2c = 0;
   end;
   if i==1
      Vp = Termp*Vpbase + Gp*DPaCO2p*(1-Termp);
      Vc = Termc*Vcbase + Gc*DPaCO2c*(1-Termc);
   else
      Vp = Termp*Vp + Gp*DPaCO2p*(1-Termp);
      Vc = Termc*Vc + Gc*DPaCO2c*(1-Termc);
   end;
   if Vp < 0
       Vp = 0;
   end;
   if Vc < 0
       Vc = 0;
   end;
   Ve = Vp + Vc + wnoise(i);
   DVe(i) = Ve - Vebase;
% Plant
   FICO2 = DFICO2(i) + FICO2base;
   VA = Ve - Vdsdot;
   if VA < 0
      VA = 0;
   end;
   tau = VL/(VA + Fact1);
   Fact3 = exp(-T/tau);
   if i==1 
      FetCO2(i) = Fact3*PaCO2base/7.13 + (1-Fact3)*(VA*FICO2+Fact2/7.13)/(VA + Fact1);
   else
      FetCO2(i) = Fact3*FetCO2(i-1) + (1-Fact3)*(VA*FICO2+Fact2/7.13)/(VA + Fact1);
   end;
   DFetCO2(i) = FetCO2(i) - PaCO2base/7.13;
   
if i > N/2   
% Error(difference) between "observed" FetCO2 and "predicted" FetCO2
   e = DFetCO2(i) - DFetCO2pred;

% Update gain vector
   den = lambda + y'*P*y;
   K = P*y/den;
   
% Update parameter vector
	theta = theta + K*e;
   a = theta(1); b = theta(2); c = theta(3);
   
%  Update parameter error covariance matrix
   P = (P - P*y*y'*P/den)/lambda;
   
%  Plot results   
subplot(2,1,1); plot(t(i),P(1,1)/P0,'*',t(i),P(2,2)/P0,'+',t(i),P(3,3)/P0,'x'); 
subplot(2,1,2); plot(t(i),a,'*',t(i),b,'+',t(i),c,'x');
end;  % if i > N/2

end; % for i=1:N

figure(2);
subplot(3,1,1); axis([0 N -0.5 0.5]);plot(t,DFetCO2);ylabel('DFetCO2 (%)');
subplot(3,1,2); axis([0 N -5 5]);plot(t,DVe);ylabel('DVe (L/min)');
subplot(3,1,3); axis([0 N -0.5 0.5]);plot(t,DFICO2);ylabel('DFICO2 (%)');
 xlabel(' Time (# of breaths)');

% Compare std.dev of FetCO2 fluctuations before and after adaptive control
disp(' Std. deviation of spontaneous FetCO2 fluctuations:');std(DFetCO2(1:N/2))
disp(' Std. deviation of controlled FetCO2 fluctuations:');std(DFetCO2(N/2+1:N))
 
% Compare power spectra of FetCO2 fluctuations before and after adaptive control
PSbefore= fft(DFetCO2(1:N/2)).*conj(fft(DFetCO2(1:N/2)))/(N/2);
PSafter= fft(DFetCO2(N/2+1:N)).*conj(fft(DFetCO2(N/2+1:N)))/(N/2);
freq = [0:2/N:0.5-2/N]';
PSbefore=PSbefore(1:length(freq));
PSafter=PSafter(1:length(freq));
figure(3);
plot(freq,PSbefore,freq,PSafter);xlabel(' Frequency in Hz');
title('DFetCO2 Spectrum before (blue) and during (green) adaptive control');


