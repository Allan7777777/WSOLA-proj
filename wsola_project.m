clear all; close all; clc;
%% Setup
[input_signal, fs] = audioread('Thieves_who_rob_friends_deserve_jail.wav');
info = audioinfo('Thieves_who_rob_friends_deserve_jail.wav');

%[input_signal, fs] = audioread('speech.wav');
%info = audioinfo('speech.wav');

%[input_signal, fs] = audioread('furelise.wav');
%info = audioinfo('furelise.wav');

fs = info.SampleRate;
input_length = info.TotalSamples; 

L=512; % L in samples
S = round(L/2); %overlap
TSR = 1.2;

Sout = S;
Sin = round(Sout*TSR);
win = hanning (L, 'periodic');
    
% definizione delta
    delta=10; % delta in ms
    deltamezzi=round(delta*fs/1000/2); %delta/2 in samples
    % deltamezzi=round(L*0.1/2) % calcolato come percentuale di L (10%)
    
% sistemo primo frame
    output_signal=zeros(floor(input_length/TSR+L),1);
    output_signal(1:L)=input_signal(1:L).*win;
    
    pid=1+S;
    pin=0;
    pout=0;    
%% ciclo while
    while (pid+L <= input_length) & (pin+L+deltamezzi+Sin <= input_length)
        fr_ideal=input_signal(pid:pid+L-1); % frame ideale da correlare
        pin=pin+Sin;% incremento Pin
        index=pin-deltamezzi; % indice partenza del frame reale da correlare
        fr_real=input_signal(index:pin+L-1+deltamezzi); % frame reale da correlare
        pout=pout+S; % incremento pout
 
% correlazione
        corr=xcorr(fr_real,fr_ideal);
        
        lfreal=L+deltamezzi*2;
               
        corr_string(1:2*deltamezzi+1)=corr(lfreal:lfreal+2*deltamezzi); % vettore lungo delta contiene i valori di correlazione che ci interessano
        deltamax=find(corr_string == max(corr_string)); % trovo delta con correlazione massima e sua posizione

% costruisco output
        frame_add=input_signal(pin-deltamezzi+deltamax:pin-deltamezzi+deltamax+L-1).*win;
        output_signal(pout:pout+L-1)=output_signal(pout:pout+L-1)+frame_add;
        
        pid=pin-deltamezzi+deltamax-1+S;
    end
    
%% esecuzione output
    soundsc(output_signal,fs);
    %audiowrite('thieves x2.wav',output_signal,fs);
    
%% stampa dei grafici

    figure(1);
        plot(input_signal,'r','LineWidth',2),xlabel('tempo'),ylabel('ampiezza'),axis tight;
    figure(2);
        plot(output_signal,'b','LineWidth',2),xlabel('tempo'),ylabel('ampiezza'),axis tight;
