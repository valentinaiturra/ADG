clc
clear 
close all

excel = readtable('lluvias.xlsx','Range','A7:B1467');

datos(:,1) = table2array(excel(1:1461,2));
fechass = table2cell(excel(1:1461,1));

for k = 1:length(fechass)
    fechas(k,1) = datenum(fechass(k),'dd-mm-yyyy');
end

% fecha_2= datetime(fechas,'ConvertFrom','datenum');

%RECORDAR 
%para determinar una desviacion estandar basta solo calcular std y para
%graficarlo solo es media - std [68,2%]
%Sin embargo, si tu quieres hacer la segunda o tercera desviacion estandar
%debe ser std(datos)*2 y seguir el mismo procedimiento para graficarlo [27.2%]
%Una tercera derivada es con std(datos)*3 [4.2%]


%% ITEM 1

media = nanmean(datos);
mediana = median(datos, 'omitnan');
desviacion = nanstd(datos);
IQR = iqr(datos);
Q1 = prctile(datos,25);
Q2 = prctile(datos,50);
Q3 = prctile(datos,75);
trimean = (Q1 + (2*Q2) + Q3)/4;

%% ITEM 2

a=0;
for i= 1:4
    a = a + 1;
    if i < 4
        media_a(a) = nanmean(datos(i*365-364:i*365));
        mediana_a(a) = median(datos(i*365-364:i*365), 'omitnan');
        desviacion_a(a) = nanstd(datos(i*365-364:i*365));
        IQR_a(a) = iqr(datos(i*365-364:i*365));
        Q1_a(a) = prctile(datos(i*365-364:i*365),25);
        Q2_a(a) = prctile(datos(i*365-364:i*365),50);
        Q3_a(a) = prctile(datos(i*365-364:i*365),75);
        trimean_a(a) = (Q1_a(a) + (2*Q2_a(a)) + Q3_a(a))/4;
    else
        media_a(a) = nanmean(datos(i*365-364:i*365+1));
        mediana_a(a) = median(datos(i*365-364:i*365+1), 'omitnan');
        desviacion_a(a) = nanstd(datos(i*365-364:i*365+1));
        IQR_a(a) = iqr(datos(i*365-364:i*365+1));
        Q1_a(a) = prctile(datos(i*365-364:i*365+1),25);
        Q2_a(a) = prctile(datos(i*365-364:i*365+1),50);
        Q3_a(a) = prctile(datos(i*365-364:i*365+1),75);
        trimean_a(a) = (Q1_a(a) + (2*Q2_a(a)) + Q3_a(a))/4;
    end 
end

%% ITEM 3

idx = find(fechas == datenum(2020,02,29));
datoss = datos;
datoss(idx) = [];

for i = 1:4
    datos_a(:,i) = datoss(i*365-364:i*365);
end

figure()
boxplot(datos_a,'labels',{'2017','2018','2019','2020'})
hold on
plot(media_a, 'om')
plot(trimean_a,'ok')
legend('Media','Trimedia')

%% ITEM 4
years = ["2017","2018","2019","2020"];

figure()

for i = 1:4

    subplot(2,2,i)
        boxplot(datos_a(:,i),'labels',years(i))
        hold on
        plot(media_a(i),'*m')
        plot(trimean_a(i),'*k')
        ylabel('Precipitación [mm]')

end

%% ITEM 5
datos(:,2)= detrend(datos(:,1),'omitnan');

%% ITEM 6

media_st = nanmean(datos(:,2));
mediana_st = median(datos(:,2), 'omitnan');
desviacion_st = nanstd(datos(:,2));
IQR_st = iqr(datos(:,2));
Q1_st = prctile(datos(:,2),25);
Q2_st = prctile(datos(:,2),50);
Q3_st = prctile(datos(:,2),75);
trimean_st = (Q1_st + (2*Q2_st) + Q3_st)/4;

% Estadisticos anuales sin tendencia

