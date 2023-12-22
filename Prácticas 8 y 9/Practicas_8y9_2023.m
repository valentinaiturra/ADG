clear all
close all
clc
x = [1:50];
y = 2*x + 10;
y_2 = x.^2;

figure()
scatter(x,y)
hold on
scatter(x,y_2)

%Que diferencia las dos nubes de puntos?
    %Una de ella es una funcion exponencial, y la otra es lineal
%Que relacion existe?
    %Funcion lineal tiene  mas cercano a uno y es positiva, la cuadratica
    %es mayor y 
%Que correlacion existe?

%En estadística, el coeficiente de correlación de Pearson es una medida de 
% dependencia lineal entre dos variables aleatorias cuantitativas. 
% A diferencia de la covarianza, la correlación de Pearson es independiente 
% de la escala de medida de las variables.

%Covariana y correlacion se relacionan, pues la correlacion es una medida
%estandarizada de la covarianza
%EL coef de correlacion de pearson solo funciona en funciones lineales, y
%spearman para otro tipo, que sea monotona, en la misma direccion pero no a
%ritmo constante

%TRANSPOSICION
x=x';
y=y';
y_2=y_2';

%rho es coeficiente de correlacion
[rho] = corr(x,y,'Type','Pearson');
[rho2] = corr(x,y_2,'Type','Pearson');  % corr funciona con matrices columnares 

[rho3] = corr(x,y,'Type','Spearman');
[rho4] = corr(x,y_2,'Type','Spearman');

%EL hecho de que de 0-9 es que no se esta usando el metodo correcto
%spearmann es mas sensible a valores escapados, es robusto.

%% Si agregamos outliers
x(51)=-999;
y3=2*x+10;
y4=x.^2;

Pear3=corr(x,y3,'Type','Pearson'); %ecuacion de la recta con outlier; pearson
disp("Coeficiente de correlación:");
disp(Pear3);

Pear4=corr(x,y4,'Type','Pearson'); % ecuacion cuadratica con outlier: pearson
disp("Coeficiente de correlación:");
disp(Pear4);

Sp3=corr(x,y3,'Type','Spearman'); % ecuacion de la recta con outlier; spearman
disp("Coeficiente de correlación:");
disp(Sp3);

Sp4=corr(x,y4,'Type','Spearman'); % ecuacion cuadratica con outlier; spearman 
disp("Coeficiente de correlación:");
disp(Sp4);


%% MANEJO DE DATOS
clear all
load('CALOR.mat')
load('N34.mat')
load('swl.mat')

%Niño 34, promedio trimestral de anomalias de temperatura

%%
%Grafique las 3 bases de datos entregadas con respecto al tiempo en una 
% misma figura pero en distintos gráficos (subplot). Procure que el 
% gráfico se presente de buena manera. 

figure()
subplot(3,1,1)
    plot(Calor(:,1),Calor(:,2),'LineWidth',2)
    xlabel('Tiempo [años]')
    ylabel('Calor [x10^{22} Joule]')
    axis tight
    title('Energía contenida en los primeros 700 metros del mar')
subplot(3,1,2)
    plot(Mar(:,1),Mar(:,2),'LineWidth',2,'Color','r')
    xlabel('Tiempo [años]')
    ylabel('Nivel del mar [metros]')
    axis tight
    title('Nivel del mar promedio')
subplot(3,1,3)
    plot(Nino(:,1),Nino(:,2),'LineWidth',2,'Color','y')
    xlabel('Tiempo [años]')
    ylabel('Temperatura [°C]')
    axis tight
    title('Anomalía de temperatura debido al fenómeno del niño')
%segundo y tercero tienen tendencia al aumento,por lo que tienen mas relacion

%% b) Genere diagramas de dispersión (scatter) entre N34 y el calor, 
% N34 y el nivel del mar promedio y calor junto a nivel del mar promedio.
% Comente lo observado
figure()
subplot(3,1,1)
    scatter(Nino(:,2),Calor(:,2),'filled')
    axis tight
    grid minor 
    xlabel('N34')
    ylabel('Calor')
subplot(3,1,2)
    scatter(Nino(:,2),Mar(:,2),'filled')
    axis tight
    grid minor
    xlabel('N34')
    ylabel('Nivel del mar promedio')
