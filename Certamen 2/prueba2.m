clc
clear all

%Estadísticos móviles (30%).

load('stgo_temp.mat');
ST = stgo_temp;

%Recupere la serie stgo_t.mat y realice un cálculo de los siguientes 
% estadísticos utilizando una ventana de 6 meses. Entregue en un gráfico 
% todos los estadísticos sobre la serie original. (10%)

[~,~,mediana,Q1,Q3]=mmsm(ST(:,2),1,60);
tiempomovil = ST(1+29:end-30,1);

figure()
    plot(ST(:,1),ST(:,2),'LineWidth',2)
    hold on
    plot(tiempomovil,mediana,'LineWidth',2)
    plot(tiempomovil,Q1,'LineWidth',2)
    plot(tiempomovil,Q3,'LineWidth',2)
    xlabel('Fecha')
    ylabel('Temperatura [°C]')
    axis tight
    grid minor
    legend('Mediana','Q3','Q1','Location','best')
    title('Estadisticos sobre una serie original')

    %%
%Utilizando boxplot o histogramas realice una predicción de cómo irá variando la
%temperatura en los próximos años para la ciudad de Santiago

a=0;
for i = 1:12
a= a+1;
media(a,1) = nanmean(ST_new(1:end,i+1));
end
figure()
boxplot(ST_new(:,2:end))
hold on
plot(1:12,media,'k')
xlabel('Tiempo [Meses]')
ylabel('Temperatura [°C]')
title('Variacion de temperatura mensual')



%%
%Transforme la serie utilizada en este ejercicio de una matriz de 684x2 a una de
% 57x13.
%(fila,columna)
ST_new(:,1) = [1962:2018];
for i = 1:57
    ST_new(i,2:13)= ST((12*i)-11:12*i,2);
end

%%
%Utilizando la misma serie anterior, con una ventana gaussiana de 6 meses 
% y 18 meses respectivamente realice un filtro pasa alto y pasa bajo. 
% Presente la serie obtenida en un gráfico sobre la serie original

[pa_gs,~]=papb_gs(6, ST(:,2));
[~,pb_gs2]=papb_gs(18, ST(:,2));

figure()
plot(ST(:,1),ST(:,2),'LineWidth',2)
hold on
plot(ST(:,1),pa_gs,'LineWidth',2,'Color','r')
plot(ST(:,1),pb_gs2,'LineWidth',2,'Color','y')
axis tight
grid minor
xlabel('Tiempo [años]')
ylabel('Temperatura [°C]')
legend('Serie origina', 'Filtro paso alto 6 meses','Filtro paso bajo 18 meses','Location','best')
title('Serie de temperatura filtrada')
%%
%Mediante un filtro pasa banda obtenga el ciclo estacional de la serie 
% entregada, defina usted qué ventana considera mejor para obtener el 
% ciclo estacional. (15%)

[filtpbd_gsa,filtpbd_gsb] = pasabanda_gs(6,3, ST(:,2));

%Entregue en un gráfico donde se presente la serie original con el 
% ciclo estacionario superpuesto
figure()
plot(ST(:,1),ST(:,2),'LineWidth',2)
hold on
plot(ST(:,1),filtpbd_gsa,'LineWidth',2)
plot(ST(:,1),filtpbd_gsb,'LineWidth',2)
axis tight
grid minor
xlabel('Tiempo [años]')
ylabel('Temperatura [°C]')
legend('Serie original', 'Filtro pasabanda alta','Filtro pasabanda bajo','Location','best')
title('Serie con ciclo estacional')
%% 
%Calcule la correlación de Pearson y Spearman utilizando 
% las dos series de temperatura entregadas (stgo_t.mat y sr_temp.mat).

clear all
load('stgo_temp.mat')
load('sr_temp.mat') %San Rafael en Argentina

ST=stgo_temp;
SR = sr_temp;

[rho_P] = corr(ST(:,2),SR(:,2),'Type','Pearson'); 
[rho_S] = corr(ST(:,2),SR(:,2),'Type','Spearman');


%%
%Evalúe si la correlación obtenida es significativa considerando un nivel 
% de confianza de 75%, 85% y 95% (solamente para la correlación de Pearson).
% Entregar los T_c calculados en una tabla.

[t_c1,s,alfa_med,grad_lib] = tstudent(ST(:,2),SR(:,2),75);
% T_C = 1,3382
%alpha/2 = 0,125
%Grados de libertad = 682

%En la tabla, 0,15 que es el más aproximado a 0,125 el valor infinito es
%1.036 este es 
[t_c2,s,alfa_med,grad_lib] = tstudent(ST(:,2),SR(:,2),85);
% T_C = 1,338
%alpha/2 = 0,075
%Grados de libertad = 682

%En la tabla, 0.10 que es el más aproximado a 0,075 el valor infinito es
%1.645 este es 
[t_c3,s,alfa_med,grad_lib] = tstudent(ST(:,2),SR(:,2),95);
% T_C = 1.338
%alpha/2 = 0,025
%Grados de libertad = 682

%En la tabla, 0,025 el valor infinito es 1.645 este es 1.960

%Luego solo el primer T_c es significativo dado que este es mayor que el 
%valor de tabla

tabla1 = table(t_c1,t_c2,t_c3)

%%
%Realice una correlación con desfase considerando 5 años como el desfase 
% máximo, presentar en un gráfico todas las correlaciones calculadas, 
% además presentar la mayor correlación y su desfase correspondiente.
% Finalmente entregar los grados de libertad, T_c y si este es 
% significativo para ese desfase


[r,lags] = xcorr(ST(:,2),SR(:,2),60,'normalized');
[value,posi]= max(r)
lags(posi)

figure()
plot(lags,r,'LineWidth',2)
hold on
plot(lags(posi),value,'*r')
xlabel('Desface [5 años hacia adelante y atras')
ylabel('Correlación')
axis tight
grid minor
legend('Correlación','Correlacion máxima')

% el valor del desface máximo es 
value

t_c=value*sqrt((length(ST(:,2))-2)/(1-value^2)),
%este valor es mayor que el de tabla entre el 0 y 99% por lo que si es 
%significativo


%%
%Se le es entregada 2 matrices de 144x73x366 de UwindAño.mat y VwindAño.mat,
%estos corresponden a componentes U y V del viento anuales. Cree una metodología
%usando MATLAB que le permita obtener las correlaciones entre ambas
%componentes. Muestre el resultado como un campo utilizando el comando contourf(5%)
clear all
load('UwindAño.mat')
load("VwindAño.mat")
a=0;
b=0;
for i= 1:144
    for j = 1:73
        a=a+1;
        b=b+1;
        A(:,a)=U(i,j,:);
        %B(:,a) = V(i,j,:);
    end
end
b=0;
c=0;
for i = 1:10512

    rho_P() = corr(A(:,i),B(:,i),'Type','Pearson'); 
end

%contourf(lon,lat,rho_p)