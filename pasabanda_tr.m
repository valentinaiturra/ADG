function [filtpbd_tra,filtpbd_trb] = pasabanda_tr(ventanaT1,ventanaT2, datos)
%funcion pasabanda para tipo rectangular, t2 debe ser menor ventana que 31

[pa_trT1,pb_trT1]=papb_tr(ventanaT1, datos);

[pa_trT2,pb_trT2]=papb_tr(ventanaT2, datos);

filtpbd_trb = pb_trT2 - pb_trT1;
filtpbd_tra = pa_trT2 - pa_trT1;