clc
clear all
close all

A = readmatrix('imaunaloaNaN.dat.dat');

%% Para reemplazar por NaN
[fila,columna] = find(A == -9999);
for i=1:length(columna)
    A(fila(i),columna(i)) = NaN;
end

%% Para poner todos los datos en solo dos columnas
B= [];
count = 0;

for j=1:66
    for i=1:12
        count=count+1;
        B(count,2)=A(j,(i+1));
    end
end

count=0;
for j=1958:2023
    for i=1:12
        count=count+1;
        B(count,1) = j + [i/12-1/24];
    end
end

%% GUIA 3
%Para la funcion polyfit no sirven los NaN
ee = ~isnan(B(:,2)); 
idx = find(ee == 0);
B2 = B;
B2(idx,:) = [];

%% ITEM 1
x = B2(:,1);
y = B2(:,2);
pf1 = polyfit(x,y,1);
pv1 = polyval(pf1,x); 

Error1= pv1 - y;

%% ITEM 2
pf2 = polyfit(x,y,2);
pv2 = polyval(pf2,x);

Error2 = pv2 - y;

%% ITEM 3

figure()
plot(x,y,'-b')
hold on
plot(x,pv1,'-r','LineWidth',2)
legend('Datos totales','Regresion de 1er grado')
xlabel('Tiempo [años]')
ylabel('Concentracion de Co2 [ppm]')

figure ()
plot(x,y,'-b')
hold on
plot(x,pv2,'-m','LineWidth',2)
legend('Datos totales','Regresion de 2er grado')
xlabel('Tiempo [años]')
ylabel('Concentracion de Co2 [ppm]')

%% ITEM 4

%1er grado
figure()
    subplot (3,1,1)
        plot(x,y,'-b','LineWidth',2)
        hold on
        plot(x,pv1,'-r','LineWidth',2)
        legend('Datos totales','Regresion de 1er grado')
        xlabel('Tiempo [años]')
        ylabel('Concentracion de Co2 [ppm]')
    subplot(3,1,2)
        plot(x,Error1,'-r','LineWidth',2)
        xlabel('Tiempo [años]')
        ylabel('Error')
    subplot(3,1,3)
        bar(Error1)

%2do grado
figure()
    subplot (3,1,1)
        plot(x,y,'-b','LineWidth',2)
        hold on
        plot(x,pv2,'-r','LineWidth',2)
        legend('Datos totales','Regresion de 2do grado')
        xlabel('Tiempo [años]')
        ylabel('Concentracion de Co2 [ppm]')
    subplot(3,1,2)
        plot(x,Error2,'-r','LineWidth',2)
        xlabel('Tiempo [años]')
        ylabel('Error')
    subplot(3,1,3)
        bar(Error2)

%% ITEM 5
clear all
load ICE.mat

ee = ~isnan(ICE(:,2));
idx = find(ee == 0);
ICE2=ICE;
ICE2(idx,:) = [];

x = ICE2(:,1); %Fechas sin NaN
v = ICE2(:,2); %Datos sin NaN
xq = ICE(:,1); %Fechas incluyendo NaN

p = interp1(x,v,xq,'spline');

%% item 6
figure()
plot(ICE(:,1),p,'-.r','LineWidth',2)
hold on
plot(ICE(:,1),ICE(:,2),'b','LineWidth',2)
legend('Datos interpolados','Datos totales')
xlabel('Años')
ylabel('Variación del hielo marino')

%% ITEM 8
% xx = B2(:,1);
% vv = B2(:,2);
% xqq = B(:,1);
% 
% pp(:,1) = B(:,2);
% pp(:,2) = interp1(xx,vv,xqq,'linear');
% pp(:,3) = interp1(xx,vv,xqq,'nearest');
% pp(:,4) = interp1(xx,vv,xqq,'next');
% pp(:,5) = interp1(xx,vv,xqq,'previous');
% pp(:,6) = interp1(xx,vv,xqq,'spline');
% pp(:,7) = interp1(xx,vv,xqq,'pchip');
% %p7 = interp1(x1,v1,xq1,'cubic');
% %p8 = interp1(x1,v1,xq1,'v5cubic');
% pp(:,8) = interp1(xx,vv,xqq,'makima');
% 
% for i = 1:8
%     figure(1)
%         subplot(2,4,i)
%             plot(B(:,1),pp(:,i))
% end
% %ITEM 9
% 
% pp1(:,1) = ICE(:,2);
% pp1(:,2) = interp1(x,v,xq,'linear');
% pp1(:,3) = interp1(x,v,xq,'nearest');
% pp1(:,4) = interp1(x,v,xq,'next');
% pp1(:,5) = interp1(x,v,xq,'previous');
% pp1(:,6) = interp1(x,v,xq,'spline');
% pp1(:,7) = interp1(x,v,xq,'pchip');
% %p7 = interp1(x1,v1,xq1,'cubic');
% %p8 = interp1(x1,v1,xq1,'v5cubic');
% pp1(:,8) = interp1(x,v,xq,'makima');
% 
% for i = 1:8
%     figure(2)
%         subplot(2,4,i)
%             plot(ICE(:,1),pp1(:,i))
% end