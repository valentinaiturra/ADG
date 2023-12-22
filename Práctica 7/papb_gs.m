function [pa_gs,pb_gs]=papb_gs(ventana, datos)
%funcion para tipo gaussiana

gs = gausswin(ventana); % de 12
gsn = gs/sum(gs);

filt_gs = filtfilt(gsn,1,datos);
pb_gs = filt_gs;

pasoa_gs = datos - pb_gs;
pa_gs = pasoa_gs;
