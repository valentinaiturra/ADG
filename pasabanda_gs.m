function [filtpbd_gsa,filtpbd_gsb] = pasabanda_gs(ventanaT1,ventanaT2, datos)
%funcion pasabanda para tipo rectangular, t2 debe ser menor ventana que t1

[pa_gsT1,pb_gsT1]=papb_gs(ventanaT1, datos);

[pa_gsT2,pb_gsT2]=papb_gs(ventanaT2, datos);

filtpbd_gsb = pb_gsT2 - pb_gsT1;
filtpbd_gsa = pa_gsT2 - pa_gsT1;

% filto pasa alto deja pasar altas frecuencias,
% en filtro pasa bajo se pone cercano a cero pues se extrae la media y
% queda centrada