a=0;
for i= 1:4
    a = a + 1;
    if i < 4
        media_ast(a) = nanmean(datos(i*365-364:i*365,2));
        mediana_ast(a) = median(datos(i*365-364:i*365,2), 'omitnan');
        desviacion_ast(a) = nanstd(datos(i*365-364:i*365,2));
        IQR_ast(a) = iqr(datos(i*365-364:i*365,2));
        Q1_ast(a) = prctile(datos(i*365-364:i*365,2),25);
        Q2_ast(a) = prctile(datos(i*365-364:i*365,2),50);
        Q3_ast(a) = prctile(datos(i*365-364:i*365,2),75);
        trimean_ast(a) = (Q1_ast(a) + (2*Q2_ast(a)) + Q3_ast(a))/4;
    else
        media_ast(a) = nanmean(datos(i*365-364:i*365+1,2));
        mediana_ast(a) = median(datos(i*365-364:i*365+1,2), 'omitnan');
        desviacion_ast(a) = nanstd(datos(i*365-364:i*365+1,2));
        IQR_ast(a) = iqr(datos(i*365-364:i*365+1,2));
        Q1_ast(a) = prctile(datos(i*365-364:i*365+1,2),25);
        Q2_ast(a) = prctile(datos(i*365-364:i*365+1,2),50);
        Q3_ast(a) = prctile(datos(i*365-364:i*365+1,2),75);
        trimean_a(a) = (Q1_ast(a) + (2*Q2_ast(a)) + Q3_ast(a))/4;
    end 
end

%% ITEM 7
figure ()
subplot(2,2,1)
    histogram(datos(:,1))
    grid minor
    title('Datos originales')
    xlabel('Datos')
    ylabel('Frecuencia absoluta')
    axis tight
subplot(2,2,2)
    histogram(datos(:,2))
    grid minor
    title('Datos sin tendencia')
    xlabel('Datos')
    ylabel('Frecuencia absoluta')
    axis tight
subplot(2,2,3)
    histogram(datos(:,1),'Normalization','probability')
    grid minor
    title('Datos originales normalizados')
    xlabel('Datos')
    ylabel('Frecuencia relativa')
    axis tight
subplot(2,2,4)
    histogram(datos(:,2),'Normalization','probability')
    grid minor
    title('Datos sin tendencia normalizados')
    xlabel('Datos')
    ylabel('Frecuencia relativa')
    axis tight

%% ITEM 8
h = (2.6 * IQR)/(length(datos(:,1)))^(1/3);
h_st = (2.6 * IQR_st)/(length(datos(:,2)))^(1/3);

figure ()
subplot(2,2,1)
    histogram(datos(:,1),'BinWidth',h)
    grid minor
    title('Datos originales')
    xlabel('Datos')
    ylabel('Frecuencia absoluta')
    axis tight
subplot(2,2,2)
    histogram(datos(:,2),'BinWidth',h_st)
    grid minor
    title('Datos sin tendencia')
    xlabel('Datos')
    ylabel('Frecuencia absoluta')
    axis tight
subplot(2,2,3)
    histogram(datos(:,1),'Normalization','probability','BinWidth',h)
    grid minor
    title('Datos originales normalizados')
    xlabel('Datos')
    ylabel('Frecuencia relativa')
    axis tight
subplot(2,2,4)
    histogram(datos(:,2),'Normalization','probability','BinWidth',h_st)
    grid minor
    title('Datos sin tendencia normalizados')
    xlabel('Datos')
    ylabel('Frecuencia relativa')
    axis tight

%% ITEM 9

datos(:,3) = media;
datos(:,4) = desviacion;
datos(:,5) = desviacion*2;
datos(:,6) = desviacion*3;
datos(:,7) = media-desviacion;
datos(:,8) = desviacion+media;

