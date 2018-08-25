clc;
clear all;

LEN_FILTER = 768
MU = 0.001
DELAY = 384


[audio,fs] = audioread('./old_songs/1918_swedish_cradle_song.wav');
audio = audio(:,1);

processed_signal = sanc(audio,LEN_FILTER,MU,DELAY);
recovered_signal = processed_signal.filteredSignal;

audiowrite('1918_swedish_cradle_song_recovered.wav',recovered_signal,fs);





