clc
clear all
close all

load NIEVE.mat

%% Parte 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ITEM 1
nieve1 = nieve(2:51,:);
[fila,columna] = find(nieve1 == -999.9);

for i =1:length(fila)
    nieve1(fila(i),columna(i)) = NaN;
end

n=0;
count=0;

for j=1967:2016
    for i=1:12
        count=count+1;
        nieve2(count,1) = j + [i/12-1/24];
    end
end

for k=1:50
    for i=1:12
        n = n+1;
        nieve2(n,2) = nieve1(k,(i+1));
    end
end

%% ITEM 2: datos sin tendencia
nieve2(:,3) = detrend(nieve2(:,2),'omitnan');

%% ITEM 3: ancho optimo

%rango intercuartil (IQR)
IQR = iqr(nieve2(:,2));
IQR_= iqr(nieve2(:,3));

%Ancho optimo
h = (2.6 * IQR)/(length(nieve2(:,2)))^(1/3);
h_ = (2.6 * IQR_)/(length(nieve2(:,3)))^(1/3);

%Graficos con en ancho optimo
figure(1)
    subplot(2,1,1)
    histogram(nieve2(:,2),'BinWidth',h,'FaceColor','b')
    grid minor
    title('Serie')
    ylabel('Frecuencia Absoluta')
    xlabel('Datos')

    subplot(2,1,2)
    histogram(nieve2(:,3),'BinWidth',h_,'FaceColor','r')
    title('Serie sin tendencia')
    ylabel('Frecuencia Absoluta')
    xlabel('Datos')

%Graficos version normalizada
figure(2)
    subplot(2,1,1)
    histogram(nieve2(:,2),'Normalization','probability','BinWidth',h,'FaceColor','b')
    title('Serie Normalizada')
    ylabel('Frecuencia relativa')
    xlabel('Datos')

    subplot(2,1,2)
    histogram(nieve2(:,3),'Normalization','probability','BinWidth',h_,'FaceColor','r')
    title('Serie normalizada sin tendencia')
    ylabel('Frecuencia relativa')
    xlabel('Datos')

%% ITEM 4

%Para la serie original
media = mean(nieve2(:,2),'omitnan');
mediana = median(nieve2(:,2),'omitnan');

Q1 = prctile(nieve2(:,2),25);
Q2 = prctile(nieve2(:,2),50);
Q3 = prctile(nieve2(:,2),75);
Q4 = prctile(nieve2(:,2),100);

trimean = (Q1 + (2*Q2) + Q3)/4;
IQR = Q3 - Q1;
desviacion = std(nieve2(:,2),'omitnan');

%Para la serie sin tendencia
media_ = mean(nieve2(:,3),'omitnan');
mediana_ = median(nieve2(:,3),'omitnan');

Q1_ = prctile(nieve2(:,3),25);
Q2_ = prctile(nieve2(:,3),50);
Q3_ = prctile(nieve2(:,3),75);
Q4_ = prctile(nieve2(:,3),100);

trimean_ = (Q1_ + (2*Q2_) + Q3_)/4;
IQR_ = Q3_ - Q1_;
desviacion_ = std(nieve2(:,3),'omitnan');

%% ITEM 5

figure(3)
    subplot (1,2,1)
        boxplot(nieve2(:,2))
        hold on
        plot(mediana,'*g')
        plot(trimean,'*m')
        plot(media,'*y')
        legend('mediana','timediana','media')
        title('Serie con tendencia')
    subplot (1,2,2)
        boxplot(nieve2(:,3))
        hold on
        plot(mediana_,'*g')
        plot(trimean_,'*m')
        plot(media_,'*y')
        legend('mediana','timediana','media')
        title('serie sin tendencia')
%% ITEM 6
meses = ["Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"];

for i=2:13
    mes(:,i-1) = nieve1(:,i);
    IQR(i-1) = iqr(mes(:,i-1));
    h(i-1) = (2.6 * IQR(i-1))/(length(mes(:,i-1)))^(1/3);
    
    figure(3)
        subplot(3,4,i-1)
        histogram(mes(:,i-1),'BinWidth',h(i-1))
        title(meses(i-1))
end

%% ITEM 7

figure()
datos=nanmean(nieve1(:,2:13));
boxplot(nieve1(:,2:end),'labels',{'Enero','Febrero','Marzo','Abril'...
,'Mayo','Junio','Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'})
hold on
plot(1:12,datos,'k')
grid minor



