clear all
close all
clc

load('mar.mat')
load('nino.mat')
load('calor2.mat')

%%
%Correlaciona con desface es con respecto a las consecuencias de un primer
%dato

%Niño y calor, calcular correlacion con desface de uno a tres meses 

[rho] = corr(Nino(:,2),Calor(:,2),'Type','Pearson');
[rho2] = corr(Nino(1:end-1,2),Calor(2:end,2),'Type','Pearson');
[rho3] = corr(Nino(1:end-2,2),Calor(3:end,2),'Type','Pearson');
[rho4] = corr(Nino(1:end-3,2),Calor(4:end,2),'Type','Pearson');

%% Ahora para mar y niño

[rho_a] = corr(Mar(1:end-12,2),Nino(277+12:end,2),'Type','Pearson');
[rho_b] = corr(Mar(1:end-24,2),Nino(277+24:end,2),'Type','Pearson');
[rho_c] = corr(Mar(1:end-36,2),Nino(277+36:end,2),'Type','Pearson');

%% GRAFICOS

figure()
subplot(2,2,1)
    plot(Mar(1:end,1),normalize(Mar(1:end,2)),'LineWidth',2)
    hold on
    plot(Mar(1:end,1),normalize(Nino(277:end,2)),'LineWidth',2)
    axis tight
    legend('Nivel del mar','Niño','Location','best')
    xlabel('Tiempo [años]')
    ylabel('Datos normalizados')
    title('Series sin correlación ')
subplot(2,2,2)
    plot(Mar(1:end-12,1),normalize(Mar(1:end-12,2)),'LineWidth',2)
    hold on
    plot(Mar(1:end-12,1),normalize(Nino(277+12:end,2)),'LineWidth',2)
    axis tight
    legend('Nivel del mar','Niño','Location','best')
    xlabel('Tiempo [años]')
    ylabel('Datos normalizados')
    title('Correlación con desface de un año')
subplot(2,2,3)
    plot(Mar(1:end-24,1),normalize(Mar(1:end-24,2)),'LineWidth',2)
    hold on
    plot(Mar(1:end-24,1),normalize(Nino(277+24:end,2)),'LineWidth',2)
    axis tight
    legend('Nivel del mar','Niño','Location','best')
    xlabel('Tiempo [años]')
    ylabel('Datos normalizados')
    title('Correlación con desface de dos años')
subplot(2,2,4)
    plot(Mar(1:end-36,1),normalize(Mar(1:end-36,2)),'LineWidth',2)
    hold on
    plot(Mar(1:end-36,1),normalize(Nino(277+36:end,2)),'LineWidth',2)
    axis tight
    legend('Nivel del mar','Niño','Location','best')
    xlabel('Tiempo [años]')
    ylabel('Datos normalizados')
    title('Correlación con desface de tres años')

    %%

[r,lags] = xcorr(Calor(:,2),Nino(:,2),'normalized');
figure()
    plot(lags,r) %Lag es el desface y r la correlacion
    xlabel('Desfase')
    ylabel('Correlación')
    axis tight

%Busca con que desface hay mayor correlación
%IMPORTANTE es sacar maximo y minimo y de ellos, ver el valor maximo a
%partir de su valor absoluto
[value,posicion]= max(r);
lags(posicion);

%Calcular un desface maximo de 10 años
