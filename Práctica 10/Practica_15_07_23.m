clear all
close all

load nino.mat
load mar.mat
load calor2.mat
%% Ejercicio 1. Hacer correlación con desfase considerando de 1 a 3 meses entre calor y el niño

corr_sindesfase = corr(Calor(1:408,2),Nino(1:408,2)); 
desfase_1mes = corr(Calor(1:407,2),Nino(2:408,2));
desfase_2mes = corr(Calor(1:406,2),Nino(3:408,2));
desfase_3mes = corr(Calor(1:405,2),Nino(4:408,2));

%% Ejercicio 2. Hacer correlación considerando 1 a 3 años considerando la serie nivel del mar y niño

nino_c = Nino(277:end,:); %cortamos la serie de El niño para que empieze del 2003 y tengan el mismo largo
desfase_1anio = corr(Mar(1:120,2),nino_c(13:end,2));
desfase_2anio  = corr(Mar(1:108,2),nino_c(25:end,2));
desfase_3anio = corr(Mar(1:96,2),nino_c(37:end,2));

%% Ejercicio 3. Graficar series con desfase y sin desfase
t = [2004:2013];
t2 = string(t);
figure
subplot 221
plot(1:132,normalize(Mar(:,2)),'r','LineWidth',2) %graficamos con solamente con un vector del largo de nuestra serie
hold on
plot(1:132,normalize(nino_c(:,2)),'b','LineWidth',2)
axis tight
xticks([13:12:132]) % cambiamos los nombres los ticks para que sea coherente con lo que estamos viendo
xticklabels(t2)
grid minor
xlabel('Tiempo')
ylabel('Magnitud')
title('El Niño y nivel del mar sin desfase')
leg1=legend('Nivel del mar','Niño 34',Location='best')
set(leg1,'Box','off')

subplot 222
plot(1:120,normalize(Mar(1:120,2)),'r','LineWidth',2)
hold on
plot(1:120,normalize(nino_c(13:end,2)),'b','LineWidth',2)
axis tight
xticks([13:12:120]) % cambiamos los nombres los ticks para que sea coherente con lo que estamos viendo
xticklabels(t2)
grid minor
xlabel('Tiempo')
ylabel('Magnitud')
title('El Niño y nivel del mar desfase 1 años')
leg1=legend('Nivel del mar','Niño 34',Location='best')
set(leg1,'Box','off')


subplot 223
plot(1:108,normalize(Mar(1:108,2)),'r','LineWidth',2)
hold on
plot(1:108,normalize(nino_c(25:end,2)),'b','LineWidth',2)
axis tight
xticks([13:12:108]) % cambiamos los nombres los ticks para que sea coherente con lo que estamos viendo
xticklabels(t2)
grid minor
xlabel('Tiempo')
ylabel('Magnitud')
title('El Niño y nivel del mar desfase 2 años')
leg1=legend('Nivel del mar','Niño 34',Location='best')
set(leg1,'Box','off')


subplot 224
plot(1:96,normalize(Mar(1:96,2)),'r','LineWidth',2)
hold on
plot(1:96,normalize(nino_c(37:end,2)),'b','LineWidth',2)
axis tight
xticks([13:12:96]) % cambiamos los nombres los ticks para que sea coherente con lo que estamos viendo
xticklabels(t2)
grid minor
xlabel('Tiempo')
ylabel('Magnitud')
title('El Niño y nivel del mar desfase 3 años')
leg1=legend('Nivel del mar','Niño 34',Location='best')
set(leg1,'Box','off')
%% Ejercicio 4. Obtener todas las correlaciones usando comando xcorr y graficar los resultados (serie niño y calor)

[corr_des lag] = xcorr(Calor(:,2),Nino(:,2),'normalized');

figure
plot(lag,corr_des,'LineWidth',1.5)
xlabel('Desfase')
ylabel('Correlación')
axis tight
grid minor
title('Correlación con desfase máximo posible')
%% Ejercicio 5. 
a = max(corr_des);
b = min(corr_des); %buscamos las mayores correlaciones (positivo y negativo)

if abs(a)>abs(b)
    idx = find(corr_des == a);
    lag_max = lag(idx);
    mayor_correlacion = a;
elseif abs(b)>abs(a)
    idx = find(corr_des == b);
    lag_max = lag(idx); 
    mayor_correlacion = b;
                        %aqui buscamos el valor de la mayor correlacion y el lag en donde se encuentra
end                     %tambien se puede ver directamente si la correlación negativa o positiva es mayor 
                        % este es solo un modo "automatico" de buscar la
                        % mayor correlación 

%% Ejercicio 6. Obtener todas las correlaciones con desfase, con un desfase maximo de 10 años

[corr_des10anios lag10anios] = xcorr(Calor(:,2),Nino(:,2),'normalized',120);

figure
plot(lag10anios,corr_des10anios,'LineWidth',1.5)
xlabel('Desfase')
ylabel('Correlación')
axis tight
grid minor
title('Correlación con desfase máximo de 10 años')

%% muestra de valores
A = ['La mayor correlación es ' , num2str(mayor_correlacion)]
B = ['El desfase de la mayor correlación es ' , num2str(lag_max)]
disp(A)
disp(B)