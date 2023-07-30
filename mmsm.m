function [mm,dem,mediana,Q1,Q3]=mmsm(x,paso,w)
%considerar que x corresponde a los datos, paso es cada cuanto se toman los
%datos y w es la ventana
c=0; 
for i=w:paso:length(x) 
    mm(c+1)=nanmean(x(i-w+1:i)); % media movil
    sm(c+1)=nanstd(x(i-w+1:i)); % std movil
    mediana(c+1)=median(x(i-w+1:i),'omitnan'); % media movil
    Q3(c+1) = prctile(x(i-w+1:i),75);
    Q1(c+1) = prctile(x(i-w+1:i),25);
    c=c+1;
end

mm=mm'; %La comilla encima representa que se traspone la matriz
dem=sm';
mediana = mediana;
end
