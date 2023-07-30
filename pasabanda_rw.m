function [filtpbd_rwa,filtpbd_rwb] = pasabanda_rw(ventanaT1,ventanaT2, datos)
%funcion pasabanda para tipo rectangular, t2 debe ser menor ventana que 31

[pa_rwT1,pb_rwT1]=papb_rw(ventanaT1, datos);

[pa_rwT2,pb_rwT2]=papb_rw(ventanaT2, datos);


filtpbd_rwb = pb_rwT2 - pb_rwT1;
filtpbd_rwa = pa_rwT2 - pa_rwT1;
