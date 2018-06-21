%% microphone self noise simulation
% This file generates the self noise model, by computing spectra of anechoic records where there is silence.
clear all
close all
Fs=44100;
dirSTR='noises\';
wavs=dir([dirSTR '*.wav']);
% power spec window length
winN=512;

%reads in noise files
for i=1:length(wavs)
    str{i}= num2str(i);
    [y Fs1]=audioread([ dirSTR wavs(i).name]);
    Fs1;
    y=resample(y,Fs,Fs1);
    y=[y;y;y];
    
    y=y/sqrt(mean(y.^2)); 
%     [p,f] = oct3bank(y,Fs); 
    [p,f]=pwelch(y,hanning(winN),[],[],Fs); 
    p=10*log10(p);
    powerspec(i,:)=p;
% pause(0.1)
end
%%  Plot all the spectra
clear powerspecs
for i=1:length(wavs)
        powerspecs(i,:)=smooth(powerspec(i,:),1);

end
    plot(f,powerspecs)

     legend(str,'Orientation','Horizontal')
     ylabel('Magnitude (dB)','fontsize',14)
     xlabel('Frequency (Hz)','fontsize',14)
     ax = gca;
     set(gca,'XTick',[63.5 125  250  500 1000 2000 4000 8000 16000]); % Preferred labeling freq. 
   set(gca,'xscale','log')
   set(gca,'fontsize',14)
     xlim([0 22000])
     ylim([-85 0])
%% compute the model
I=1:length(powerspec(1,:));
X=(powerspec(:,I));
SIGMA = cov(X);
MU=mean(X);
%save selfnoise Fs Y powerspec SIGMA X MU Y winN f


%Generate some self noise of length (s) lenT
lenT=1;
[y Fs MU SIGMA]=generateSelfnoise(lenT);
%%

% Y = mvnrnd(MU,SIGMA,10);
% 
% 
%  plot(f,(Y),'k')
%      xlim([0 22000])
%      ylim([-85 0])
% %      legend(str,'Orientation','Horizontal')
%      ylabel('Magnitude (dB)','fontsize',14)
%      xlabel('Frequency (Hz)','fontsize',14)
%      ax = gca;
%      set(gca,'XTick',[63.5 125  250  500 1000 2000 4000 8000 16000]); % Preferred labeling freq. 
%    set(gca,'xscale','log')
%    set(gca,'fontsize',14)
%%
% options = statset('Display','final');
% obj = gmdistribution.fit(X,1,'Options',options);
% 
% Y = random(obj,10);
% semilogx(f(I),Y,'g')
% hold on
% semilogx(f(I),powerspec(:,I),'r') 
% hold off
% F=f;
% for i=3%:10
%         [  wavs(i).name]
% B = fir2(winN,f/(Fs/2),10.^(Y(i,:)'/20));
% y=filter(B,1,randn(1*Fs,1));
% [p,f]=pwelch(y,hanning(winN),[],[],Fs); 
% p=10*log10(p);
%      semilogx(f(I),Y(i,:),'g')
% hold on 
%      semilogx(f,(p))
% hold off
% end
% 
% sound(y*0.5,Fs)