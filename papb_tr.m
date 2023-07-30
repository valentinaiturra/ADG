function [pa_tr,pb_tr]=papb_tr(ventana, datos)
%funcion para tipo triangular

tr = triang(ventana); % de 12
trn = tr/sum(tr);

filt_tr = filtfilt(trn,1,datos);
pb_tr = filt_tr;

pasoa_tr = datos - pb_tr;
pa_tr = pasoa_tr;
