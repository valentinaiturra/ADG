function [pa_rw,pb_rw]=papb_rw(ventana, datos)
%funcion para tipo rectangular

rw = rectwin(ventana); % de 12
rwn = rw/sum(rw);

filt_rw = filtfilt(rwn,1,datos);
pb_rw = filt_rw;

pasoa_rw = datos - pb_rw;
pa_rw = pasoa_rw;
