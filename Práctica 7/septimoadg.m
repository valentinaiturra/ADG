clc
clear all
close all
datos = load('carriel_sur.mat');
temp = datos.temp_concepcion(:,4);
fecha = datos.tiempo;
%% Para la rectangular
[pa_rw1,pb_rw1]=papb_rw(30, temp);
[pa_rw2,pb_rw2]=papb_rw(365, temp);
[pa_rw3,pb_rw3]=papb_rw(830, temp);

[filtpbd_rwa,filtpbd_rwb] = pasabanda_rw(365,30, temp);

%% Para la triangular
[pa_tr1,pb_tr1]=papb_tr(30, temp);
[pa_tr2,pb_tr2]=papb_tr(365, temp);
[pa_tr3,pb_tr3]=papb_tr(830, temp);

[filtpbd_tra,filtpbd_trb] = pasabanda_tr(365,30, temp);

%% Para la gaussiana
[pa_gs1,pb_gs1]=papb_gs(30, temp);
[pa_gs2,pb_gs2]=papb_gs(365, temp);
[pa_gs3,pb_gs3]=papb_gs(830, temp);

[filtpbd_gsa,filtpbd_gsb] = pasabanda_gs(365,30, temp);

%% Media movil

[mediamovil,~]=mmsm(temp,1,365);
tiempomovil = fecha(:,1+182:end-182);

%%
figure()
plot(fecha, temp)
hold on
plot(tiempomovil,mediamovil,'LineWidth',2)
plot(fecha, pa_tr2)
xlabel('Tiempo [años]')
ylabel('Temperatura [°C]')
title('Filtro pasoalto triangular')
axis tight
legend('Datos','Media movil','Filtro','Location','best')

figure()
plot(fecha, temp)
hold on
plot(fecha, pb_tr2,'LineWidth',2)
xlabel('Tiempo [años]')
ylabel('Temperatura [°C]')
title('Filtro pasobajo triangular')
axis tight
legend('Datos','Filtro','Location','best')

%GRAFICAR LA PASABANDA BAJA
figure()
plot(fecha, temp)
hold on
plot(fecha,filtpbd_trb)
