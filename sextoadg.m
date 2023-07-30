%En este lugar se encuentran filtros, filtfilt(rectangular, triangular y
%gaussiana), filter, paso alto y pasabanda.

load Practica_230523.mat

tiempo = B(:,1);
hielo = B(:,2);
%Un tipo de filtro puede ser la media movil, otro tipo es filtfilt,
%rectwin, filter

%% Ventana Rectangular

rw1 = rectwin(12); % de 12
rwn1 = rw1/sum(rw1);

rw2 = rectwin(31); % de 31
rwn2 = rw2/sum(rw2);

rw3 = rectwin(61); % de 61
rwn3 = rw3/sum(rw3);

%Los filtros
filt_rw1 = filtfilt(rwn1,1,hielo);
filt_rw2 = filtfilt(rwn2,1,hielo);
filt_rw3 = filtfilt(rwn3,1,hielo);

figure()
plot(tiempo, hielo,'LineWidth',2)
hold on
plot(tiempo,filt_rw1,'LineWidth',2)
plot(tiempo,filt_rw2,'LineWidth',2)
plot(tiempo,filt_rw3,'LineWidth',2)
axis tight
grid on
legend('Datos originales','Ventana de 12','Ventana de 31','Ventana de 61','Location','bestoutside')
title('Filtro serie extension de hielo con ventana rectangular')
xlabel('Tiempo [años]')
%Existen efectos de borde en que se imagina datos que no son existentes,
%este es un filtro pasa baja, pues pasa las frecuencias menores, hay muy
%pocas curvas.

%% Ventana triangular

tr1 = triang(12); % de 12
trn1 = tr1/sum(tr1);

tr2 = triang(31); % de 31
trn2 = tr2/sum(tr2);

tr3 = triang(61); % de 61
trn3 = tr3/sum(tr3);


filt_tr1 = filtfilt(trn1,1,hielo);
filt_tr2 = filtfilt(trn2,1,hielo);
filt_tr3 = filtfilt(trn3,1,hielo);

figure()
plot(tiempo, hielo,'LineWidth',2)
hold on
plot(tiempo,filt_tr1,'LineWidth',2)
plot(tiempo,filt_tr2,'LineWidth',2)
plot(tiempo,filt_tr3,'LineWidth',2)
axis tight
grid on
legend('Datos originales','Ventana de 12','Ventana de 31','Ventana de 61','Location','bestoutside')
title('Filtro serie extension de hielo con ventana triangular')
xlabel('Tiempo [años]')

%% Ventana gaussiana

gs1 = gausswin(12); % de 12
gsn1 = gs1/sum(gs1);

gs2 = gausswin(31); % de 31
gsn2 = gs2/sum(gs2);

gs3 = gausswin(61); % de 61
gsn3 = gs3/sum(gs3);

filt_gs1 = filtfilt(gsn1,1,hielo);
filt_gs2 = filtfilt(gsn2,1,hielo);
filt_gs3 = filtfilt(gsn3,1,hielo);

figure()
plot(tiempo, hielo,'LineWidth',2)
hold on
plot(tiempo,filt_gs1,'LineWidth',2)
plot(tiempo,filt_gs2,'LineWidth',2)
plot(tiempo,filt_gs3,'LineWidth',2)
axis tight
grid on
legend('Datos originales','Ventana de 12','Ventana de 31','Ventana de 61','Location','bestoutside')
title('Filtro serie extension de hielo con ventana gaussiana')
xlabel('Tiempo [años]')

%% Comparacion ventana 12

figure()
plot(tiempo,hielo,'LineWidth',2)
hold on
plot(tiempo,filt_rw1,'LineWidth',2)
plot(tiempo,filt_tr1,'LineWidth',2)
plot(tiempo,filt_gs1,'LineWidth',2)
axis tight
grid on
legend('Original','Rectangular','Triangular','Gaussiano','Location','bestoutside')
title('Comparacion filtro serie extension de hielo con ventana 12')
xlabel('Tiempo [años]')

