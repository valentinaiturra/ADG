function [t_c,s,alfa_med,grad_lib] = tstudent(datos1,datos2,confianza)


N=length(datos1);

a = corr(datos1,datos2);  %Correlacion de dos bases de datos
t_a=a*sqrt(N-2)/sqrt(1-a^2); %Valor de t_c
s_a=a/t_a; %Valor de s

conf=confianza;
alpha = 1 - (conf/100);
alpha_medios = alpha/2;

b = N-2;

t_c=t_a
s=s_a
alfa_med = alpha_medios
grad_lib = b