subplot(3,1,3)
    scatter(Calor(:,2),Mar(:,2),'filled')
    xlabel('Calor')
ylabel('Nivel del mar promedio')
    axis tight
    grid minor 
    
%% c) Calcule las correlaciones entre las series graficadas en b)

a= corr(Nino(:,2),Calor(:,2)); 
b= corr(Nino(:,2),Mar(:,2));
c= corr(Calor(:,2),Mar(:,2));

%% d) ¿Qué sucede con las correlaciones al extraer la tendencia de los datos? 
a1= corr(detrend(Nino(:,2)),detrend(Calor(:,2))); 
b1= corr(detrend(Nino(:,2)),detrend(Mar(:,2)));
c1= corr(detrend(Calor(:,2)),detrend(Mar(:,2)));

    %Se puede saber si la tendencia influye en los datos al quitarle la
    %tendencia (detrend) y usar corr nuevamente, si el valor aumenta mucho,
    %quiere decir que la tendencia si influia mucho en los datos, viceversa
    %si la correlacon disminuye, quiere decir que la correlacion no es tan
    %correcgta, puede ser que la correlacion se aumenta si hay pendiente,
    %pero NO significa que esta sea correcta.

    %% 
% PAra ver si una correlacion es significativa se utiliza el coeficiente de 
% determinacion elevado a dos

%método más simple para corroborar que el coeficiente de correlación sea 
% significativo es ocupando el Test de Student,

%PARA CADA correlacion a.b.c T, y para un nivel de confianza de 98% verificar 
% si la correlación es significativa

N=length(Nino); % las tres series tienen el mismo largo, podemos usar cualquiera

t_a=a*sqrt((N-2)/(1-a^2));
t_b=b*sqrt((N-2)/(1-b^2));
t_ca=c*sqrt((N-2)/(1-c^2));

conf=98;
alpha = conf/100 - 1;
alpha_medios = abs(alpha/2);
% Alfa/2 es igual a 0.01, se ocupa la quinta columna de la imagen
%El valor en tabla es 2.3263, luego T_c es la unica significativa pues el
%valor absoluto es mayor que el de tabla! (si fuera menor no seria
%significativo

%% Calcular S para los tres casos

s_a=a/t_a;
s_b=b/t_b;
s_c=c/t_ca;

%% AHORA con una nueva base de datos
clear all
calor = load('CALOR_M_19552014.dat');

figure % Graficos meses Junio y Diciembre
plot(calor(:,1),calor(:,7),'linewidth',2) % Línea de ancho dos
hold on
plot(calor(:,1),calor(:,13),'linewidth',2)
legend('Junio','Diciembre','Location','best') % leyenda no tapa los datos
xlabel('Años','FontSize',15,'FontWeight','bold')
ylabel('Calor','FontSize',15,'FontWeight','bold')
title('Calor contenido en los primeros 700 m del mar','FontSize',16)
grid minor
xlim tight % No quedan espacios en blanco

%% Entre ambos se hará la correlacion Junio y Diciembre

rho=corr(calor(:,7),calor(:,13));
t_ca=rho*sqrt((length(calor(:,2))-2)/(1-rho^2));
s_a=rho/t_ca;
%tenemos 57 grados de libertad, buscamos en la tabla y vemos que todos los valores son inferiores a t_c 
% El nivel de confianza tiende a un 100%

%% Ahora sin tendencia

figure % Graficamos
plot(calor(:,1),detrend(calor(:,7)),'linewidth',2)
hold on
plot(calor(:,1),detrend(calor(:,13)),'linewidth',2)
legend('Junio','Diciembre','Location','best')
xlabel('Años','FontSize',15,'FontWeight','bold')
ylabel('Calor','FontSize',15,'FontWeight','bold')
title('Serie de Tiempo sin tendencia','FontSize',16)
grid minor
xlim tight

% Calculamos rho, t y s:
rho_ST=corr(detrend(calor(:,7)),detrend(calor(:,13)));
t_ST=rho_ST*sqrt((length(calor)-2)/(1-rho_ST^2));
s_ST=rho_ST/t_ST;

%Al quitar la tendencia desaparece un factor que las dos series tenían en 
% común (el calentamiento global), entonces la correlación decae.
%A pesar de que la correlación ahora es menor, esta sigue siendo 
% significativa para un intervalo de confianza mayor al 99%.