%% Comparacion ventana 31
figure()
plot(tiempo,hielo,'LineWidth',2)
hold on
plot(tiempo,filt_rw2,'LineWidth',2)
plot(tiempo,filt_tr2,'LineWidth',2)
plot(tiempo,filt_gs2,'LineWidth',2)
axis tight
grid on
legend('Original','Rectangular','Triangular','Gaussiano','Location','bestoutside')
title('Comparacion filtro serie extension de hielo con ventana 31')
xlabel('Tiempo [años]')

%% Comparacion ventana 61
figure()
plot(tiempo,hielo,'LineWidth',2)
hold on
plot(tiempo,filt_rw3,'LineWidth',2)
plot(tiempo,filt_tr3,'LineWidth',2)
plot(tiempo,filt_gs3,'LineWidth',2)
axis tight
grid on
legend('Original','Rectangular','Triangular','Gaussiano','Location','bestoutside')
title('Comparacion filtro serie extension de hielo con ventana 61')
xlabel('Tiempo [años]')

%% comando filter

filtr_rw = filter(rwn1,1,hielo);
filtr_tr = filter(trn1,1,hielo);
filtr_gs = filter(gsn1,1,hielo);

figure()
subplot(3,1,1)
plot(tiempo,hielo,'LineWidth',2)
hold on
plot(tiempo,filt_rw1,'LineWidth',2)
plot(tiempo,filtr_rw,'LineWidth',2)
axis tight
grid minor
title('Comparación filtro serie de extension de hielo con ventana de 12 ')
legend('Datos originales','Comando filtfilt','Comando filter','Location','bestoutside')
xlabel('Tiempo [Años]')

subplot(3,1,2)
plot(tiempo,hielo,'LineWidth',2)
hold on
plot(tiempo,filt_tr1,'LineWidth',2)
plot(tiempo,filtr_tr,'LineWidth',2)
axis tight
grid minor
title('Comparación filtro serie de extension de hielo con ventana de 12 ')
legend('Datos originales','Comando filtfilt','Comando filter','Location','bestoutside')
xlabel('Tiempo [Años]')

subplot(3,1,3)
plot(tiempo,hielo,'LineWidth',2)
hold on
plot(tiempo,filt_gs1,'LineWidth',2)
plot(tiempo,filtr_gs,'LineWidth',2)
axis tight
grid minor
title('Comparación filtro serie de extension de hielo con ventana de 12 ')
legend('Datos originales','Comando filtfilt','Comando filter','Location','bestoutside')
xlabel('Tiempo [Años]')

%Este es diferente pues va en una sola direccion , en filtros se puede
%perder amplitud, frecuencia y face. en este caso se cambia la fase, en el
%caso de la de 12 se deben eliminar los 6 primeros y ultimos para no
%incluir los efectos de borde. En cambio filtfilt va para ambos
%direcciones, derecha e izquierda

%% Filtro paso alto Rectangular
%pasoalto + pasobajo = datos

pasoa_rw1 = hielo - filt_rw1;
pasoa_rw2 = hielo - filt_rw2;
pasoa_rw3 = hielo - filt_rw3;

figure()
subplot(4,1,1)
    plot(tiempo, hielo,'LineWidth',2)
    axis tight
    grid on
    title('Serie original')
    xlabel('Tiempo [Años]')
subplot(4,1,2)
    plot(tiempo,pasoa_rw1,'r','LineWidth',2)
    axis tight
    grid on
    title('Filtro paso alto ventana rectangular de 12')
    xlabel('Tiempo [Años]')
subplot(4,1,3)
    plot(tiempo,pasoa_rw2,'r','LineWidth',2)
    axis tight
    grid on
    title('Filtro paso alto ventana rectangular de 31')
    xlabel('Tiempo [Años]')
subplot(4,1,4)
    plot(tiempo,pasoa_rw3,'r','LineWidth',2)
    axis tight
    grid on
    title('Filtro paso alto ventana rectangular de 61')
    xlabel('Tiempo [Años]')

%% Filtro paso alto Triangular
pasoa_tr1 = hielo - filt_tr1;
pasoa_tr2 = hielo - filt_tr2;
pasoa_tr3 = hielo - filt_tr3;

figure()
subplot(4,1,1)
    plot(tiempo, hielo,'LineWidth',2)
    axis tight
    grid on
    title('Serie original')
    xlabel('Tiempo [Años]')
