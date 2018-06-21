clear all
close all


%Example - Generate Some microphone self noise of length lenT (seconds)
%using sampling rate Fs
lenT=1;
Fs=44100;

%Each result is random instance of microphone self noise 
% Y is the spectrum used
[y Y]=generateSelfnoise(lenT,Fs);

soundsc(y,Fs)

% in this case we use a previoulsy generated self noise spectrum Y (where
% Fs = 44100 and using a 512 point fft, (257 points, positive freqs and DC)
[y Y]=generateSelfnoise(lenT,Fs,Y);

soundsc(y,Fs)