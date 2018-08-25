path = 'C:\Users\wangs\Documents\EE586\';
addpath(genpath(path))

clear; close all;clc;
time = 60;
div = 5;

[Origin,Fs] = audioread('She_is_my_Rosie.wav');

OriginL = Origin(:,1) * 10;
OriginR = Origin(:,2) * 10;

OriginL = LPF(OriginL, div, 64);
OriginR = LPF(OriginR, div, 64);

OriginL = OriginL(1:div:end - Fs / div);
OriginR = OriginR(1:div:end - Fs / div);
OriginL = OriginL(1 + Fs / div * 4:Fs / div * time + Fs / div * 4);
OriginR = OriginR(1 + Fs / div * 4:Fs / div * time + Fs / div * 4);

L = 128;
mu = 1;
delta = 64;

outL_SR = sancRLS_(OriginL,L,mu,delta);
resL_SR = outL_SR.filteredSignal;
outR_SR = sancRLS_(OriginR,L,mu,delta);
resR_SR = outR_SR.filteredSignal;

res_SR = [resL_SR resR_SR];
Original = [OriginL OriginR];

audiowrite('she_is_my_rosieorigin.wav',Original,Fs / div)
audiowrite('she_is_my_rosierecovered_srls.wav',res_SR,Fs / div)