figure()
plot(fechas,datos(:,1),'.b')
hold on 
plot(fechas,datos(:,2),'.r')
plot(fechas,datos(:,3),'-k','LineWidth',3)
plot(fechas,(media-datos(:,5)),'-m','LineWidth',2)
plot(fechas,(media+datos(:,5)),'-m','LineWidth',2)
plot(fechas,datos(:,7),'-g','LineWidth',2)
plot(fechas,datos(:,8),'-g','LineWidth',2)
plot(fechas,(media-datos(:,6)),'-y','LineWidth',2)
plot(fechas,(media+datos(:,6)),'-y','LineWidth',2)
axis tight
legend('Datos','Datos sin tendencia','Media','Primera desviacion estandar','','Segunda desviacion estandar','','Tercera desviacion estandar','Location','bestoutside')
datetick('x','yyyy','keeplimits')
ylabel('precipitación acumulada [mm]')
xlabel('Tiempo [años]')
title('Datos de precipitacion en ancud medida ente 2017 y 2020')

%% ITEM 10
[medmov1,desvmov1]=mmsm(datos(:,1),1,31);
[medmov2,desvmov2]=mmsm(datos(:,1),1,7);
[medmov3,desvmov3]=mmsm(datos(:,1),1,61);
[timemov1,~]=mmsm(fechas,1,31);
[timemov2,~]=mmsm(fechas,1,7);
[timemov3,~]=mmsm(fechas,1,61);

figure()
plot(fechas,datos(:,1),'.')
hold on
plot(timemov1,medmov1,'LineWidth',2)
axis tight
legend('Datos originales','Media Movil')
datetick('x','yyyy','keeplimits')
ylabel('precipitación acumulada [mm]')
xlabel('Tiempo[años]')
title('Datos junto a su media movil de 31 días')

figure()
plot(fechas,datos(:,1),'.')
hold on
plot(timemov2,medmov2,'LineWidth',2)
axis tight
legend('Datos originales','Media Movil')
datetick('x','yyyy','keeplimits')
ylabel('precipitación acumulada [mm]')
xlabel('Tiempo[años]')
title('Datos junto a su media movil de 7 días')

figure()
plot(fechas,datos(:,1),'.')
hold on
plot(timemov3,medmov3,'LineWidth',2)
axis tight
legend('Datos originales','Media Movil')
datetick('x','yyyy','keeplimits')
ylabel('precipitación acumulada [mm]')
xlabel('Tiempo[años]')
title('Datos junto a su media movil de 61 días')

%% ITEM 11

% Grafico con ventana de 7 dias
figure()
    plot(fechas,datos(:,1),'.k')
    hold on
    plot(timemov2,medmov2,'r','LineWidth',2)
    plot(timemov2,desvmov2,'b','LineWidth',2)
    plot(timemov2,(desvmov2+medmov2),'g','LineWidth',2)
    axis tight
    legend('Datos originales','Media Movil','Desviacion estandar movil')
    datetick('x','yyyy','keeplimits')
    ylabel('precipitación acumulada [mm]')
    xlabel('Tiempo[años]')
    title('Datos con una ventana de 7 días')

%% PARTE INTERPOLACION

%% ITEM 1 y 2

lluvia2(:,2)= datos(:,1);
lluvia2(:,1) = fechas;
ee = ~isnan(lluvia2(:,2));
idx = find(ee == 0);
lluvia2(idx,:)= [];

%% ITEM 3
pp = polyfit(lluvia2(:,1),lluvia2(:,2),1);
pv = polyval(pp,lluvia2(:,1));

figure()
plot(lluvia2(:,1),lluvia2(:,2),'.')
hold on
plot(lluvia2(:,1),pv,'LineWidth',2)
axis tight
grid minor
legend('Datos originales','Polinomio grado 1')
datetick('x','yyyy','keeplimits')
ylabel('Precipitación acumulada [mm]')
xlabel('Tiempo [años]')
title('Serie original con una regresion polinomial de grado 1')

%% ITEM 4

pp3 = polyfit(lluvia2(:,1),lluvia2(:,2),3);
pv3 = polyval(pp3,lluvia2(:,1));

figure()
plot(lluvia2(:,1),lluvia2(:,2),'.')
hold on
plot(lluvia2(:,1),pv3,'LineWidth',2)
axis tight
legend('Datos originales','Polinomio grado 3')
datetick('x','yyyy','keeplimits')
grid minor
ylabel('Precipitación acumulada [mm]')
xlabel('Tiempo [años]')
title('Serie original con una regresion polinomial de grado 3')