%% Parte 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ITEM 1
idx = ~isnan(nieve2(:,2));
valmal = find(idx == 0);
nieve2sn = nieve2;
nieve2sn(valmal,:) = [];

x = nieve2sn(:,1);
y = nieve2sn(:,2);
pf = polyfit(x,y,1);
pv = polyval(pf,x);

Error= pv - y;
err = immse(y,pv); %funcion immse entrega ecm, no importa el orden

figure(5)
subplot(2,1,1)
    plot(nieve2(:,1),nieve2(:,2),'LineWidth',1)
    hold on
    plot(x,pv,'LineWidth',2)
    legend('Serie original','Regresion en polinomio de grado uno')
    xlabel('Tiempo [Años]')
    ylabel('Datos')
    title('Serie y regresion lineal')
subplot(2,1,2)
    bar(Error)
    title('Rango de error en la regresión lineal')

%% ITEM 2


pf2 = polyfit(x,y,3);
pv2 = polyval(pf2,x);

Error2 = pv2 - y;
err2 = immse(y,pv2); %funcion immse entrega ecm, no importa el orden

figure(6)
subplot(2,1,1)
    plot(nieve2(:,1),nieve2(:,2))
    hold on
    plot(x,pv2,'LineWidth',2)
    legend('Serie original','Regresion en polinomio de grado tres')
    xlabel('Tiempo [Años]')
    ylabel('Datos')
    title('Serie y regresion polinomial de grado 3')
subplot(2,1,2)
    bar(Error2)
    title('Rango de error en la regresión')

%% ITEM 3

x_ = nieve2sn(:,1);
v_ = nieve2sn(:,2);
xq_ = nieve2(:,1);

inter = interp1(x_,v_,xq_,'spline');

figure(7)
plot(nieve2(:,1),inter,'r')
hold on
plot(nieve2(:,1),nieve2(:,2),'.-b')
legend('Serie interpolada','Serie original')
xlabel('Tiempo [Años]')
ylabel('Datos')
title('Serie vs Interpolacion cúbica (splin)')

%% ITEM 4
nieve4= nieve2(25:36,:);
idxx = ~isnan(nieve4(:,2));
valmal_ = find(idxx == 0);
nieve4sn = nieve4;
nieve4sn(valmal_,:) = [];

x__ = nieve4sn(:,1);
v__ = nieve4sn(:,2);
xq__ = nieve4(:,1);

inter1 = interp1(x__,v__,xq__,'linear');
inter2 = interp1(x__,v__,xq__,'nearest');
inter3 = interp1(x__,v__,xq__,'cubic');

figure()
plot(nieve4(:,1),inter1,'.-r')
hold on
plot(nieve2(:,1),nieve2(:,2),'.-b')
legend('Serie interpolada','Serie original')
xlabel('Tiempo [Años]')
ylabel('Datos')
title('Serie vs Interpolacion lineal año 1969')

figure()
plot(nieve4(:,1),inter2,'.-r')
hold on
plot(nieve2(:,1),nieve2(:,2),'.-b')
legend('Serie interpolada','Serie original')
xlabel('Tiempo [Años]')
ylabel('Datos')
title('Serie vs Interpolacion al vecino mas cercano año 1969')

figure()
plot(nieve4(:,1),inter3,'.-r')
hold on
plot(nieve2(:,1),nieve2(:,2),'.-b')
legend('Serie interpolada','Serie original')
xlabel('Tiempo [Años]')
ylabel('Datos')
title('Serie vs Interpolacion cúbica año 1969')

%% Si a los datos se le saca la tendencia 
%primeras figuras
% la moda ubicada entre 0 y 7 debidoa que estos son los meses en que no nieva 
%Datos sin tendencia negativos no tiene mucho sentido en la grafica sin
%tendencia

%segunda bloxpot
%trimediana es mas robusta, no se ve tan afectado por datos extremos 
%El cincuenta porciento de los datos estan dentro de la caja, todos los
%estadistico en el lado sin tendencia estan cercanos al cero dado que hay
%una simetria c/r al cero, serie sin tendencia extiende mas rango de
%valores razon por lo que esta mas sepada de la media

%En gafico de muchos boxplots se puede inferir que los datos son del
%emisferio norte, los de entre octubre y junio estan muy extendidos los
%datos. y esto pues es muy sensible a los cambios, razon por la que hay
%tanta variabilidad en los datos. Como no hay nieve en verano los datos no
%varian. La linea que se plotea encima corresponde a un ciclo anual.