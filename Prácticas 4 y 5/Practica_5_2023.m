%interpolacion por pesos significa que se ponen pesos a los valores
%cercanos al NaN y menos peso a los que estan mas lejos de este valor pues
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

B = B(3:782,:);

%% 
datos = B(:,2);
ee = ~isnan(datos);
m = find(ee == 0);

for i = 1 : length(m)
    vca = B(m(i)-1,2); %Valor cercano arriba
    vcb = B(m(i)+1,2); %Valor cercano abajo
    mediac = (vca+vcb)/2;
    peso1 = mediac * 0.7;

    vla = B(m(i)-12,2); %Valor lejano arriba
    vlb = B(m(i)+12,2); %Valor lejano abajo
    medial = (vla+vlb)/2;
    peso2 = medial * 0.3;

    dato = peso1 + peso2;

    B(m(i),2) = dato;
end

peso1 = 0.7;
peso2 = 0.3;
for i=1:length(m) %el i correrá por todo el largo de m 
    if m>12 
        datos(m(i))=nanmean([datos(m(i)-1),datos(m(i)+1)])*peso1; %le asigna el primer peso a los valores contiguos (el anterior y el posterior), omitiendo los NaN, es decir si tengo valores contiguos de NaN los omite, por ejemplo si arriba tengo 4 y abajo tengo un NaN, el NaN lo omite y le asigna el peso a 4
        datos(m(i))=datos(m(i))+nanmean([datos(m(i)-12),datos(m(i)+12)])*peso2; %le asigna el segundo peso a los 12 meses anteriores y a los 12 posteriores, también omitiendo los NaN (análogo a lo anterior)
    else
        datos(m(i))=nanmean([datos(m(i)-1),datos(m(i)+1)])*peso1; %análogo a lo anterior, le asigna el primer peso a los valores contiguos 
        datos(m(i))=(datos(m(i))+datos(m(i)+12))*peso2; %por ejemplo si tengo la posición 2, no puedo asignarle pesos a los 12 meses anteriores, entonces le asignará el peso 2 a la posición 2 más 12 meses después 
    end

end 

