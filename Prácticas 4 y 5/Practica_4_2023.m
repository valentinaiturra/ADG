clc
clear all
close all

A = readmatrix('imaunaloaNaN.dat.dat');

%% Para reemplazar por NaN
[fila,columna] = find(A == -9999);
for i=1:length(columna)
    A(fila(i),columna(i)) = NaN;
end

A = A(2:end-1,:);
%% INTERPOLACION DE NaN FILA 1973

year = find(A(:,1) == 1973);
A2 = A(year,2:end);

ee = ~isnan(A2);
idx = find(ee == 1);

A3=[];
A3 = A2(idx);

x = idx;
v = A3;
xq = [1:length(A2)];

interrow= interp1(x,v,xq,'linear');

%% INTERPOLACION DE NaN COLUMNA 
B2=A(:,7);

ee = ~isnan(B2);
idx = find(ee == 1);

B3=[];
B3 = B2(idx);

x = idx;
v = B3;
xq = [1:length(B2)];

intercol = interp1(x,v,xq,'linear');
%% Promedio de ambos valores

inter(1,1) = interrow(6);
inter(1,2) = intercol(15);

media= mean(inter);

%% Interpolando un NaN en medio de una matriz

%usamos cinco datos a cada lado del NaN
M = A(11:21,2:12);
M(10,10) = 332.5;

%genera en x 11 lineas con numeros de 1 a 11 y en y 11 columnas de 1 a 11
[col,fila]=meshgrid(1:11,1:11);

ee=~isnan(M);
idx = find(ee == 1);

gd = griddata(col(idx),fila(idx),M(idx),col,fila);

%% INTERPOLANDO TODA LA MATRIZ 

B = A(:,2:13);

[col,fila]=meshgrid((1:12),1:64); 
%ES IMPORTANTE QUE X ES COLUMNAS E Y ES FILAS

ee = ~isnan(B);
idx = find(ee == 1);

gd = griddata(col(idx),fila(idx),B(idx),col,fila);

figure()
    subplot(1,2,1)
        contourf(B)
    subplot(1,2,2)
        contourf(gd)

%% PARA AGREGAR MAS O MENOS DATOS 
[XX,YY] = meshgrid(1:0.5:12,1:0.5:64);

otro= interp2(col,fila,gd,XX,YY);