pp7 = polyfit(lluvia2(:,1),lluvia2(:,2),7);
pv7 = polyval(pp7,lluvia2(:,1));

figure()
plot(lluvia2(:,1),lluvia2(:,2),'.')
hold on
plot(lluvia2(:,1),pv7,'LineWidth',2)
axis tight
legend('Datos originales','Polinomio grado 7')
datetick('x','yyyy','keeplimits')
grid minor
ylabel('Precipitación acumulada [mm]')
xlabel('Tiempo [años]')
title('Serie original con una regresion polinomial de grado 7')


%% ITEM 5
Error= pv - lluvia2(:,2);
Error3= pv3 - lluvia2(:,2);
Error7= pv7 - lluvia2(:,2);

figure()
plot(Error,'.')
ylabel('Error')
grid minor
axis tight
title('Regresión grado 1 - Serie Original')

figure()
plot(Error3,'.')
ylabel('Error')
grid minor
axis tight
title('Regresión grado 3 - Serie Original')

figure()
plot(Error7,'.')
ylabel('Error')
grid minor
axis tight
title('Regresión grado 7 - Serie Original')

%% ITEM 6
dif_cuadrado = Error.^2;
mse = sum(dif_cuadrado)/length(lluvia2(:,2));

dif_cuadrado = Error3.^2;
mse3 = sum(dif_cuadrado)/length(lluvia2(:,2));

dif_cuadrado = Error7.^2;
mse7 = sum(dif_cuadrado)/length(lluvia2(:,2));

%% Interpolacion junio 2020

jun = datenum(2020,06,01);
idx = find(fechas == jun);
lluvia3 = fechas(idx:end);
lluvia3(:,2) = datos(idx:end,1);

ee = ~isnan(lluvia3(:,2));
idx = find(ee == 1);
lluvia_sn = lluvia3(idx,:);

x = lluvia_sn(:,1); %Fechas sin NaN
v = lluvia_sn(:,2); %Datos sin NaN
xq = lluvia3(:,1); %Fechas incluyendo NaN

ps = interp1(x,v,xq,'spline');
pl = interp1(x,v,xq,'linear');
pn = interp1(x,v,xq,'nearest');


figure()
plot(lluvia3(:,1),ps,'-.r','linewidth',2)
hold on
plot(lluvia3(:,1),lluvia3(:,2),'b','LineWidth',2)
axis tight
datetick('x','yyyy','keeplimits')
grid minor
ylabel('Precipitación acumulada [mm]')
xlabel('Tiempo [años]')
legend('Serie Interpolada', 'Serie Original')
title('Serie original y serie interpolada spline')

figure()
plot(lluvia3(:,1),pl,'-.r','LineWidth',2)
hold on
plot(lluvia3(:,1),lluvia3(:,2),'b','LineWidth',2)
axis tight
datetick('x','yyyy','keeplimits')
grid minor
ylabel('Precipitación acumulada [mm]')
xlabel('Tiempo [años]')
legend('Serie Interpolada', 'Serie Original')
title('Serie original y serie interpolada linear')

figure()
plot(lluvia3(:,1),pn,'-.r','LineWidth',2)
hold on
plot(lluvia3(:,1),lluvia3(:,2),'b','LineWidth',2)
axis tight
datetick('x','yyyy','keeplimits')
grid minor
ylabel('Precipitación acumulada [mm]')
xlabel('Tiempo [años]')
legend('Serie Interpolada', 'Serie Original')
title('Serie original y serie interpolada nearest')

%% ITEM 8
%puesto 861

ant = datos(861-15:861-1);
ant(16:15+15) = datos(861+1:861+15);
cerc = mean(ant);
peso1 = cerc*0.7;

desp = datos(861+365);
desp(2) = datos(861-365);
lej = mean(desp)
peso2 = lej*0.3

datos(861) = peso1 + peso2;

datos(861)

