function [y_r Y ]=generateSelfnoise(lenT,Fsout,Y)
% load precalcualted mean and covariance matrices
% that are from a number of anechoic recordings
% represents a range of possible micorphone preamp self noise
% Fs is 44100.
% Output vars
%y_r is the ouptut udsio
%Y is the power spectrum used to getner the noise
%inputs vars
% lenT is the required length in seconds
% Fsout is the reqruied sampling frequency
% Y is if you require the generation of a spectrum with a previoulsy
% computed power spectrum

load selfnoise Fs powerspec SIGMA X MU winN f



I=1:length(powerspec(1,:));
X=(powerspec(:,I));
SIGMA = cov(X);
MU=mean(X);
% if not supplied  a spectrum generate it
if nargin < 3
   Y = mvnrnd(MU,SIGMA,1);
end

B = fir2(winN,f/(Fs/2),10.^(Y'/20));
y=filter(B,1,randn(lenT*Fs,1));
y_r=resample(y,Fsout,Fs);