subplot(4,1,2)
    plot(tiempo,pasoa_tr1,'r','LineWidth',2)
    axis tight
    grid on
    title('Filtro paso alto ventana triangular de 12')
    xlabel('Tiempo [Años]')
subplot(4,1,3)
    plot(tiempo,pasoa_tr2,'r','LineWidth',2)
    axis tight
    grid on
    title('Filtro paso alto ventana triangular de 31')
    xlabel('Tiempo [Años]')
subplot(4,1,4)
    plot(tiempo,pasoa_tr3,'r','LineWidth',2)
    axis tight
    grid on
    title('Filtro paso alto ventana triangular de 61')
    xlabel('Tiempo [Años]')

%% Filtro paso alto Gaussiano
pasoa_gs1 = hielo - filt_gs1;
pasoa_gs2 = hielo - filt_gs2;
pasoa_gs3 = hielo - filt_gs3;

figure()
subplot(4,1,1)
    plot(tiempo, hielo,'LineWidth',2)
    axis tight
    grid on
    title('Serie original')
    xlabel('Tiempo [Años]')
subplot(4,1,2)
    plot(tiempo,pasoa_gs1,'r','LineWidth',2)
    axis tight
    grid on
    title('Filtro paso alto ventana gaussiana de 12')
    xlabel('Tiempo [Años]')
subplot(4,1,3)
    plot(tiempo,pasoa_gs2,'r','LineWidth',2)
    axis tight
    grid on
    title('Filtro paso alto ventana gaussiana de 31')
    xlabel('Tiempo [Años]')
subplot(4,1,4)
    plot(tiempo,pasoa_gs3,'r','LineWidth',2)
    axis tight
    grid on
    title('Filtro paso alto ventana gaussiana de 61')
    xlabel('Tiempo [Años]')

%% Grafico de los vectores de peso

tr3 = triang(61); % de 61
trn3 = tr3/sum(tr3);

rw3 = rectwin(61); % de 61
rwn3 = rw3/sum(rw3);

gs3 = gausswin(61); % de 61
gsn3 = gs3/sum(gs3);

figure()
plot(rwn3,'LineWidth',2)
hold on
plot(trn3,'LineWidth',2)
plot(gsn3,'LineWidth',2)
axis tight
legend('Rectangular','Triangular','Gaussiana')
title('Grafico de los vectores de peso')
%AL ser los vectores de peso, para el valor 31 que es el valor del medio en la ventana de 31, se da la mayor ponderacion,
%sin embargo en la rectangular se tiene el mismo peso para cada valor
%% Pasabanda
%Para pasabanda se deben usar o los filtros pasa alto o los filtros paso
%bajo, en esta caso se hace el de 31 - 61 Esto es T2 - T1

%Paso bajo
filtpbd_rwb = filt_rw2 - filt_rw3; 
filtpbd_trb = filt_tr2 - filt_tr3; 
filtpbd_gsb = filt_gs2 - filt_gs3; 

figure()
% plot(tiempo,hielo,'LineWidth',2)
% hold on
plot(tiempo,filtpbd_rwb,'LineWidth',2)
hold on
plot(tiempo,filtpbd_trb,'LineWidth',2)
plot(tiempo,filtpbd_gsb,'LineWidth',2)
axis tight
title('Filtros pasa banda con filtros paso bajo')
legend('Rectangular','Triangular','Gaussiana','Location','best')

%Paso alto
filtpbd_rwa = pasoa_rw2 - pasoa_rw3;
filtpbd_tra = pasoa_tr2 - pasoa_tr3;
filtpbd_gsa = pasoa_gs2 - pasoa_gs3;

figure()
%plot(tiempo,hielo,'LineWidth',2)
%hold on
plot(tiempo,filtpbd_rwa,'LineWidth',2)
hold on
plot(tiempo,filtpbd_tra,'LineWidth',2)
plot(tiempo,filtpbd_gsa,'LineWidth',2)
axis tight
title('Filtros pasa banda con filtros paso alto')
legend('Rectangular','Triangular','Gaussiana','Location','best')
