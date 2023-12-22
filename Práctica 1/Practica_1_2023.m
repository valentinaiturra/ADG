clc
clear all
close all

%% Item 1 y 2

datos = readmatrix("imaunaloaNaN.dat.dat");
[fila,columna] = find(datos== -9999);
tamano=length(columna);

%Para reemplazar por NaN
for i=1:tamano
    datos(fila(i),columna(i))=NaN;
end

%% Item 3

%Para las dos columnas
datos2= [];
n=0;
years=datos(:,1);

for j=1:66
    for i=1:12
        n=n+1;
        datos2(n,2)=datos(j,(i+1));
    end
end
count=0;
for j=1958:2023
    for i=1:12
        count=count+1;
        datos2(count,1) = j + [i/12-1/24];
    end
end

%% Item 4
figure()
plot(datos2(:,1),datos2(:,2),'LineWidth',2,'Color','r')
xlabel('Tiempo [Años]','FontSize',15)
ylabel('CO2','FontSize',15)
title('Mediciones de CO2','FontSize',25)
axis tight
grid minor

%% Item 5

x=datos2(:,1);
co2=datos2(:,2);

%MEDIA
media = nanmean(co2);
%DESVIACION
desviacion = nanstd(co2);
resta= media - desviacion;
suma = media + desviacion;
for i=1:792
    datos2(i,3)= media;
    datos2(i,4) = resta;
    datos2(i,5) = suma;
    datos2(i,6) = desviacion;
end

%Se quita la tendencia
datos_st(:,1)= detrend(datos2(:,2),'omitnan'); 
pendiente= datos2(:,2)-datos_st(:,1);

datos_st(:,2) = nanmean(datos_st(:,1));
datos_st(:,3) = nanstd(datos_st(:,1)); %desviacion estandar
datos_st(:,4) = datos_st(:,2) + datos_st(:,3); %suma
datos_st(:,5) = datos_st(:,2) - datos_st(:,3); %Resta

[medmov,desvmov]=mmsm(datos2(:,2),1,61);

datos5(:,1) = medmov;
datos5(:,2) = desvmov;
datos5(:,3) = datos5(:,1) + datos5(:,2);
datos5(:,4) = datos5(:,1) - datos5(:,2);

[timemov,~]=mmsm(datos2(:,1),1,61);


% GRAFICO REAL
figure(1)
xi=datos2(1,1);
xf=datos2(end,1);
plot(x,co2,'-r','LineWidth',2)
grid minor
title('Concentraciones de CO2 medidas en Mauna Loa')
ylabel('CO2 [ppm]')
xlabel('Tiempo [años]')
xlim([1958,2023])
hold on
plot(x,datos2(:,4),'--g','LineWidth',2)
plot(x,datos2(:,5),'--y','LineWidth',2)
plot(x,datos2(:,3),'-m','LineWidth',2)
plot(x,pendiente,'-b','LineWidth',2)
legend('Datos','Suma media y desviacion','resta media y desviacion', 'Media','Pendiente','Location','best')
hold off
% 
figure(2)
plot(x,datos_st(:,1),'b','LineWidth',2)
hold on
plot(x,datos_st(:,4),'--g','LineWidth',2)
plot(x,datos_st(:,5),'--y','LineWidth',2)
plot(x,datos_st(:,2),'-m','LineWidth',2)
legend('Datos sin tendencia','Suma desviacion y media','Resta desviacion y media', 'Media','Location','best')
axis tight
grid minor
xlabel('Tiempo [años]')
ylabel(CO2 [ppm])
title('Datos sin tendencia')
%% Item 6

figure(3) %Grafico de la media movil centrada
hold on
plot(x,co2,'-r','LineWidth',2)
plot(timemov,datos5(:,1),'-g','LineWidth',2)
plot(timemov,datos5(:,3),'--m','LineWidth',2)
plot(timemov,datos5(:,4),'--b','LineWidth',2)
legend('Datos', 'Media movil', 'Suma', 'Resta','Location','best')
axis tight
grid minor
xlabel('Tiempo [años]')
ylabel('CO2 [ppm]')
title('Grafico de la media movil centrada')

t61=x(61:end);
figure(4) %Grafico de la media movil perdiendo datos del inicio
hold on
plot(x,co2,'-r','LineWidth',2)
plot(t61,datos5(:,1),'-g','LineWidth',2)
plot(t61,datos5(:,3),'--m','LineWidth',2)
plot(t61,datos5(:,4),'--b','LineWidth',2)
legend('Datos', 'Media movil', 'Suma', 'Resta')
axis tight
grid minor
xlabel('Tiempo [años]')
ylabel('CO2 [ppm]')
title('Grafico de la media movil perdiendo datos del inicio')

t61=x(1:end-60);
figure(5) %Grafico de la media movil perdiendo datos del final
hold on
plot(x,co2,'-r','LineWidth',2)
plot(t61,datos5(:,1),'-g','LineWidth',2)
plot(t61,datos5(:,3),'--m','LineWidth',2)
plot(t61,datos5(:,4),'--b','LineWidth',2)
legend('Datos', 'Media movil', 'Suma', 'Resta')
axis tight
grid minor
xlabel('Tiempo [años]')
ylabel('CO2 [ppm]')
title('Grafico de la media movil perdiendo datos del inicio')
